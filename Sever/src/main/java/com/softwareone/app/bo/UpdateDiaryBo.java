package com.softwareone.app.bo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author chenqiting
 */
@Data
public class UpdateDiaryBo {
    @NotNull
    private Integer id;
    private String content;
    private Date date;
    private String weather;
    private String emoji;
}
