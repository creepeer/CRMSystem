package com.ruoyi.framework.security.handle;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.ruoyi.framework.security.context.TenantContextHolder;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * MyBatis-Plus 元对象处理器
 */
@Component
public class CreateAndUpdateMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "createTime", Date.class, new Date());
        this.strictInsertFill(metaObject, "updateTime", Date.class, new Date());

        // 自动填充租户ID
        Long tenantId = TenantContextHolder.getCurrentTenantId();
        if (tenantId != null) {
            this.strictInsertFill(metaObject, "tenantId", Long.class, tenantId);
        } else {
            // 如果没有显式设置租户ID，尝试从当前用户获取
            try {
                Long userTenantId = SecurityUtils.getLoginUser().getUser().getTenantId();
                if (userTenantId != null) {
                    this.strictInsertFill(metaObject, "tenantId", Long.class, userTenantId);
                }
            } catch (Exception e) {
                // 忽略异常
            }
        }
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
    }
}