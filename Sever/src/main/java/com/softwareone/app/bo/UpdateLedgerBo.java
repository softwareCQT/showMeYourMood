package com.softwareone.app.bo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author chenqiting
 */
@Data
public class UpdateLedgerBo {
    @NotNull
    private Integer id;

    private String remark;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date date;

    private Double money;

    private Integer type;

    private Boolean pay;
}
