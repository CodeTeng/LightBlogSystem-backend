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
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("异常日志信息实体")
@TableName("t_exception_log")
public class ExceptionLog {
    @TableId(type = IdType.AUTO)
    @ApiModelProperty("主键id")
    private Integer id;
    @ApiModelProperty("请求接口")
    private String optUri;
    @ApiModelProperty("请求方法全名")
    private String optMethod;
    @ApiModelProperty("请求方式")
    private String requestMethod;
    @ApiModelProperty("请求参数")
    private String requestParam;
    @ApiModelProperty("操作描述")
    private String optDesc;
    @ApiModelProperty("异常信息")
    private String exceptionInfo;
    @ApiModelProperty("IP地址")
    private String ipAddress;
    @ApiModelProperty("IP来源")
    private String ipSource;
    @ApiModelProperty("操作时间")
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
