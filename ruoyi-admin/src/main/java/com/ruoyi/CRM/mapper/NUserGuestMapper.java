package com.ruoyi.CRM.mapper;

import java.util.List;
import com.ruoyi.CRM.domain.NUserGuest;

/**
 * 客户-员工关联Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
public interface NUserGuestMapper 
{
    /**
     * 查询客户-员工关联
     * 
     * @param id 客户-员工关联主键
     * @return 客户-员工关联
     */
    public NUserGuest selectNUserGuestById(Long id);

    /**
     * 查询客户-员工关联列表
     * 
     * @param nUserGuest 客户-员工关联
     * @return 客户-员工关联集合
     */
    public List<NUserGuest> selectNUserGuestList(NUserGuest nUserGuest);

    /**
     * 新增客户-员工关联
     * 
     * @param nUserGuest 客户-员工关联
     * @return 结果
     */
    public int insertNUserGuest(NUserGuest nUserGuest);

    /**
     * 修改客户-员工关联
     * 
     * @param nUserGuest 客户-员工关联
     * @return 结果
     */
    public int updateNUserGuest(NUserGuest nUserGuest);

    /**
     * 删除客户-员工关联
     * 
     * @param id 客户-员工关联主键
     * @return 结果
     */
    public int deleteNUserGuestById(Long id);

    /**
     * 批量删除客户-员工关联
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNUserGuestByIds(Long[] ids);

    List<NUserGuest> selectNUserGuestsById(Long userId);

    NUserGuest selectNUserGuestByCustomerId(Long id);
}
