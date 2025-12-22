package com.ruoyi.CRM.DTO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.*;

@Data
@ApiModel("客户信息参数")
public class CustomerDTO {

    @ApiModelProperty(value = "客户ID")
    private Long id;

    @ApiModelProperty(value = "客户姓名", example = "张三", required = true)
    @NotBlank(message = "客户姓名不能为空")
    private String name;

    @ApiModelProperty(value = "客户年龄", example = "30")
    @Min(value = 0, message = "年龄不能小于0")
    private Long age;

    @ApiModelProperty(value = "客户电话", example = "13800138000", required = true)
    @NotBlank(message = "客户电话不能为空")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String phone;

    @ApiModelProperty(value = "客户邮箱", example = "zhangsan@example.com")
    @Email(message = "邮箱格式不正确")
    private String email;

    @ApiModelProperty(value = "客户地址", example = "浙江省杭州市西湖区")
    private String address;

    @ApiModelProperty(value = "负责团队", example = "销售一部")
    private Long teamId;

    @ApiModelProperty(value = "负责员工", example = "李四")
    private Long userId;

    @ApiModelProperty(value = "状态: 1-正常, 0-禁用", example = "1")
    private Long status;

    @ApiModelProperty(value = "备注", example = "重要客户")
    @Size(max = 500, message = "备注长度不能超过500个字符")
    private String remark;
}