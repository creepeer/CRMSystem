package com.ruoyi.framework.security.context;

import org.springframework.stereotype.Component;

/**
 * 租户上下文管理
 */
@Component
public class TenantContext {

    private static final ThreadLocal<Long> TENANT_CONTEXT = new ThreadLocal<>();

    /**
     * 设置当前租户ID
     */
    public static void setCurrentTenant(Long tenantId) {
        if (tenantId == null) {
            throw new IllegalArgumentException("租户ID不能为空");
        }
        TENANT_CONTEXT.set(tenantId);
    }

    /**
     * 获取当前租户ID
     */
    public static Long getCurrentTenant() {
        Long tenantId = TENANT_CONTEXT.get();
        if (tenantId == null) {
            // 返回默认租户ID，避免NPE
            return 1L;
        }
        return tenantId;
    }

    /**
     * 清除租户上下文
     */
    public static void clear() {
        TENANT_CONTEXT.remove();
    }

    /**
     * 检查当前租户上下文是否存在
     */
    public static boolean hasTenant() {
        return TENANT_CONTEXT.get() != null;
    }
}