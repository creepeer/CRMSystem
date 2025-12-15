package com.ruoyi.system.service;

import com.ruoyi.system.domain.NCompany;

import java.util.List;

/**
 * 企业信息Service接口
 * 
 * @author ruoyi
 * @date 2025-11-26
 */
public interface INCompanyService 
{
    /**
     * 查询企业信息
     * 
     * @param id 企业信息主键
     * @return 企业信息
     */
    public NCompany selectNCompanyById(Long id);

    /**
     * 查询企业信息列表
     * 
     * @param nCompany 企业信息
     * @return 企业信息集合
     */
    public List<NCompany> selectNCompanyList(NCompany nCompany);

    /**
     * 新增企业信息
     * 
     * @param nCompany 企业信息
     * @return 结果
     */
    public int insertNCompany(NCompany nCompany);

    /**
     * 修改企业信息
     * 
     * @param nCompany 企业信息
     * @return 结果
     */
    public int updateNCompany(NCompany nCompany);

    /**
     * 批量删除企业信息
     * 
     * @param ids 需要删除的企业信息主键集合
     * @return 结果
     */
    public int deleteNCompanyByIds(Long[] ids);

    /**
     * 删除企业信息信息
     * 
     * @param id 企业信息主键
     * @return 结果
     */
    public int deleteNCompanyById(Long id);
}
