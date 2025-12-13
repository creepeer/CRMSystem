package com.ruoyi.CRM.DTO;
import lombok.Data;
import javax.validation.constraints.*;

@Data
public class TeamDTO {

    private Long deptId;
    /**
     * 上级部门ID
     */
    private Long parentId;
    private String ancestors;
    /**
     * 部门名称
     */
    @NotBlank(message = "部门名称不能为空")
    private String deptName;

    /**
     * 显示排序
     */
    @NotNull(message = "排序值不能为空")
    @Min(value = 0, message = "排序值不能小于0")
    private Integer orderNum;
    /**
     * 显示排序
     */
    private String remark;

    /**
     * 负责人
     */
    private Long userId;
    private String leader;
    /**
     * 联系电话
     */
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "请输入有效的11位手机号码")
    private String phone;

    /**
     * 邮箱
     */
    @Email(message = "邮箱格式不正确")
    private String email;

    /**
     * 部门状态：0-正常，1-停用
     */
    private String status;
}