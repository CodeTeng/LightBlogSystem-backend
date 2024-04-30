package com.aurora.model.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

/**
 * @author lhd
 * @date 2024/4/28
 * @desc 文章审核状态
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArticleReviewVO {

    @NotNull(message = "文章id不能为空")
    @ApiModelProperty(name = "id", value = "文章id", dataType = "Integer", required = true)
    private Integer articleId;

    @NotNull(message = "review不能为空")
    @ApiModelProperty(name = "review", value = "文章审核状态", dataType = "Integer",required = true)
    private Integer review;
}
