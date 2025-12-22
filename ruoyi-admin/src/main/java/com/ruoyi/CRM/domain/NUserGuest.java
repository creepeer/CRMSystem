package com.ruoyi.CRM.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 客户-员工关联对象 n_user_guest
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
public class NUserGuest extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 客户ID */
    @Excel(name = "客户ID")
    private Long customerId;

    /** 员工ID */
    @Excel(name = "员工ID")
    private Long userId;

    /** 关系类型:responsible-负责人,support-协助人 */
    @Excel(name = "关系类型:responsible-负责人,support-协助人")
    private String relationType;

    /** 是否主要负责人:1-是,0-否 */
    @Excel(name = "是否主要负责人:1-是,0-否")
    private Long isPrimary;

    /** 创建人 */
    @Excel(name = "创建人")
    private Long createdBy;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date createdAt;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date updatedAt;

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

    public void setCustomerId(Long customerId) 
    {
        this.customerId = customerId;
    }

    public Long getCustomerId() 
    {
        return customerId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setRelationType(String relationType) 
    {
        this.relationType = relationType;
    }

    public String getRelationType() 
    {
        return relationType;
    }

    public void setIsPrimary(Long isPrimary) 
    {
        this.isPrimary = isPrimary;
    }

    public Long getIsPrimary() 
    {
        return isPrimary;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("tenantId", getTenantId())
            .append("customerId", getCustomerId())
            .append("userId", getUserId())
            .append("relationType", getRelationType())
            .append("isPrimary", getIsPrimary())
            .append("createdBy", getCreatedBy())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
