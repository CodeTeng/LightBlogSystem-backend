package com.aurora.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@TableName("t_carousel")
public class Carousel implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 轮播图地址
     */
    private String url;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 轮播图状态 1-正常 0-禁用
     */
    private Integer status;
}
