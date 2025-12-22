package com.ruoyi.CRM.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.CRM.mapper.NUserGuestMapper;
import com.ruoyi.CRM.domain.NUserGuest;
import com.ruoyi.CRM.service.INUserGuestService;

/**
 * 客户-员工关联Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
@Service
public class NUserGuestServiceImpl implements INUserGuestService 
{
    @Autowired
    private NUserGuestMapper nUserGuestMapper;

    /**
     * 查询客户-员工关联
     * 
     * @param id 客户-员工关联主键
     * @return 客户-员工关联
     */
    @Override
    public NUserGuest selectNUserGuestById(Long id)
    {
        return nUserGuestMapper.selectNUserGuestById(id);
    }

    /**
     * 查询客户-员工关联列表
     * 
     * @param nUserGuest 客户-员工关联
     * @return 客户-员工关联
     */
    @Override
    public List<NUserGuest> selectNUserGuestList(NUserGuest nUserGuest)
    {
        return nUserGuestMapper.selectNUserGuestList(nUserGuest);
    }

    /**
     * 新增客户-员工关联
     * 
     * @param nUserGuest 客户-员工关联
     * @return 结果
     */
    @Override
    public int insertNUserGuest(NUserGuest nUserGuest)
    {
        return nUserGuestMapper.insertNUserGuest(nUserGuest);
    }

    /**
     * 修改客户-员工关联
     * 
     * @param nUserGuest 客户-员工关联
     * @return 结果
     */
    @Override
    public int updateNUserGuest(NUserGuest nUserGuest)
    {
        return nUserGuestMapper.updateNUserGuest(nUserGuest);
    }

    /**
     * 批量删除客户-员工关联
     * 
     * @param ids 需要删除的客户-员工关联主键
     * @return 结果
     */
    @Override
    public int deleteNUserGuestByIds(Long[] ids)
    {
        return nUserGuestMapper.deleteNUserGuestByIds(ids);
    }

    /**
     * 删除客户-员工关联信息
     * 
     * @param id 客户-员工关联主键
     * @return 结果
     */
    @Override
    public int deleteNUserGuestById(Long id)
    {
        return nUserGuestMapper.deleteNUserGuestById(id);
    }
}
