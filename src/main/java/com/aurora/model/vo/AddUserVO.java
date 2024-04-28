package com.aurora.model.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;
import java.util.List;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/3/4 11:18
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(description = "添加用户请求体")
public class AddUserVO {
    @NotBlank(message = "邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    @ApiModelProperty(name = "username", value = "用户名", required = true, dataType = "String")
    private String username;

    @ApiModelProperty(name = "userAge", value = "用户年龄", required = true, dataType = "Integer")
    @NotNull(message = "用户年龄不能为空")
    @Min(value = 0, message = "用户年龄最小为0岁")
    private Integer userAge;

    @ApiModelProperty(name = "userGender", value = "用户性别 0-男 1-女", required = true, dataType = "Integer")
    @NotNull(message = "用户性别不能为空")
    private Integer userGender;

    @Size(min = 6, message = "密码不能少于6位")
    @NotBlank(message = "密码不能为空")
    @ApiModelProperty(name = "password", value = "密码", required = true, dataType = "String")
    private String password;

    @NotNull(message = "用户角色不能为空")
    @ApiModelProperty(name = "roleList", value = "角色id集合", dataType = "List<Integer>")
    private List<Integer> roleIds;
}
