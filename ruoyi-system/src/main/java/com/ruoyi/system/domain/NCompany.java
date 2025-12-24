package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 企业信息对象 n_company
 *
 * @author ruoyi
 * @date 2025-11-26
 */
public class NCompany extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 企业编号 */
    private Long id;

    /** 企业名称 */
    @Excel(name = "企业名称")
    private String name;

    /** 企业地址 */
    @Excel(name = "企业地址")
    private String address;

    /** 营业执照 */
    @Excel(name = "营业执照")
    private String license;

    /** 法人姓名 */
    @Excel(name = "法人姓名")
    private String leName;

    /** 法人年龄 */
    @Excel(name = "法人年龄")
    private Integer leAge;

    /** 法人邮箱 */
    @Excel(name = "法人邮箱")
    private String leEmail;

    /** 法人电话 */
    @Excel(name = "法人电话")
    private String lePhone;

    /** 法人身份证号 */
    @Excel(name = "法人身份证号")
    private String leCard;

    /** 企业状态：1-待审核 2-已通过 3-已拒绝 4-停用 */
    @Excel(name = "企业状态：1-待审核 2-已通过 3-已拒绝 4-停用")
    private Integer state;

    /** 删除标记：0-正常 1-删除 */
    @Excel(name = "删除标记：0-正常 1-删除")
    private Integer isDeleted;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getName()
    {
        return name;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getAddress()
    {
        return address;
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

    public void setLeAge(int leAge) {
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

    public void setState(int state)
    {
        this.state = state;
    }

    public Integer getState()
    {
        return state;
    }

    public void setIsDeleted(Integer isDeleted)
    {
        this.isDeleted = isDeleted;
    }

    public Integer getIsDeleted()
    {
        return isDeleted;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("name", getName())
                .append("address", getAddress())
                .append("license", getLicense())
                .append("Name", getLeName())
                .append("leAge", getLeAge())
                .append("leEmail", getLeEmail())
                .append("lePhone", getLePhone())
                .append("leCard", getLeCard())
                .append("state", getState())
                .append("remark", getRemark())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("isDeleted", getIsDeleted())
                .toString();
    }
}
