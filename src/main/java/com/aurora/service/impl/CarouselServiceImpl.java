package com.aurora.service.impl;

import com.aurora.entity.Carousel;
import com.aurora.mapper.CarouselMapper;
import com.aurora.service.CarouselService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
* @author lihaodong
*/
@Service
public class CarouselServiceImpl extends ServiceImpl<CarouselMapper, Carousel> implements CarouselService {

    @Override
    public List<Carousel> listAdminCarousels() {
        return Collections.emptyList();
    }
}


