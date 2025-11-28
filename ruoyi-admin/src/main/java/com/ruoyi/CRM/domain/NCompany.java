package com.ruoyi.CRM.domain;

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
    private String cplicense;

    /** 法人姓名 */
    @Excel(name = "法人姓名")
    private String lename;

    /** 法人年龄 */
    @Excel(name = "法人年龄")
    private Long leage;

    /** 法人邮箱 */
    @Excel(name = "法人邮箱")
    private String leemail;

    /** 法人电话 */
    @Excel(name = "法人电话")
    private String lephone;

    /** 法人身份证号 */
    @Excel(name = "法人身份证号")
    private String lecard;

    /** 企业状态：1-待审核 2-已通过 3-已拒绝 4-停用 */
    @Excel(name = "企业状态：1-待审核 2-已通过 3-已拒绝 4-停用")
    private int state;

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

    public void setCplicense(String cplicense) 
    {
        this.cplicense = cplicense;
    }

    public String getCplicense() 
    {
        return cplicense;
    }

    public void setLename(String lename) 
    {
        this.lename = lename;
    }

    public String getLename() 
    {
        return lename;
    }

    public void setLeage(Long leage) 
    {
        this.leage = leage;
    }

    public Long getLeage() 
    {
        return leage;
    }

    public void setLeemail(String leemail) 
    {
        this.leemail = leemail;
    }

    public String getLeemail() 
    {
        return leemail;
    }

    public void setLephone(String lephone) 
    {
        this.lephone = lephone;
    }

    public String getLephone() 
    {
        return lephone;
    }

    public void setLecard(String lecard) 
    {
        this.lecard = lecard;
    }

    public String getLecard() 
    {
        return lecard;
    }

    public void setState(int state)
    {
        this.state = state;
    }

    public int getState()
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
            .append("cplicense", getCplicense())
            .append("lename", getLename())
            .append("leage", getLeage())
            .append("leemail", getLeemail())
            .append("lephone", getLephone())
            .append("lecard", getLecard())
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
