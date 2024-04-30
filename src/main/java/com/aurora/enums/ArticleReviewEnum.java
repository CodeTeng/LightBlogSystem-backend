package com.aurora.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author lhd
 * @date 2024/4/28
 * @desc
 */
@Getter
@AllArgsConstructor
public enum ArticleReviewEnum {
    NOT_REVIEW(0, "未审核"),

    OK_REVIEW(1, "已审核");

    private final Integer review;

    private final String desc;
}
