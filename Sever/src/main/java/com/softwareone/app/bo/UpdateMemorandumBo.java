package com.softwareone.app.bo;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @author chenqiting
 */
@Data
public class UpdateMemorandumBo {
    @NotNull
    private Integer id;

    @NotNull
    private String content;
}
