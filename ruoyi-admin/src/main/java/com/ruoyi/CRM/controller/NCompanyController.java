package com.ruoyi.CRM.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.system.service.INCompanyService;
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
import com.ruoyi.system.domain.NCompany;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 企业信息Controller
 * 
 * @author ruoyi
 * @date 2025-11-26
 */
@RestController
@RequestMapping("/company/manage")
public class NCompanyController extends BaseController
{
    @Autowired
    private INCompanyService nCompanyService;

    /**
     * 查询企业信息列表
     */
    @PreAuthorize("@ss.hasPermi('company:list')")
    @GetMapping("/list")
    public TableDataInfo list(NCompany nCompany)
    {
        startPage();
        List<NCompany> list = nCompanyService.selectNCompanyList(nCompany);
        return getDataTable(list);
    }

    /**
     * 导出企业信息列表
     */
    @PreAuthorize("@ss.hasPermi('company:export')")
    @Log(title = "企业信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, NCompany nCompany)
    {
        List<NCompany> list = nCompanyService.selectNCompanyList(nCompany);
        ExcelUtil<NCompany> util = new ExcelUtil<NCompany>(NCompany.class);
        util.exportExcel(response, list, "企业信息数据");
    }

    /**
     * 获取企业信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('company:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(nCompanyService.selectNCompanyById(id));
    }

    /**
     * 新增企业信息
     */
    @PreAuthorize("@ss.hasPermi('company:add')")
    @Log(title = "企业信息", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@RequestBody NCompany nCompany)
    {
        return toAjax(nCompanyService.insertNCompany(nCompany));
    }

    /**
     * 修改企业信息
     */
    @PreAuthorize("@ss.hasPermi('company:edit')")
    @Log(title = "企业信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody NCompany nCompany)
    {
        return toAjax(nCompanyService.updateNCompany(nCompany));
    }

    /**
     * 删除企业信息
     */
    @PreAuthorize("@ss.hasPermi('company:remove')")
    @Log(title = "企业信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(nCompanyService.deleteNCompanyByIds(ids));
    }
}
