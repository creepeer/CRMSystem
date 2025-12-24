package com.ruoyi.CRM.DTO;

import com.ruoyi.CRM.domain.NCustomer;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class GetCustomerListDTO extends NCustomer {
    @ApiModelProperty(value = "用户ID")
    private Long userid;

    @ApiModelProperty(value = "用户姓名", example = "张三")
    private String username;
}
