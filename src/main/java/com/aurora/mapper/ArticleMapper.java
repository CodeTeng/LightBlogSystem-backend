package com.aurora.mapper;

import com.aurora.model.dto.*;
import com.aurora.entity.Article;
import com.aurora.model.vo.ConditionVO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface ArticleMapper extends BaseMapper<Article> {

    ArticleCardDTO getArticleCardById(@Param("articleId") Integer articleId);

    List<ArticleCardDTO> listTopAndFeaturedArticles();

    List<ArticleCardDTO> listArticles(@Param("current") Long current, @Param("size") Long size);

    List<ArticleCardDTO> getArticlesByCategoryId(@Param("current") Long current, @Param("size") Long size, @Param("categoryId") Integer categoryId);

    ArticleDTO getArticleById(@Param("articleId") Integer articleId);

    ArticleCardDTO getPreArticleById(@Param("articleId") Integer articleId);

    ArticleCardDTO getNextArticleById(@Param("articleId") Integer articleId);

    ArticleCardDTO getFirstArticle();

    ArticleCardDTO getLastArticle();

    List<ArticleCardDTO> listArticlesByTagId(@Param("current") Long current, @Param("size") Long size, @Param("tagId") Integer tagId);

    List<ArticleCardDTO> listArchives(@Param("current") Long current, @Param("size") Long size, @Param("userInfoId") Integer userInfoId);

    Integer countArticleAdmins(@Param("conditionVO") ConditionVO conditionVO);

    List<ArticleAdminDTO> listArticlesAdmin(@Param("current") Long current, @Param("size") Long size, @Param("conditionVO") ConditionVO conditionVO);

    List<ArticleStatisticsDTO> listArticleStatistics();

    /**
     *  查询ArticleCard列表的通用操作
     * @param current 开始
     * @param size 每页的数量
     * @param isDelete 删除与否
     * @param status 文章状态
     * @param review 审核状态
     * @param mapList 条件
     * @return
     */
    List<ArticleCardDTO> listArticleCards(@Param("current") Long current,
                                          @Param("size") Long size,
                                          @Param("isDelete") boolean isDelete,
                                          @Param("status") List<Integer> status,
                                          @Param("review") Integer review,
                                          @Param("mapList") List<ArticleCardMap> mapList
                                          );

    List<ArticleStatisticsDTO> listUserArticleStatistics(@Param("userId") Integer userId);
}

