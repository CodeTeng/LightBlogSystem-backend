package com.aurora.model.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/4/29 21:05
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserForegroundDTO {
    @ApiModelProperty("用户的留言数量")
    private Integer messageCount;
    @ApiModelProperty("用户发布的所有文章数量")
    private Integer articleCount;
    @ApiModelProperty("用户发布的置顶文章数量")
    private Integer topArticleCount;
    @ApiModelProperty("用户发布的自己推荐的文章数量")
    private Integer featuredArticleCount;
    @ApiModelProperty("用户发布的公开的文章数量")
    private Integer publishedArticleCount;
    @ApiModelProperty("用户发布的私密文章数量")
    private Integer privacyArticleCount;
    @ApiModelProperty("用户发布的草稿数量")
    private Integer draftCount;
    @ApiModelProperty("用户发布文章的贡献度")
    private List<ArticleStatisticsDTO> articleStatisticsDTOs;
    @ApiModelProperty("用户发布的文章分类列表")
    private List<CategoryDTO> categoryDTOs;
    @ApiModelProperty("用户发布的文章标签列表")
    private List<TagDTO> tagDTOs;
}
