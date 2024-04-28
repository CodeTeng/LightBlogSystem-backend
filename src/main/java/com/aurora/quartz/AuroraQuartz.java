package com.aurora.quartz;

import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.RandomUtil;
import com.alibaba.fastjson.JSON;
import com.aurora.model.dto.ArticleSearchDTO;
import com.aurora.model.dto.UserAreaDTO;
import com.aurora.entity.*;
import com.aurora.mapper.ElasticsearchMapper;
import com.aurora.mapper.UniqueViewMapper;
import com.aurora.mapper.UserAuthMapper;
import com.aurora.service.*;
import com.aurora.util.BeanCopyUtil;
import com.aurora.util.HTMLUtil;
import com.aurora.util.IpUtil;
import com.aurora.util.MarkdownToHtmlUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

import static com.aurora.constant.CommonConstant.UNKNOWN;
import static com.aurora.constant.RedisConstant.*;

@Slf4j
@Component("auroraQuartz")
public class AuroraQuartz {
    @Autowired
    private RedisService redisService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private JobLogService jobLogService;

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private RoleResourceService roleResourceService;

    @Autowired
    private UniqueViewMapper uniqueViewMapper;

    @Autowired
    private UserAuthMapper userAuthMapper;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private ElasticsearchMapper elasticsearchMapper;

    @Value("${website.url}")
    private String websiteUrl;

    private List<String> htmlStructureStr = Arrays.asList(
            "<h1", "<h2", "<h3", "<h4", "<h5", "<ol", "<li"
    );

    public void saveUniqueView() {
        Long count = redisService.sSize(UNIQUE_VISITOR);
        UniqueView uniqueView = UniqueView.builder()
                .createTime(LocalDateTimeUtil.offset(LocalDateTime.now(), -1, ChronoUnit.DAYS))
                .viewsCount(Optional.of(count.intValue()).orElse(0))
                .build();
        uniqueViewMapper.insert(uniqueView);
    }

    public void clear() {
        redisService.del(UNIQUE_VISITOR);
        redisService.del(VISITOR_AREA);
    }

    public void statisticalUserArea() {
        Map<String, Long> userAreaMap = userAuthMapper.selectList(new LambdaQueryWrapper<UserAuth>().select(UserAuth::getIpSource))
                .stream()
                .map(item -> {
                    if (Objects.nonNull(item) && StringUtils.isNotBlank(item.getIpSource())) {
                        return IpUtil.getIpProvince(item.getIpSource());
                    }
                    return UNKNOWN;
                })
                .collect(Collectors.groupingBy(item -> item, Collectors.counting()));
        List<UserAreaDTO> userAreaList = userAreaMap.entrySet().stream()
                .map(item -> UserAreaDTO.builder()
                        .name(item.getKey())
                        .value(item.getValue())
                        .build())
                .collect(Collectors.toList());
        redisService.set(USER_AREA, JSON.toJSONString(userAreaList));
    }

    public void computerHotArticle() {
        log.info("预测热点文章开始");
        // 1. 获取所有的文章 过滤掉已经在 redis 前5的热点文章
        List<Article> articleList = articleService.list();
        Map<Object, Double> articleMap = redisService.zReverseRangeWithScore(ARTICLE_VIEWS_COUNT, 0, 4);
        List<Integer> articleIds = new ArrayList<>(articleMap.size());
        articleMap.forEach((key, value) -> articleIds.add((Integer) key));
        articleList = articleList.stream().filter(article -> !articleIds.contains(article.getId())).collect(Collectors.toList());
        if (articleList.isEmpty()) {
            log.info("文章都为热点文章的前5，无需预测");
            return;
        }
        // 2. 计算每一个博文的得分
        Map<Integer, Double> articleScoreMap = new HashMap<>(articleList.size());
        for (Article article : articleList) {
            // 事先加上标签和分类的得分 方便
            Double accumulateScore = 5D;
            Double subtractScore = 0D;
            String articleContent = article.getArticleContent();
            if (articleContent.length() > 100000 || articleContent.length() < 1500) {
                articleScoreMap.put(article.getId(), 60D);
                continue;
            }
            // 判断文章的标题和摘要是否包含敏感词
            String articleTitle = article.getArticleTitle();
            String articleAbstract = article.getArticleAbstract();
            if (HTMLUtil.isSensitiveWord(articleTitle) || HTMLUtil.isSensitiveWord(articleAbstract) || HTMLUtil.isSensitiveWord(articleContent)) {
                articleScoreMap.put(article.getId(), 0D);
                continue;
            }
            accumulateScore += 20D; // 无敏感词
            Integer isFeatured = article.getIsFeatured();
            Integer isTop = article.getIsTop();
            Integer type = article.getType();
            if (isFeatured.equals(1)) {
                accumulateScore += 15D;
            }
            if (isTop.equals(1)) {
                accumulateScore += 15D;
            }
            if (type.equals(1)) {
                accumulateScore += 5D;
            }
            // 内容得分 投个懒吧 使用随机数判定
            accumulateScore += RandomUtil.randomDouble(32D, 40D);
            // 结构得分 将 markdown 转为 html
            String htmlContent = MarkdownToHtmlUtil.markdownToHtml(articleContent);
            // 简单点判断
            boolean isStructure = false;
            for (String structure : htmlStructureStr) {
                if (htmlContent.contains(structure)) {
                    isStructure = true;
                    accumulateScore += 10D;
                    break;
                }
            }
            if (!isStructure) subtractScore += 10D;
            articleScoreMap.put(article.getId(), accumulateScore - subtractScore);
        }
        // 3. 得分超过 90 的存入 redis 中，得分为redis中所有文章得分的平均分
        // 获取所有文章的平均分
        Map<Object, Double> doubleMap = redisService.zAllScore(ARTICLE_VIEWS_COUNT);
        Double sumScore = 0D;
        if (doubleMap != null && !doubleMap.isEmpty()) {
            for (Double value : doubleMap.values()) {
                sumScore += value;
            }
        }
        for (Map.Entry<Integer, Double> entry : articleScoreMap.entrySet()) {
            Integer articleId = entry.getKey();
            Double score = entry.getValue();
            if (score >= 90) {
                // 存入redis
                if (!doubleMap.isEmpty()) {
                    Double finalScore = score * 0.5 + (sumScore / doubleMap.size()) * 0.5;
                    articleService.updateArticleScore(articleId, finalScore);
                } else {
                    // 还没有热点文章 就存入目前的得分
                    articleService.updateArticleScore(articleId, score);
                }
            }
        }
        log.info("预测热点文章结束");
    }

    public void baiduSeo() {
        List<Integer> ids = articleService.list().stream().map(Article::getId).collect(Collectors.toList());
        HttpHeaders headers = new HttpHeaders();
        headers.add("Host", "data.zz.baidu.com");
        headers.add("User-Agent", "curl/7.12.1");
        headers.add("Content-Length", "83");
        headers.add("Content-Type", "text/plain");
        ids.forEach(item -> {
            String url = websiteUrl + "/articles/" + item;
            HttpEntity<String> entity = new HttpEntity<>(url, headers);
            restTemplate.postForObject("https://www.baidu.com", entity, String.class);
        });
    }

    public void clearJobLogs() {
        jobLogService.cleanJobLogs();
    }

    public void importSwagger() {
        resourceService.importSwagger();
        List<Integer> resourceIds = resourceService.list().stream().map(Resource::getId).collect(Collectors.toList());
        List<RoleResource> roleResources = new ArrayList<>();
        for (Integer resourceId : resourceIds) {
            roleResources.add(RoleResource.builder()
                    .roleId(1)
                    .resourceId(resourceId)
                    .build());
        }
        roleResourceService.saveBatch(roleResources);
    }

    public void importDataIntoES() {
        elasticsearchMapper.deleteAll();
        List<Article> articles = articleService.list();
        for (Article article : articles) {
            elasticsearchMapper.save(BeanCopyUtil.copyObject(article, ArticleSearchDTO.class));
        }
    }
}
