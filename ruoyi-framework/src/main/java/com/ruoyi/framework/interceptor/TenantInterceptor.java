package com.ruoyi.framework.interceptor;

import com.ruoyi.framework.security.context.TenantContextHolder;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.*;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.Properties;

/**
 * MyBatis多租户SQL拦截器
 */
@Component
@Intercepts({
        @Signature(type = Executor.class, method = "update", args = {MappedStatement.class, Object.class}),
        @Signature(type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, org.apache.ibatis.session.RowBounds.class, org.apache.ibatis.session.ResultHandler.class})
})
public class TenantInterceptor implements Interceptor {

    // 需要租户隔离的表
    private static final String[] TENANT_TABLES = {
            "sys_user", "sys_dept", "sys_role", "sys_post", "sys_menu",
            "sys_config", "sys_dict_type", "sys_dict_data", "n_company",
            "gen_table", "gen_table_column", "sys_logininfor", "sys_oper_log", "sys_job_log"
    };

    // 忽略租户隔离的表
    private static final String[] IGNORE_TABLES = {
            "sys_tenant", "qrtz_blob_triggers", "qrtz_calendars", "qrtz_cron_triggers",
            "qrtz_fired_triggers", "qrtz_job_details", "qrtz_locks", "qrtz_paused_trigger_grps",
            "qrtz_scheduler_state", "qrtz_simple_triggers", "qrtz_simprop_triggers", "qrtz_triggers"
    };

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object[] args = invocation.getArgs();
        MappedStatement ms = (MappedStatement) args[0];
        Object parameter = args[1];

        // 获取当前租户ID
        Long currentTenantId = TenantContextHolder.getCurrentTenantId();

        // 获取SQL命令类型
        SqlCommandType sqlCommandType = ms.getSqlCommandType();

        // 处理INSERT操作：自动设置tenant_id
        if (sqlCommandType == SqlCommandType.INSERT) {
            setTenantIdForInsert(parameter, currentTenantId);
        }
        // 对于UPDATE和DELETE操作，可以添加租户权限验证
        else if (sqlCommandType == SqlCommandType.UPDATE || sqlCommandType == SqlCommandType.DELETE) {
            // 这里可以添加额外的租户权限验证逻辑
            // 确保操作的数据属于当前租户
        }

        return invocation.proceed();
    }

    /**
     * 为插入操作设置租户ID
     */
    private void setTenantIdForInsert(Object parameter, Long tenantId) {
        if (parameter == null) return;

        try {
            // 使用反射设置tenantId字段
            Field tenantIdField = null;
            Class<?> clazz = parameter.getClass();

            // 查找 tenantId 字段
            while (clazz != null && tenantIdField == null) {
                try {
                    tenantIdField = clazz.getDeclaredField("tenantId");
                } catch (NoSuchFieldException e) {
                    clazz = clazz.getSuperclass();
                }
            }

            if (tenantIdField != null) {
                tenantIdField.setAccessible(true);
                Object currentValue = tenantIdField.get(parameter);

                // 如果tenantId为空，则设置当前租户ID
                if (currentValue == null) {
                    tenantIdField.set(parameter, tenantId);
                }
            }
        } catch (Exception e) {
            // 忽略反射异常
            System.err.println("设置租户ID失败: " + e.getMessage());
        }
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
        // 可以配置需要隔离的表等属性
    }
}