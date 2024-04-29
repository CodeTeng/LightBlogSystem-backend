package com.aurora.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
@AllArgsConstructor
public enum ArticleStatusEnum {

    PUBLIC(1, "公开"),

    SECRET(2, "密码"),

    DRAFT(3, "草稿");

    private final Integer status;

    private final String desc;

    public static List<Integer> getStatusList(ArticleStatusEnum ...status) {
        List<Integer> statusList = new ArrayList<>();
        for (ArticleStatusEnum e : status) {
            statusList.add(e.getStatus());
        }
        return statusList;
    }

}
