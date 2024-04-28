package com.aurora.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("操作日志实体")
@TableName("t_operation_log")
public class OperationLog {
    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty("主键id")
    private Integer id;
    @ApiModelProperty("操作模块")
    private String optModule;
    @ApiModelProperty("操作类型")
    private String optUri;
    @ApiModelProperty("操作url")
    private String optType;
    @ApiModelProperty("操作方法")
    private String optMethod;
    @ApiModelProperty("操作描述")
    private String optDesc;
    @ApiModelProperty("请求方式")
    private String requestMethod;
    @ApiModelProperty("请求参数")
    private String requestParam;
    @ApiModelProperty("返回数据")
    private String responseData;
    @ApiModelProperty("用户id")
    private Integer userId;
    @ApiModelProperty("用户昵称")
    private String nickname;
    @ApiModelProperty("IP地址")
    private String ipAddress;
    @ApiModelProperty("IP来源")
    private String ipSource;
    @ApiModelProperty("操作时间")
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @ApiModelProperty("更新时间")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}
