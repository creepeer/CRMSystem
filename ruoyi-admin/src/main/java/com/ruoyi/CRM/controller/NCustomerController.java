package com.ruoyi.CRM.controller;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.CRM.DTO.CustomerDTO;
import org.springframework.beans.BeanUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.CRM.domain.NCustomer;
import com.ruoyi.CRM.service.INCustomerService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 【请填写功能名称】Controller
 * 
 * @author ruoyi
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/customer")
public class NCustomerController extends BaseController
{
    @Autowired
    private INCustomerService nCustomerService;

    /**
     * 查询【客户管理】列表
     */
    @PreAuthorize("@ss.hasPermi('customer:list')")
    @GetMapping("/list")
    public TableDataInfo list(NCustomer nCustomer)
    {
        startPage();
        List<NCustomer> list = nCustomerService.selectNCustomerList(nCustomer);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('customer:export')")
    @Log(title = "【客户管理导出】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, NCustomer nCustomer)
    {
        List<NCustomer> list = nCustomerService.selectNCustomerList(nCustomer);
        ExcelUtil<NCustomer> util = new ExcelUtil<NCustomer>(NCustomer.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取【查询客户byId】详细信息
     */
    @PreAuthorize("@ss.hasPermi('customer:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(nCustomerService.selectNCustomerById(id));
    }

    /**
     * 新增【查询客户b】
     */
    @PreAuthorize("@ss.hasPermi('customer:add')")
    @Log(title = "【客户添加】", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@RequestBody CustomerDTO customerDTO)
    {

        return toAjax(nCustomerService.insertNCustomer(customerDTO,getTenantId(),getUserId()));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('customer:edit')")
    @Log(title = "【客户更新】", businessType = BusinessType.UPDATE)
    @PutMapping("/update")
    public AjaxResult edit(@RequestBody CustomerDTO customerDTO)
    {
        NCustomer customer=new NCustomer();
        BeanUtils.copyProperties(customerDTO,customer);
//        return toAjax(1);
        return toAjax(nCustomerService.updateNCustomer(customer));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('customer:remove')")
    @Log(title = "【客户删除】", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(nCustomerService.deleteNCustomerByIds(ids));
    }
}
