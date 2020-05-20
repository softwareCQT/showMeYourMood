package com.softwareone.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * @author chenqiting
 */
@Data
@AllArgsConstructor
public class PageLimit {
    @NotNull(message = "页数不能为空")
    @Min(value = 1)
    private int page;

    @NotNull(message = "一页多少数据不能为空")
    @Min(value = 1)
    private int size;
}
