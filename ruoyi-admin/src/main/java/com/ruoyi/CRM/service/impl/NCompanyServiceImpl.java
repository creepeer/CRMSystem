package com.ruoyi.CRM.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.CRM.mapper.NCompanyMapper;
import com.ruoyi.CRM.domain.NCompany;
import com.ruoyi.CRM.service.INCompanyService;

/**
 * 企业信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-26
 */
@Service
public class NCompanyServiceImpl implements INCompanyService 
{
    @Autowired
    private NCompanyMapper nCompanyMapper;

    /**
     * 查询企业信息
     * 
     * @param id 企业信息主键
     * @return 企业信息
     */
    @Override
    public NCompany selectNCompanyById(Long id)
    {
        return nCompanyMapper.selectNCompanyById(id);
    }

    /**
     * 查询企业信息列表
     * 
     * @param nCompany 企业信息
     * @return 企业信息
     */
    @Override
    public List<NCompany> selectNCompanyList(NCompany nCompany)
    {
        return nCompanyMapper.selectNCompanyList(nCompany);
    }

    /**
     * 新增企业信息
     * 
     * @param nCompany 企业信息
     * @return 结果
     */
    @Override
    public int insertNCompany(NCompany nCompany)
    {
        nCompany.setCreateTime(DateUtils.getNowDate());
        return nCompanyMapper.insertNCompany(nCompany);
    }

    /**
     * 修改企业信息
     * 
     * @param nCompany 企业信息
     * @return 结果
     */
    @Override
    public int updateNCompany(NCompany nCompany)
    {
        nCompany.setUpdateTime(DateUtils.getNowDate());
        return nCompanyMapper.updateNCompany(nCompany);
    }

    /**
     * 批量删除企业信息
     * 
     * @param ids 需要删除的企业信息主键
     * @return 结果
     */
    @Override
    public int deleteNCompanyByIds(Long[] ids)
    {
        return nCompanyMapper.deleteNCompanyByIds(ids);
    }

    /**
     * 删除企业信息信息
     * 
     * @param id 企业信息主键
     * @return 结果
     */
    @Override
    public int deleteNCompanyById(Long id)
    {
        return nCompanyMapper.deleteNCompanyById(id);
    }
}
