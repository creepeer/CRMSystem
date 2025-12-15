package com.ruoyi.common.core.domain.model;

import javax.validation.constraints.*;

/**
 * 用户注册对象
 *
 * @author ruoyi
 */
public class RegisterBody extends LoginBody
{
    private Long deptId;

    @NotBlank(message = "公司名称不能为空")

    private String name;


    private String address;

    private String license;

    @NotBlank(message = "法人姓名不能为空")

    private String leName;


    private Integer leAge;


    private String leEmail;

    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String lePhone;


    private String leCard;

    @Size(max = 500, message = "备注长度不能超过500个字符")
    private String remark;

    public Long getDeptId() {
        return deptId;
    }

    public void setDeptId(Long deptId) {
        this.deptId = deptId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    public String getLeName() {
        return leName;
    }

    public void setLeName(String leName) {
        this.leName = leName;
    }

    public Integer getLeAge() {
        return leAge;
    }

    public void setLeAge(Integer leAge) {
        this.leAge = leAge;
    }

    public String getLeEmail() {
        return leEmail;
    }

    public void setLeEmail(String leEmail) {
        this.leEmail = leEmail;
    }

    public String getLePhone() {
        return lePhone;
    }

    public void setLePhone(String lePhone) {
        this.lePhone = lePhone;
    }

    public String getLeCard() {
        return leCard;
    }

    public void setLeCard(String leCard) {
        this.leCard = leCard;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}