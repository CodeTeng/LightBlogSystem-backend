package com.aurora.model.vo;

import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author lhd
 * @date 2024/4/29
 * @desc 用户展示信息
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(description = "用户框展示")
public class UserShowVO {

    /**
     * 用户Id
     */
    private int userId;

    /**
     * 用户头像
     */
    private String avatar;

    /**
     * 用户的文章数量
     */
    private Integer articlesCount;

    /**
     * 用户的说说数量
     */
    private Integer talksCount;
}
