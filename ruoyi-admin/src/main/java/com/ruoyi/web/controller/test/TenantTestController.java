// TenantTestController.java
package com.ruoyi.web.controller.test;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.security.context.TenantContext;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.CRM.domain.NCompany;
import com.ruoyi.CRM.service.INCompanyService;

/**
 * 多租户验证控制器
 */
@RestController
@RequestMapping("/test/tenant")
public class TenantTestController extends BaseController {

    @Autowired
    private ISysUserService userService;

    @Autowired
    private INCompanyService companyService;

    /**
     * 获取当前租户上下文
     */
    @GetMapping("/context")
    public AjaxResult getTenantContext() {
        Long tenantId = TenantContext.getCurrentTenant();
        return AjaxResult.success("当前租户ID: " + tenantId);
    }

    /**
     * 测试用户数据隔离
     */
    @GetMapping("/users")
    public AjaxResult getUsersByTenant() {
        try {
            // 查询用户列表（会自动添加tenant_id条件）
            List<SysUser> users = userService.selectUserList(new SysUser());
            return AjaxResult.success("当前租户用户数量: " + users.size(), users);
        } catch (Exception e) {
            return AjaxResult.error("查询用户失败: " + e.getMessage());
        }
    }

    /**
     * 测试企业数据隔离
     */
    @GetMapping("/companies")
    public AjaxResult getCompaniesByTenant() {
        try {
            // 查询企业列表（会自动添加tenant_id条件）
            List<NCompany> companies = companyService.selectNCompanyList(new NCompany());
            return AjaxResult.success("当前租户企业数量: " + companies.size(), companies);
        } catch (Exception e) {
            return AjaxResult.error("查询企业失败: " + e.getMessage());
        }
    }

    /**
     * 测试插入数据自动设置租户ID
     */
    @GetMapping("/insert")
    public AjaxResult testInsert(@RequestHeader(value = "X-Tenant-Id", required = false) Long tenantId) {
        try {
            // 创建测试企业
            NCompany company = new NCompany();
            company.setName("测试公司_" + System.currentTimeMillis());
            company.setAddress("测试地址");
            company.setState(1);

            // 插入数据（应该自动设置tenant_id）
            int result = companyService.insertNCompany(company);

            NCompany inserted = companyService.selectNCompanyById(company.getId());
            return AjaxResult.success("插入成功", inserted);
        } catch (Exception e) {
            return AjaxResult.error("插入失败: " + e.getMessage());
        }
    }
    @GetMapping("/debug")
    public AjaxResult debugTenant() {
        Long currentTenant = TenantContext.getCurrentTenant();
        System.out.println("当前租户ID: " + currentTenant);

        // 手动执行SQL查看实际过滤条件
        // 这里可以添加SQL日志输出

        return AjaxResult.success("当前租户: " + currentTenant);
    }
    /**
     * 测试跨租户数据访问（应该失败）
     */
    @GetMapping("/cross")
    public AjaxResult testCrossTenantAccess() {
        try {
            // 先切换到租户A
            TenantContext.setCurrentTenant(1001L);
            List<NCompany> tenantACompanies = companyService.selectNCompanyList(new NCompany());

            // 再切换到租户B
            TenantContext.setCurrentTenant(1002L);
            List<NCompany> tenantBCompanies = companyService.selectNCompanyList(new NCompany());

            return AjaxResult.success(String.format(
                    "租户A企业数: %d, 租户B企业数: %d",
                    tenantACompanies.size(),
                    tenantBCompanies.size()
            ));
        } catch (Exception e) {
            return AjaxResult.error("跨租户访问测试失败: " + e.getMessage());
        } finally {
            TenantContext.clear();
        }
    }
}