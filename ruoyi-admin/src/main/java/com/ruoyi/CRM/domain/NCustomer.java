package com.ruoyi.CRM.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 n_customer
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
public class NCustomer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 客户编码 */
    @Excel(name = "客户编码")
    private String cCode;

    /** 客户名称 */
    @Excel(name = "客户名称")
    private String name;

    /** 客户类型:enterprise-企业,personal-个人 */
    @Excel(name = "客户类型:enterprise-企业,personal-个人")
    private String type;

    /** 客户年龄 */
    @Excel(name = "客户年龄")
    private Long age;

    /** 客户电话 */
    @Excel(name = "客户电话")
    private String phone;

    /** 客户邮箱 */
    @Excel(name = "客户邮箱")
    private String email;

    /** 详细地址 */
    @Excel(name = "详细地址")
    private String address;

    /** 负责团队ID */
    @Excel(name = "负责团队ID")
    private Long teamId;

    /** 状态:1-正常,0-禁用 */
    @Excel(name = "状态:1-正常,0-禁用")
    private Long status;

    /** 创建人ID */
    @Excel(name = "创建人ID")
    private Long createdBy;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date createdAt;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date updatedAt;

    /** 更新人ID */
    @Excel(name = "更新人ID")
    private Long updatedBy;

    /** 逻辑删除 */
    @Excel(name = "逻辑删除")
    private Long isDeleted;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setTenantId(Long tenantId) 
    {
        this.tenantId = tenantId;
    }

    public Long getTenantId() 
    {
        return tenantId;
    }

    public void setcCode(String cCode) 
    {
        this.cCode = cCode;
    }

    public String getcCode() 
    {
        return cCode;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public void setType(String type) 
    {
        this.type = type;
    }

    public String getType() 
    {
        return type;
    }

    public void setAge(Long age) 
    {
        this.age = age;
    }

    public Long getAge() 
    {
        return age;
    }

    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }

    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }

    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
    }

    public void setTeamId(Long teamId) 
    {
        this.teamId = teamId;
    }

    public Long getTeamId() 
    {
        return teamId;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setCreatedBy(Long createdBy) 
    {
        this.createdBy = createdBy;
    }

    public Long getCreatedBy() 
    {
        return createdBy;
    }

    public void setCreatedAt(Date createdAt) 
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() 
    {
        return createdAt;
    }

    public void setUpdatedAt(Date updatedAt) 
    {
        this.updatedAt = updatedAt;
    }

    public Date getUpdatedAt() 
    {
        return updatedAt;
    }

    public void setUpdatedBy(Long updatedBy) 
    {
        this.updatedBy = updatedBy;
    }

    public Long getUpdatedBy() 
    {
        return updatedBy;
    }

    public void setIsDeleted(Long isDeleted) 
    {
        this.isDeleted = isDeleted;
    }

    public Long getIsDeleted() 
    {
        return isDeleted;
    }


    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("tenantId", getTenantId())
            .append("cCode", getcCode())
            .append("name", getName())
            .append("type", getType())
            .append("age", getAge())
            .append("phone", getPhone())
            .append("email", getEmail())
            .append("address", getAddress())
            .append("teamId", getTeamId())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("createdBy", getCreatedBy())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .append("updatedBy", getUpdatedBy())
            .append("isDeleted", getIsDeleted())
            .toString();
    }
}
