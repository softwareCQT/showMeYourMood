package com.softwareone.app.bo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.softwareone.app.entity.Memorandum;
import lombok.Data;

import javax.validation.Valid;
import java.util.Date;

/**
 * @author chenqiting
 */
@Data
public class SaveMemorandumBo {
    @Valid
    private Memorandum memorandum;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date date;
}
