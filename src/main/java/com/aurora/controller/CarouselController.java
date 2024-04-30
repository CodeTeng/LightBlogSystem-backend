package com.aurora.controller;
import com.aurora.entity.Carousel;
import com.aurora.model.dto.CarouselAddDTO;
import com.aurora.model.dto.CategoryDTO;
import com.aurora.model.vo.ResultVO;
import com.aurora.service.CarouselService;
import com.aurora.util.PageUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


@Api(tags = "轮播图管理模块")
@Slf4j
@RestController
public class CarouselController {

    @Autowired
    private CarouselService carouselService;

    @ApiOperation("获取所有轮播图")
    @GetMapping("/carousels/all")
    public ResultVO<List<String>> listCarousels() {
        List<Carousel> list = carouselService.lambdaQuery().eq(Carousel::getStatus, 1)
                .orderByDesc(Carousel::getSort)
                .list();
        List<String> collect = list.stream().map(Carousel::getUrl).collect(Collectors.toList());
        return ResultVO.ok(collect);
    }

    @ApiOperation("后台获取所有轮播图")
    @GetMapping("/admin/carousels/all")
    public ResultVO<List<Carousel>> listAdminCarousels() {
        return ResultVO.ok(carouselService.listAdminCarousels());
    }

    @ApiOperation("添加或修改轮播图")
    @PostMapping("/admin/carousels")
    public ResultVO<Boolean> saveOrUpdateCarousel(@RequestBody Carousel carousel) {
        boolean b = carouselService.saveOrUpdate(carousel);
        return ResultVO.ok(b);
    }

    @ApiOperation("删除轮播图")
    @DeleteMapping("/admin/carousels/{id}")
    public ResultVO<Boolean> deleteCarousel(@PathVariable("id") String carouselId) {
        boolean b = carouselService.removeById(carouselId);
        return ResultVO.ok(b);
    }

}


