package com.aurora.service.impl;

import com.alibaba.fastjson.JSON;
import com.aurora.config.cf.CfConstant;
import com.aurora.config.cf.DisValue;
import com.aurora.config.cf.RecommendUtil;
import com.aurora.entity.*;
import com.aurora.enums.ArticleReviewEnum;
import com.aurora.enums.ArticleStatusEnum;
import com.aurora.mapper.*;
import com.aurora.model.dto.*;
import com.aurora.enums.FileExtEnum;
import com.aurora.enums.FilePathEnum;
import com.aurora.exception.BizException;
import com.aurora.service.*;
import com.aurora.strategy.context.SearchStrategyContext;
import com.aurora.strategy.context.UploadStrategyContext;
import com.aurora.util.BeanCopyUtil;
import com.aurora.util.PageUtil;
import com.aurora.util.ScanTextUtil;
import com.aurora.util.UserUtil;
import com.aurora.model.vo.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageProperties;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import static com.aurora.constant.CommonConstant.FALSE;
import static com.aurora.constant.CommonConstant.TRUE;
import static com.aurora.constant.RabbitMQConstant.SUBSCRIBE_EXCHANGE;
import static com.aurora.constant.RedisConstant.*;
import static com.aurora.enums.ArticleStatusEnum.*;
import static com.aurora.enums.StatusCodeEnum.ARTICLE_ACCESS_FAIL;

@Service
@Slf4j
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ArticleTagMapper articleTagMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private TagService tagService;

    @Autowired
    private ArticleTagService articleTagService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private UploadStrategyContext uploadStrategyContext;

    @Autowired
    private SearchStrategyContext searchStrategyContext;

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private ScanTextUtil scanTextUtil;

    @Autowired
    private ArticleScoreService articleScoreService;

    @SneakyThrows
    @Override
    public TopAndFeaturedArticlesDTO listTopAndFeaturedArticles() {
        TopAndFeaturedArticlesDTO topAndFeaturedArticlesDTO = new TopAndFeaturedArticlesDTO();
        // 从 redis中获取TOP10热点文章
        Map<Object, Double> articleMap = redisService.zReverseRangeWithScore(ARTICLE_VIEWS_COUNT, 0, 9);
        if (articleMap == null || articleMap.isEmpty()) {
            topAndFeaturedArticlesDTO.setHotArticles(new ArrayList<>());
        } else {
            List<Integer> articleIds = new ArrayList<>(articleMap.size());
            articleMap.entrySet().stream()
                    .sorted(Map.Entry.<Object, Double>comparingByValue().reversed())
                    .forEach(entry -> articleIds.add((Integer) entry.getKey()));
//            articleMap.forEach((key, value) -> articleIds.add((Integer) key));
            // 根据 articleIds 中的顺序 查出文章列表
//            List<Article> articleList = articleMapper.selectList(new LambdaQueryWrapper<Article>()
//                    .eq(Article::getIsDelete, 0).eq(Article::getReview, 1)
//                    .in(Article::getStatus, 1, 2)
//                    .in(Article::getId, articleIds));
            // 修改为顺序
            List<Article> dbArticleList = articleMapper.selectList(new LambdaQueryWrapper<Article>()
                    .eq(Article::getIsDelete, 0).eq(Article::getReview, 1)
                    .in(Article::getStatus, 1, 2));
            List<Article> articleList = new ArrayList<>(articleIds.size());
            articleIds.forEach(id -> {
                Article article = dbArticleList.stream().filter(item -> item.getId().equals(id)).findFirst().orElse(null);
                if (article != null) {
                    articleList.add(article);
                }
            });
            List<ArticleCardDTO> hotArticles = new ArrayList<>(articleList.size());
            if (!articleList.isEmpty()) {
                hotArticles = articleList.stream().map(article -> {
                    ArticleCardDTO articleCardDTO = BeanCopyUtil.copyObject(article, ArticleCardDTO.class);
                    UserInfo userInfo = userInfoMapper.selectById(article.getUserId());
                    if (userInfo != null) {
                        articleCardDTO.setAuthor(userInfo);
                    }
                    Category category = categoryMapper.selectById(article.getCategoryId());
                    if (category != null) {
                        articleCardDTO.setCategoryName(category.getCategoryName());
                    }
                    List<Tag> tags = tagMapper.listTagByArticleId(article.getId());
                    articleCardDTO.setTags(tags);
                    return articleCardDTO;
                }).collect(Collectors.toList());
            }
            topAndFeaturedArticlesDTO.setHotArticles(hotArticles);
        }
        List<ArticleCardDTO> articleCardDTOs = articleMapper.listTopAndFeaturedArticles();
        if (articleCardDTOs.isEmpty()) {
            return topAndFeaturedArticlesDTO;
        } else if (articleCardDTOs.size() > 3) {
            articleCardDTOs = articleCardDTOs.subList(0, 3);
        }
        topAndFeaturedArticlesDTO.setTopArticle(articleCardDTOs.get(0));


        // 获得推荐文章Id
        boolean notLogin = UserUtil.getAuthentication().getPrincipal().toString().equals("anonymousUser");

        if (notLogin) {
            // 获得分数最高的两个文章
            List<ArticleCardDTO> articleCardDTOS = articleMapper.selectTopTenArticleCardsByScore();
            topAndFeaturedArticlesDTO.setFeaturedArticles(articleCardDTOS.subList(0, 2));
        } else {
            //
            LambdaQueryWrapper<ArticleScore> countWrapper = new LambdaQueryWrapper<>();
            countWrapper.eq(ArticleScore::getUserId, UserUtil.getUserDetailsDTO().getUserInfoId());
            int count = articleScoreService.count(countWrapper);
            if (count <= 2) {
                // 获得分数最高的两个文章
                List<ArticleCardDTO> articleCardDTOS = articleMapper.selectTopTenArticleCardsByScore();
                topAndFeaturedArticlesDTO.setFeaturedArticles(articleCardDTOS.subList(0, 2));
            } else {
                List<ArticleScore> list = articleScoreService.list();
                Long userId = Long.valueOf(UserUtil.getUserDetailsDTO().getUserInfoId());
                // 获得的用户列表
                List<DisValue> recommends = RecommendUtil.recommend(userId, list, CfConstant.User_CF_TYPE);
                Long articleId1 = articleScoreService.lambdaQuery()
                        .eq(ArticleScore::getUserId, recommends.get(0).getKeyId())
                        .orderByDesc(ArticleScore::getScore)
                        .list().get(0).getArticleId();
                Long articleId2 = articleScoreService.lambdaQuery()
                        .eq(ArticleScore::getUserId, recommends.get(1).getKeyId())
                        .orderByDesc(ArticleScore::getScore)
                        .list().get(0).getArticleId();
                ArticleCardDTO article1 = articleMapper.getArticleCardById(Math.toIntExact(articleId1));
                ArticleCardDTO article2 = articleMapper.getArticleCardById(Math.toIntExact(articleId2));
                List<ArticleCardDTO> featuredArticles = new ArrayList<>(2);
                featuredArticles.add(article1);
                featuredArticles.add(article2);
                topAndFeaturedArticlesDTO.setFeaturedArticles(featuredArticles);
            }
        }

        return topAndFeaturedArticlesDTO;
    }

    @SneakyThrows
    @Override
    public PageResultDTO<ArticleCardDTO> listArticles() {
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<Article>()
                .eq(Article::getIsDelete, 0)
                .in(Article::getStatus, 1, 2)
                .eq(Article::getReview, ArticleReviewEnum.OK_REVIEW.getReview());
        CompletableFuture<Integer> asyncCount = CompletableFuture.supplyAsync(() -> articleMapper.selectCount(queryWrapper));
        List<ArticleCardDTO> articles = articleMapper.listArticles(PageUtil.getLimitCurrent(), PageUtil.getSize());
        return new PageResultDTO<>(articles, asyncCount.get());
    }

    @SneakyThrows
    @Override
    public PageResultDTO<ArticleCardDTO> listArticlesByCategoryId(Integer categoryId) {
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<Article>()
                .eq(Article::getCategoryId, categoryId)
                .eq(Article::getReview, ArticleReviewEnum.OK_REVIEW.getReview());
        CompletableFuture<Integer> asyncCount = CompletableFuture.supplyAsync(() -> articleMapper.selectCount(queryWrapper));
        List<ArticleCardDTO> articles = articleMapper.getArticlesByCategoryId(PageUtil.getLimitCurrent(), PageUtil.getSize(), categoryId);
        return new PageResultDTO<>(articles, asyncCount.get());
    }

    @SneakyThrows
    @Override
    public ArticleDTO getArticleById(Integer articleId) {
        Article articleForCheck = articleMapper.selectOne(new LambdaQueryWrapper<Article>().eq(Article::getId, articleId));
        if (Objects.isNull(articleForCheck)) {
            return null;
        }
        // 未通过审核
        if (articleForCheck.getReview() == 0) {
            return null;
        }
        //
        boolean notLogin = UserUtil.getAuthentication().getPrincipal().toString().equals("anonymousUser");
        if (notLogin) {
            Boolean isAccess;
            try {
                isAccess = redisService.sIsMember(ARTICLE_ACCESS + UserUtil.getUserDetailsDTO().getId(), articleId);
            } catch (Exception exception) {
                throw new BizException(ARTICLE_ACCESS_FAIL);
            }
            if (isAccess.equals(false)) {
                throw new BizException(ARTICLE_ACCESS_FAIL);
            }
        } else {
            boolean isLoginUser = articleForCheck.getUserId().equals(UserUtil.getUserDetailsDTO().getUserInfoId());
            if (articleForCheck.getStatus().equals(2) && !isLoginUser) {
                Boolean isAccess;
                try {
                    isAccess = redisService.sIsMember(ARTICLE_ACCESS + UserUtil.getUserDetailsDTO().getId(), articleId);
                } catch (Exception exception) {
                    throw new BizException(ARTICLE_ACCESS_FAIL);
                }
                if (isAccess.equals(false)) {
                    throw new BizException(ARTICLE_ACCESS_FAIL);
                }
            }
        }


        updateArticleScore(articleId, 1D);
        CompletableFuture<ArticleDTO> asyncArticle = CompletableFuture.supplyAsync(() -> articleMapper.getArticleById(articleId));
        CompletableFuture<ArticleCardDTO> asyncPreArticle = CompletableFuture.supplyAsync(() -> {
            ArticleCardDTO preArticle = articleMapper.getPreArticleById(articleId);
            if (Objects.isNull(preArticle)) {
                preArticle = articleMapper.getLastArticle();
            }
            return preArticle;
        });
        CompletableFuture<ArticleCardDTO> asyncNextArticle = CompletableFuture.supplyAsync(() -> {
            ArticleCardDTO nextArticle = articleMapper.getNextArticleById(articleId);
            if (Objects.isNull(nextArticle)) {
                nextArticle = articleMapper.getFirstArticle();
            }
            return nextArticle;
        });
        ArticleDTO article = asyncArticle.get();
        if (Objects.isNull(article)) {
            return null;
        }
        Double score = redisService.zScore(ARTICLE_VIEWS_COUNT, articleId);
        if (Objects.nonNull(score)) {
            article.setViewCount(score.intValue());
        }
        article.setPreArticleCard(asyncPreArticle.get());
        article.setNextArticleCard(asyncNextArticle.get());
        article.getAuthor().setId(articleForCheck.getUserId());
        return article;
    }

    @Override
    public void accessArticle(ArticlePasswordVO articlePasswordVO) {
        Article article = articleMapper.selectOne(new LambdaQueryWrapper<Article>().eq(Article::getId, articlePasswordVO.getArticleId()));
        if (Objects.isNull(article)) {
            throw new BizException("文章不存在");
        }
        if (article.getPassword().equals(articlePasswordVO.getArticlePassword())) {
            redisService.sAdd(ARTICLE_ACCESS + UserUtil.getUserDetailsDTO().getId(), articlePasswordVO.getArticleId());
        } else {
            throw new BizException("密码错误");
        }
    }

    @SneakyThrows
    @Override
    public PageResultDTO<ArticleCardDTO> listArticlesByTagId(Integer tagId) {
        // 获取通过审核的文章的数量
        Integer count = articleTagMapper.getCountByTagId(tagId);
        List<ArticleCardDTO> articles = articleMapper.listArticlesByTagId(PageUtil.getLimitCurrent(), PageUtil.getSize(), tagId);
        return new PageResultDTO<>(articles, count);
    }

    @SneakyThrows
    @Override
    public PageResultDTO<ArchiveDTO> listArchives() {
        // 获取当前用户信息
        UserDetailsDTO userDetailsDTO = UserUtil.getUserDetailsDTO();
        Integer userInfoId = userDetailsDTO.getUserInfoId();
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<Article>().eq(Article::getIsDelete, 0)
                .eq(Article::getStatus, 1).eq(Article::getUserId, userInfoId);
        CompletableFuture<Integer> asyncCount = CompletableFuture.supplyAsync(() -> articleMapper.selectCount(queryWrapper));
        List<ArticleCardDTO> articles = articleMapper.listArchives(PageUtil.getLimitCurrent(), PageUtil.getSize(), userInfoId);
        HashMap<String, List<ArticleCardDTO>> map = new HashMap<>();
        for (ArticleCardDTO article : articles) {
            LocalDateTime createTime = article.getCreateTime();
            int month = createTime.getMonth().getValue();
            int year = createTime.getYear();
            String key = year + "-" + month;
            if (Objects.isNull(map.get(key))) {
                List<ArticleCardDTO> articleCardDTOS = new ArrayList<>();
                articleCardDTOS.add(article);
                map.put(key, articleCardDTOS);
            } else {
                map.get(key).add(article);
            }
        }
        List<ArchiveDTO> archiveDTOs = new ArrayList<>();
        map.forEach((key, value) -> archiveDTOs.add(ArchiveDTO.builder().Time(key).articles(value).build()));
        archiveDTOs.sort((o1, o2) -> {
            String[] o1s = o1.getTime().split("-");
            String[] o2s = o2.getTime().split("-");
            int o1Year = Integer.parseInt(o1s[0]);
            int o1Month = Integer.parseInt(o1s[1]);
            int o2Year = Integer.parseInt(o2s[0]);
            int o2Month = Integer.parseInt(o2s[1]);
            if (o1Year > o2Year) {
                return -1;
            } else if (o1Year < o2Year) {
                return 1;
            } else return Integer.compare(o2Month, o1Month);
        });
        return new PageResultDTO<>(archiveDTOs, asyncCount.get());
    }

    @SneakyThrows
    @Override
    public PageResultDTO<ArticleAdminDTO> listArticlesAdmin(ConditionVO conditionVO) {
        CompletableFuture<Integer> asyncCount = CompletableFuture.supplyAsync(() -> articleMapper.countArticleAdmins(conditionVO));

        List<ArticleAdminDTO> articleAdminDTOs = articleMapper.listArticlesAdmin(PageUtil.getLimitCurrent(), PageUtil.getSize(), conditionVO);
        Map<Object, Double> viewsCountMap = redisService.zAllScore(ARTICLE_VIEWS_COUNT);
        articleAdminDTOs.forEach(item -> {
            Double viewsCount = viewsCountMap.get(item.getId());
            if (Objects.nonNull(viewsCount)) {
                item.setViewsCount(viewsCount.intValue());
            }
        });
        return new PageResultDTO<>(articleAdminDTOs, asyncCount.get());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveOrUpdateArticle(ArticleVO articleVO) {
        if (articleVO.getIsTop().equals(TRUE)) {
            resetArticleTop(UserUtil.getUserDetailsDTO().getUserInfoId());
        }
        // 保存文章分类
        Category category = saveArticleCategory(articleVO);
        Article article = BeanCopyUtil.copyObject(articleVO, Article.class);
        if (Objects.nonNull(category)) {
            article.setCategoryId(category.getId());
        }
        article.setUserId(UserUtil.getUserDetailsDTO().getUserInfoId());

        // 文章内容自动审核
        Map<String, String> map = scanTextUtil.doScanText(article.getArticleContent());
        if (map != null && Objects.equals(map.get("suggestion"), "pass")) {
            article.setReview(ArticleReviewEnum.OK_REVIEW.getReview());
        }

        // 保存文章
        this.saveOrUpdate(article);
        // 保存文章标签
        saveArticleTag(articleVO, article.getId());
        if (article.getStatus().equals(1)) {
            rabbitTemplate.convertAndSend(SUBSCRIBE_EXCHANGE, "*", new Message(JSON.toJSONBytes(article.getId()), new MessageProperties()));
        }
    }

    @Override
    public void updateArticleTopAndFeatured(ArticleTopFeaturedVO articleTopFeaturedVO) {
        Article select = articleMapper.selectById(articleTopFeaturedVO.getId());
        if (articleTopFeaturedVO.getIsTop().equals(TRUE)) {
            resetArticleTop(select.getUserId());
        }
        Article article = Article.builder()
                .id(articleTopFeaturedVO.getId())
                .isTop(articleTopFeaturedVO.getIsTop())
                .isFeatured(articleTopFeaturedVO.getIsFeatured())
                .build();
        articleMapper.updateById(article);
    }

    @Override
    public void updateArticleDelete(DeleteVO deleteVO) {
        List<Article> articles = deleteVO.getIds().stream()
                .map(id -> Article.builder()
                        .id(id)
                        .isDelete(deleteVO.getIsDelete())
                        .build())
                .collect(Collectors.toList());
        this.updateBatchById(articles);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteArticles(List<Integer> articleIds) {
        articleTagMapper.delete(new LambdaQueryWrapper<ArticleTag>()
                .in(ArticleTag::getArticleId, articleIds));
        articleMapper.deleteBatchIds(articleIds);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ArticleAdminViewDTO getArticleByIdAdmin(Integer articleId) {
        Article article = articleMapper.selectById(articleId);
        Category category = categoryMapper.selectById(article.getCategoryId());
        String categoryName = null;
        if (Objects.nonNull(category)) {
            categoryName = category.getCategoryName();
        }
        List<String> tagNames = tagMapper.listTagNamesByArticleId(articleId);
        ArticleAdminViewDTO articleAdminViewDTO = BeanCopyUtil.copyObject(article, ArticleAdminViewDTO.class);
        articleAdminViewDTO.setCategoryName(categoryName);
        articleAdminViewDTO.setTagNames(tagNames);
        return articleAdminViewDTO;
    }

    @Override
    public List<String> exportArticles(List<Integer> articleIds) {
        List<Article> articles = articleMapper.selectList(new LambdaQueryWrapper<Article>()
                .select(Article::getArticleTitle, Article::getArticleContent)
                .in(Article::getId, articleIds));
        List<String> urls = new ArrayList<>();
        for (Article article : articles) {
            try (ByteArrayInputStream inputStream = new ByteArrayInputStream(article.getArticleContent().getBytes())) {
                String url = uploadStrategyContext.executeUploadStrategy(article.getArticleTitle() + FileExtEnum.MD.getExtName(), inputStream, FilePathEnum.MD.getPath());
                urls.add(url);
            } catch (Exception e) {
                e.printStackTrace();
                throw new BizException("导出文章失败");
            }
        }
        return urls;
    }

    @Override
    public List<ArticleSearchDTO> listArticlesBySearch(ConditionVO condition) {
        return searchStrategyContext.executeSearchStrategy(condition.getKeywords());
    }

    @Override
    public void updateArticleScore(Integer articleId, Double score) {
        redisService.zIncr(ARTICLE_VIEWS_COUNT, articleId, score);
    }

    @Override
    public void articleReview(ArticleReviewVO reviewVO) {
        LambdaUpdateWrapper<Article> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper
                .set(Article::getReview, reviewVO.getReview())
                .eq(Article::getId, reviewVO.getArticleId());
        articleMapper.update(null, updateWrapper);
    }

    private Category saveArticleCategory(ArticleVO articleVO) {
        Category category = categoryMapper.selectOne(new LambdaQueryWrapper<Category>()
                .eq(Category::getCategoryName, articleVO.getCategoryName()));
        if (Objects.isNull(category) && !articleVO.getStatus().equals(DRAFT.getStatus())) {
            category = Category.builder()
                    .categoryName(articleVO.getCategoryName())
                    .build();
            categoryMapper.insert(category);
        }
        return category;
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveArticleTag(ArticleVO articleVO, Integer articleId) {
        if (Objects.nonNull(articleVO.getId())) {
            articleTagMapper.delete(new LambdaQueryWrapper<ArticleTag>()
                    .eq(ArticleTag::getArticleId, articleVO.getId()));
        }
        List<String> tagNames = articleVO.getTagNames();
        if (CollectionUtils.isNotEmpty(tagNames)) {
            List<Tag> existTags = tagService.list(new LambdaQueryWrapper<Tag>()
                    .in(Tag::getTagName, tagNames));
            List<String> existTagNames = existTags.stream()
                    .map(Tag::getTagName)
                    .collect(Collectors.toList());
            List<Integer> existTagIds = existTags.stream()
                    .map(Tag::getId)
                    .collect(Collectors.toList());
            tagNames.removeAll(existTagNames);
            if (CollectionUtils.isNotEmpty(tagNames)) {
                List<Tag> tags = tagNames.stream().map(item -> Tag.builder()
                                .tagName(item)
                                .build())
                        .collect(Collectors.toList());
                tagService.saveBatch(tags);
                List<Integer> tagIds = tags.stream()
                        .map(Tag::getId)
                        .collect(Collectors.toList());
                existTagIds.addAll(tagIds);
            }
            List<ArticleTag> articleTags = existTagIds.stream().map(item -> ArticleTag.builder()
                            .articleId(articleId)
                            .tagId(item)
                            .build())
                    .collect(Collectors.toList());
            articleTagService.saveBatch(articleTags);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveOrUpdateArticleScore(ArticleScoreDTO articleScoreDTO) {
        boolean notLogin = UserUtil.getAuthentication().getPrincipal().toString().equals("anonymousUser");
        if (notLogin) {
            throw new BizException("用户需要登录");
        }

        Long userId = Long.valueOf(UserUtil.getUserDetailsDTO().getUserInfoId());

        ArticleScore articleScore = articleScoreService.lambdaQuery()
                .eq(ArticleScore::getArticleId, articleScoreDTO.getArticleId())
                .eq(ArticleScore::getUserId, userId)
                .one();
        if (Objects.nonNull(articleScore)) {
            // 存在评分
            articleScore.setScore(articleScoreDTO.getScore());
            articleScoreService.updateById(articleScore);
        } else {
            // 添加分数到数据库
            articleScore = new ArticleScore();
            articleScore.setArticleId(articleScoreDTO.getArticleId());
            articleScore.setUserId(userId);
            articleScore.setScore(articleScoreDTO.getScore());
            articleScoreService.save(articleScore);
        }

    }

    @Override
    public Integer getArticleScore(Long articleId) {
        boolean notLogin = UserUtil.getAuthentication().getPrincipal().toString().equals("anonymousUser");
        if (notLogin) return 0;

        Long userId = Long.valueOf(UserUtil.getUserDetailsDTO().getUserInfoId());
        ArticleScore articleScore = articleScoreService.lambdaQuery()
                .eq(ArticleScore::getArticleId, articleId)
                .eq(ArticleScore::getUserId, userId)
                .one();
        if (articleScore == null) {
            return 0;
        }
        return articleScore.getScore();
    }

    @Override
    public PageResultDTO<ArticleCardDTO> listArticlesByUserId(Integer userId) {
        // 判断是否为登录用户在获取文章
        boolean isUserSelf = UserUtil.getUserDetailsDTO().getUserInfoId().equals(userId);
        ArticleCardMap articleCardMap = new ArticleCardMap();
        articleCardMap.setKey("user_id");
        articleCardMap.setValue(Integer.toString(userId));
        List<ArticleCardMap> map = new ArrayList<>();
        map.add(articleCardMap);
        List<ArticleCardDTO> articleCardDTOS = null;
        if (isUserSelf) {
            articleCardDTOS = articleMapper.listArticleCards(PageUtil.getLimitCurrent(), PageUtil.getSize(), false,
                    null, null, map);
        } else {
            // 查看别人的文章
            articleCardDTOS = articleMapper.listArticleCards(PageUtil.getLimitCurrent(), PageUtil.getSize(), false,
                    getStatusList(PUBLIC, SECRET), ArticleReviewEnum.OK_REVIEW.getReview(), map);
        }

        LambdaQueryWrapper<Article> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Article::getUserId, userId);

        if (!isUserSelf) {
            wrapper.in(Article::getStatus, PUBLIC.getStatus(), SECRET.getStatus());
            wrapper.eq(Article::getReview, ArticleReviewEnum.OK_REVIEW.getReview());
        }
        Integer count = articleMapper.selectCount(wrapper);

        return new PageResultDTO<>(articleCardDTOS, count);
    }

    @Override
    public void resetArticleTop(Integer userId) {
        LambdaUpdateWrapper<Article> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Article::getUserId, userId).set(Article::getIsTop, FALSE);
        articleMapper.update(null, wrapper);
    }

    @Override
    public ArticleCardDTO getTopArticleByUserId(Integer userId) {
        LambdaQueryWrapper<Article> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper
                .eq(Article::getUserId, userId)
                .eq(Article::getIsTop, TRUE)
                .eq(Article::getReview, ArticleReviewEnum.OK_REVIEW.getReview());
        List<Article> list = this.list(lambdaQueryWrapper);
        if (list.isEmpty()) {
            log.error("用户({})未设置置顶文章", userId);
            return null;
        }
        ;
        return articleMapper.getArticleCardById(list.get(0).getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateArticleCardInfo(ArticleCardDTO cardDTO) {
        if (cardDTO.getId() == null) throw new BizException("文章id不能为空");
        Article article = new Article();
        if (cardDTO.getIsTop().equals(1)) {
            this.lambdaUpdate().set(Article::getIsTop, FALSE).eq(Article::getUserId, UserUtil.getUserDetailsDTO().getUserInfoId()).update();
        }
        article.setIsTop(cardDTO.getIsTop());
        article.setIsFeatured(cardDTO.getIsFeatured());
        article.setId(cardDTO.getId());
        article.setStatus(cardDTO.getStatus());
        return this.updateById(article);
    }
}