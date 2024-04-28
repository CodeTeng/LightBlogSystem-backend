package com.aurora.model.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TopAndFeaturedArticlesDTO {
    @ApiModelProperty("置顶文章")
    private ArticleCardDTO topArticle;
    @ApiModelProperty("推荐文章列表")
    private List<ArticleCardDTO> featuredArticles;
    @ApiModelProperty("热点文章列表")
    private List<ArticleCardDTO> hotArticles;
}
