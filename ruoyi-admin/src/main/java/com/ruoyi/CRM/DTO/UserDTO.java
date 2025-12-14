package com.ruoyi.CRM.DTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.*;
@Data
@ApiModel("员工添加请求参数")
public class UserDTO {
    @ApiModelProperty(value = "员工号", required = true)
    private Long userId;

    @ApiModelProperty(value = "姓名", required = true, example = "张三")
    @Size(max = 50, message = "姓名长度不能超过50个字符")
    private String nickName;

    @ApiModelProperty(value = "职位", required = true, example = "销售代表")
    private Long roleId;

    @ApiModelProperty(value = "团队ID", required = true, example = "1001")
    private Long deptId;

    @ApiModelProperty(value = "年龄", example = "28")
    @Max(value = 65, message = "年龄必须小于等于65岁")
    private Integer age;

    @ApiModelProperty(value = "账号", required = true, example = "zhangsan")
    @Size(min = 4, max = 50, message = "账号长度必须在4-50个字符之间")
    @Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9_]{3,49}$",
            message = "账号必须以字母开头，只能包含字母、数字和下划线")
    private String userName;

    @ApiModelProperty(value = "密码", example = "Password123")
    private String password;

    @ApiModelProperty(value = "手机号", example = "13800138000")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String phone;

    @ApiModelProperty(value = "邮箱", example = "zhangsan@example.com")
    @Email(message = "邮箱格式不正确")
    private String email;

    @ApiModelProperty(value = "备注", example = "新入职员工")
    @Size(max = 500, message = "备注长度不能超过500个字符")
    private String remark;
}
