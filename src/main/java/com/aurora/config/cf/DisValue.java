package com.aurora.config.cf;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.jetbrains.annotations.NotNull;

import java.util.Objects;

/**
 * @author: lhd
 * @date: 2024/4/20
 * @description:  推荐算法计算出的结果类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DisValue implements Comparable<DisValue>{

    private Long keyId;

    private double value;

    @Override
    public int compareTo(@NotNull DisValue o) {
        return Double.compare(this.value, o.value);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DisValue disValue = (DisValue) o;
        return Double.compare(value, disValue.value) == 0 && Objects.equals(keyId, disValue.keyId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(keyId, value);
    }
}
