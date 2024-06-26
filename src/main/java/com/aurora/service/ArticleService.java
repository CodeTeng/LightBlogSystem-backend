package com.aurora.service;

import com.aurora.model.dto.*;
import com.aurora.entity.Article;
import com.aurora.model.vo.*;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;


public interface ArticleService extends IService<Article> {

    TopAndFeaturedArticlesDTO listTopAndFeaturedArticles();

    PageResultDTO<ArticleCardDTO> listArticles();

    PageResultDTO<ArticleCardDTO> listArticlesByCategoryId(Integer categoryId);

    ArticleDTO getArticleById(Integer articleId);

    void accessArticle(ArticlePasswordVO articlePasswordVO);

    PageResultDTO<ArticleCardDTO> listArticlesByTagId(Integer tagId);

    PageResultDTO<ArchiveDTO> listArchives();

    PageResultDTO<ArticleAdminDTO> listArticlesAdmin(ConditionVO conditionVO);

    void saveOrUpdateArticle(ArticleVO articleVO);

    void updateArticleTopAndFeatured(ArticleTopFeaturedVO articleTopFeaturedVO);

    void updateArticleDelete(DeleteVO deleteVO);

    void deleteArticles(List<Integer> articleIds);

    ArticleAdminViewDTO getArticleByIdAdmin(Integer articleId);

    List<String> exportArticles(List<Integer> articleIdList);

    List<ArticleSearchDTO> listArticlesBySearch(ConditionVO condition);

    /**
     * 修改文章的分数
     *
     * @param articleId 文章id
     * @param score     加的分数
     */
    void updateArticleScore(Integer articleId, Double score);

    /**
     * 审核文章
     * @param reviewVO
     */
    void articleReview(ArticleReviewVO reviewVO);

    /**
     * 文章评分
     * @param articleScoreDTO
     */
    void saveOrUpdateArticleScore(ArticleScoreDTO articleScoreDTO);

    /**
     * 查询用户对文章的评分
     * @param articleId 文章Id
     */
    Integer getArticleScore(Long articleId);

    /**
     * 前台：获得用户文章
     * @param userId
     * @return
     */
    PageResultDTO<ArticleCardDTO> listArticlesByUserId(Integer userId);

    /**
     * 重置用户文章的置顶为零
     *
     * @param userId
     */
    void resetArticleTop(Integer userId);

    /**
     * 获得用户的置顶
     * @param userId
     * @return
     */
    ArticleCardDTO getTopArticleByUserId(Integer userId);

    /**
     * 更新文章卡片信息
     * @param cardDTO
     * @return
     */
    Boolean updateArticleCardInfo(ArticleCardDTO cardDTO);
}
