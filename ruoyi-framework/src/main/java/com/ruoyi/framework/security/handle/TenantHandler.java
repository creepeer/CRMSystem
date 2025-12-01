package com.ruoyi.framework.security.handle;

import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.framework.security.context.TenantContextHolder;
import com.ruoyi.common.utils.SecurityUtils;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import net.sf.jsqlparser.expression.NullValue;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * 多租户处理器
 */
@Component
public class TenantHandler implements TenantLineHandler {

    // 需要忽略多租户的表 - 合并到一个列表中
    private static final List<String> IGNORE_TABLES = Arrays.asList(
            "sys_tenant",       // 租户表本身
            "sys_config",       // 系统配置表
            "sys_dict_type",    // 字典类型表
            "sys_dict_data",    // 字典数据表
            "sys_job",          // 定时任务表
            "sys_logininfor",   // 登录日志表
            "sys_oper_log",     // 操作日志表
            "sys_menu",
            "sys_user",
            "sys_role_dept",
            "sys_user_role",
            "sys_user_post",
            "sys_role_menu",
            // Quartz 相关表
            "qrtz_blob_triggers", "qrtz_calendars", "qrtz_cron_triggers",
            "qrtz_fired_triggers", "qrtz_job_details", "qrtz_locks",
            "qrtz_paused_trigger_grps", "qrtz_scheduler_state",
            "qrtz_simple_triggers", "qrtz_simprop_triggers", "qrtz_triggers"
    );

    @Override
    public Expression getTenantId() {
        Long tenantId = getCurrentTenantId();
        if (tenantId == null) {
            // 如果没有租户ID，返回null值（根据实际情况处理）
            return new NullValue();
        }
        return new LongValue(tenantId);
    }

    @Override
    public String getTenantIdColumn() {
        return "tenant_id";
    }

    @Override
    public boolean ignoreTable(String tableName) {
        return IGNORE_TABLES.stream().anyMatch(t -> t.equalsIgnoreCase(tableName));
    }

    /**
     * 获取当前租户ID
     * 这里根据若依系统的用户体系来获取租户ID
     */
    private Long getCurrentTenantId() {
        try {
            // 从租户上下文获取（优先）
            Long tenantId = TenantContextHolder.getCurrentTenantId();

            if (tenantId != null) {
                return tenantId;
            }

            // 从当前登录用户获取
            SysUser user = SecurityUtils.getLoginUser().getUser();
            if (user != null && user.getTenantId() != null) {
                return user.getTenantId();
            }

            return null;
        } catch (Exception e) {
            // 如果无法获取用户信息，返回null
            return null;
        }
    }
}