package com.aurora.mapper;

import com.aurora.entity.Carousel;
import com.aurora.model.vo.ConditionVO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author lihaodong
*/
@Mapper
public interface CarouselMapper extends BaseMapper<Carousel> {

    /**
     * 条件查询轮播图
     * @param current
     * @param size
     * @param conditionVO
     * @return
     */
    List<Carousel> listAdminCarousels(@Param("current") Long current, @Param("size") Long size,@Param("conditionVO") ConditionVO conditionVO);
}

