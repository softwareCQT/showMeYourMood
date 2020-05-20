package com.softwareone.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author chenqiting
 */
@Data
@AllArgsConstructor
public class PageData<T> {
    private Integer totalSize;
    private T list;
}
