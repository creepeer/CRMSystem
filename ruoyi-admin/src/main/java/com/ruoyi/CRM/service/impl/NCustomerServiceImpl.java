package com.ruoyi.CRM.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.CRM.mapper.NCustomerMapper;
import com.ruoyi.CRM.domain.NCustomer;
import com.ruoyi.CRM.service.INCustomerService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
@Service
public class NCustomerServiceImpl implements INCustomerService 
{
    @Autowired
    private NCustomerMapper nCustomerMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public NCustomer selectNCustomerById(Long id)
    {
        return nCustomerMapper.selectNCustomerById(id);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param nCustomer 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<NCustomer> selectNCustomerList(NCustomer nCustomer)
    {
        return nCustomerMapper.selectNCustomerList(nCustomer);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param nCustomer 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertNCustomer(NCustomer nCustomer)
    {
        return nCustomerMapper.insertNCustomer(nCustomer);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param nCustomer 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateNCustomer(NCustomer nCustomer)
    {
        return nCustomerMapper.updateNCustomer(nCustomer);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param ids 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteNCustomerByIds(Long[] ids)
    {
        return nCustomerMapper.deleteNCustomerByIds(ids);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteNCustomerById(Long id)
    {
        return nCustomerMapper.deleteNCustomerById(id);
    }
}
