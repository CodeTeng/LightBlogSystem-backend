package com.aurora.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/3/1 20:06
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserActiveDTO {
    private String day;
    private Integer count;
}
