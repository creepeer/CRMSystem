package com.ruoyi.system.service.impl;



import com.ruoyi.system.domain.NCompany;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.mapper.NCompanyMapper;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.service.INCompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    @Autowired
    private SysUserMapper userMapper;

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
     * 修改企业状态
     *
     * @param id 企业ID
     * @param state 状态值（0=停用，1=启用）
     * @return 结果
     */
    public int updateCompanyState(Long id, Integer state) {
        NCompany company = new NCompany();
        company.setId(id);
        company.setState(state);
        return nCompanyMapper.updateNCompany(company);
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
