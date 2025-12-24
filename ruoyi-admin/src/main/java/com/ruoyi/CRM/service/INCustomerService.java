package com.ruoyi.CRM.service;

import java.util.List;

import com.ruoyi.CRM.DTO.CustomerDTO;
import com.ruoyi.CRM.DTO.GetCustomerListDTO;
import com.ruoyi.CRM.domain.NCustomer;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 【请填写功能名称】Service接口
 *
 * @author ruoyi
 * @date 2025-12-22
 */
public interface INCustomerService
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
    public List<GetCustomerListDTO> selectNCustomerList(NCustomer nCustomer);

    /**
     * 新增【请填写功能名称】
     *
     * @param customerDTO 【请填写功能名称】
     * @return 结果
     */
    public int insertNCustomer(CustomerDTO customerDTO,Long tenantId,Long userId);

    /**
     * 修改【请填写功能名称】
     *
     * @param nCustomer 【请填写功能名称】
     * @return 结果
     */
    public int updateNCustomer(NCustomer nCustomer);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteNCustomerByIds(Long[] ids);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteNCustomerById(Long id);

    List<NCustomer> getMember(Long userId);
}