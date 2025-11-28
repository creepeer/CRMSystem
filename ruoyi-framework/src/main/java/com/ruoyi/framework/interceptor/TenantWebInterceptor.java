package com.ruoyi.framework.interceptor;

import com.ruoyi.framework.security.context.TenantContext;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 租户Web拦截器
 */
@Component
public class TenantWebInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 从请求头获取租户ID
        String tenantId = request.getHeader("X-Tenant-Id");

        if (tenantId != null && !tenantId.trim().isEmpty()) {
            try {
                TenantContext.setCurrentTenant(Long.valueOf(tenantId));
                System.out.println("设置租户ID: " + tenantId);
            } catch (NumberFormatException e) {
                // 格式错误使用默认租户
                System.err.println("租户ID格式错误，使用默认租户: " + tenantId);
                TenantContext.setCurrentTenant(1L);
            }
        } else {
            // 尝试从参数获取
            tenantId = request.getParameter("tenantId");
            if (tenantId != null && !tenantId.trim().isEmpty()) {
                try {
                    TenantContext.setCurrentTenant(Long.valueOf(tenantId));
                    System.out.println("从参数设置租户ID: " + tenantId);
                } catch (NumberFormatException e) {
                    TenantContext.setCurrentTenant(1L);
                }
            } else {
                // 没有租户ID使用默认租户
                TenantContext.setCurrentTenant(1L);
                System.out.println("使用默认租户ID: 1");
            }
        }

        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        // 请求完成后清理租户上下文，避免内存泄漏
        TenantContext.clear();
        System.out.println("清理租户上下文");
    }
}