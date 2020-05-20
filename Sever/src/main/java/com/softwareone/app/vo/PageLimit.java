package com.softwareone.app.vo;

import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * @author chenqiting
 */
@Data
public class PageLimit {
    @NotNull(message = "页数不能为空")
    @Min(value = 1)
    private Integer page;

    @NotNull(message = "一页多少数据不能为空")
    @Min(value = 1)
    private Integer size;
}
