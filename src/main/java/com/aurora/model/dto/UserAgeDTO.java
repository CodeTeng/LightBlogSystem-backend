package com.aurora.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/3/2 11:44
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserAgeDTO {
    private String interval;
    private Integer count;
}
