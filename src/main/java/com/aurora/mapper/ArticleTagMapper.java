package com.aurora.mapper;

import com.aurora.entity.ArticleTag;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface ArticleTagMapper extends BaseMapper<ArticleTag> {

    /**
     * 获取通过审核的标签符合的文章数量
     * @param tagId
     * @return
     */
    @Select("select  count(1) " +
            "from t_article ta, t_article_tag tat,t_tag  tt " +
            "where ta.id = tat.article_id and tat.tag_id = tt.id and ta.review=1 and tt.id = #{tagId}")
    Integer getCountByTagId(@Param("tagId") Integer tagId);
}
