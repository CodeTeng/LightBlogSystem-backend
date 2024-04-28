package com.aurora.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author: lhd
 * @date: 2024/4/14
 * @description: 文章审核
 */


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArticleScoreDTO {

    private Long articleId;

    private Integer score;
}
