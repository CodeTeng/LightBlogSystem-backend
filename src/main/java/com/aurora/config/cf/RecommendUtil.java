package com.aurora.config.cf;

import com.aurora.entity.ArticleScore;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author: lhd
 * @date: 2024/4/20
 * @description:
 */
public class RecommendUtil {

    /**
     * 推荐算法实现
     * @param keyId 用户Id或者物品Id
     * @param list 评分列表
     * @param type 算法类型 0基于用户推荐 1基于物品推荐
     * @return
     */
    public static List<DisValue> recommend(Long keyId, List<ArticleScore> list,int type) {
        Map<Long, List<ArticleScore>> recommendMap = Collections.emptyMap();

        if(type==1){
            // 按物品分组
            recommendMap =list.stream().collect(Collectors.groupingBy(ArticleScore::getArticleId));
        }else if(type==0){
            // 按用户分组
            recommendMap =list.stream().collect(Collectors.groupingBy(ArticleScore::getUserId));
        }


        //获取其他物品与当前物品的关系值
        Map<Long,Double>  itemDisMap = CoreMath.computeNeighbor(keyId, recommendMap,type);

        //获取关系最近物品
        double maxValue= Collections.max(itemDisMap.values());

        List<DisValue> disValues = itemDisMap.entrySet().stream()
                .map(e -> new DisValue(e.getKey(), e.getValue()))
                .collect(Collectors.toList());
        // 降序排序
        return disValues.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
    }
}
