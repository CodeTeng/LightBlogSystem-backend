package com.aurora.service.impl;

import com.aurora.entity.Carousel;
import com.aurora.mapper.CarouselMapper;
import com.aurora.model.dto.PageResultDTO;
import com.aurora.model.vo.ConditionVO;
import com.aurora.service.CarouselService;
import com.aurora.util.PageUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
* @author lihaodong
*/
@Service
public class CarouselServiceImpl extends ServiceImpl<CarouselMapper, Carousel> implements CarouselService {

    @Autowired
    private  CarouselMapper carouselMapper;

    @Override
    public PageResultDTO<Carousel> listAdminCarousels(ConditionVO conditionVO) {
        // 计算总数
        Integer count = carouselMapper.selectCount(new QueryWrapper<Carousel>());
        if (count == 0) {
            return new PageResultDTO<>();
        }
        List<Carousel> list =  carouselMapper.listAdminCarousels(PageUtil.getLimitCurrent(), PageUtil.getSize(), conditionVO);
        return new PageResultDTO<>(list,count);
    }
}


