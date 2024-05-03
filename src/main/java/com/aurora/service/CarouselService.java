package com.aurora.service;

import com.aurora.entity.Carousel;
import com.aurora.model.dto.PageResultDTO;
import com.aurora.model.vo.ConditionVO;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author lihaodong
*/
public interface CarouselService extends IService<Carousel> {

    /**
     * 后台
     * @return
     */
    PageResultDTO<Carousel> listAdminCarousels(ConditionVO conditionVO);
}


