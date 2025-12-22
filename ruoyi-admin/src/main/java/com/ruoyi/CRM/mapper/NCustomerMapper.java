package com.ruoyi.CRM.mapper;

import java.util.List;
import com.ruoyi.CRM.domain.NCustomer;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
public interface NCustomerMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public NCustomer selectNCustomerById(Long id);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param nCustomer 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<NCustomer> selectNCustomerList(NCustomer nCustomer);

    /**
     * 新增【请填写功能名称】
     * 
     * @param nCustomer 【请填写功能名称】
     * @return 结果
     */
    public int insertNCustomer(NCustomer nCustomer);

    /**
     * 修改【请填写功能名称】
     * 
     * @param nCustomer 【请填写功能名称】
     * @return 结果
     */
    public int updateNCustomer(NCustomer nCustomer);

    /**
     * 删除【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteNCustomerById(Long id);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNCustomerByIds(Long[] ids);
}
