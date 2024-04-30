package com.aurora.model.dto;

import lombok.Data;

/**
 * @author lhd
 * @date 2024/4/30
 * @desc 添加轮播图
 */
@Data
public class CarouselAddDTO {

    private int id;

    private String url;

    private Integer rank;
}
