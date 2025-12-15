package com.ruoyi.CRM.DTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.*;
@Data
@ApiModel("公司申请请求参数")
public class ManageDTO {
    @ApiModelProperty(value = "公司id")
    private Long id;

    @ApiModelProperty(value = "公司名称",example = "杭电")
    private String name;
    @ApiModelProperty(value = "公司地址",example = "杭电路1号")
    private String address;

    @ApiModelProperty(value = "营业执照图片地址",example = "/images/1.png")
    private String license;

    @ApiModelProperty(value = "法人姓名",example = "张三")
    private String leName;

    @ApiModelProperty(value = "法人姓名",example = "张三")
    private int leAge;

    @ApiModelProperty(value = "法人邮箱",example = "1987@qq.com")
    private String leEmail;

    @ApiModelProperty(value = "法人手机号", example = "13800138000")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String lePhone;

    @ApiModelProperty(value = "法人身份证",example = "129375")
    private String leCard;

    private int status;

    private String username;

    private String password;

    @ApiModelProperty(value = "备注", example = "公司备注")
    @Size(max = 500, message = "备注长度不能超过500个字符")
    private String remark;
}