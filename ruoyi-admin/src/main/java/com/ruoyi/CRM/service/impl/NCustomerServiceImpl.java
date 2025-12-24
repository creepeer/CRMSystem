package com.ruoyi.CRM.service.impl;

import java.util.*;
import java.util.stream.Collectors;

import com.ruoyi.CRM.DTO.CustomerDTO;
import com.ruoyi.CRM.domain.NUserGuest;
import com.ruoyi.CRM.mapper.NUserGuestMapper;
import com.ruoyi.common.core.page.TableDataInfo;
import org.springframework.beans.BeanUtils;
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
    @Autowired
    private NUserGuestMapper nUserGuestMapper;

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
     * @param customerDTO 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertNCustomer(CustomerDTO customerDTO,Long tenantId,Long userId)
    {

        NCustomer customer=new NCustomer();
        BeanUtils.copyProperties(customerDTO,customer);
        customer.setTenantId(tenantId);
        String customerCode = "CUST-" + UUID.randomUUID().toString().replace("-", "").substring(0, 12).toUpperCase();
        customer.setcCode(customerCode);
        customer.setCreatedBy(userId);
        customer.setCreatedAt(new Date());
        NUserGuest nUserGuest=new NUserGuest();
        nCustomerMapper.insertNCustomer(customer);
        nUserGuest.setUserId(customerDTO.getUserId());
        nUserGuest.setTenantId(tenantId);
        nUserGuest.setCreatedBy(userId);
        nUserGuest.setCreatedAt(new Date());
        nUserGuest.setCustomerId(customer.getId());
        nUserGuest.setRelationType("responsible");
        nUserGuest.setIsPrimary(1L);
        return nUserGuestMapper.insertNUserGuest(nUserGuest) ;
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
    @Override
    public List<NCustomer> getMember(Long userId){
        // 1. 查询用户关联的客户关系
        List<NUserGuest> nUserGuests = nUserGuestMapper.selectNUserGuestsById(userId);


        // 2. 提取所有客户ID
        List<Long> customerIds = nUserGuests.stream()
                .map(NUserGuest::getCustomerId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());


        // 3. 批量查询客户详细信息
        List<NCustomer> customers = nCustomerMapper.selectNCustomerByIds(customerIds);

        return customers;
    }
}