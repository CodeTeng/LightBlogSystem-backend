package com.aurora.controller;
import com.alibaba.fastjson.JSON;
import com.aurora.annotation.OptLog;
import com.aurora.entity.Carousel;
import com.aurora.enums.FilePathEnum;
import com.aurora.model.dto.CarouselAddDTO;
import com.aurora.model.dto.CategoryDTO;
import com.aurora.model.dto.PageResultDTO;
import com.aurora.model.vo.ConditionVO;
import com.aurora.model.vo.ResultVO;
import com.aurora.service.CarouselService;
import com.aurora.strategy.context.UploadStrategyContext;
import com.aurora.util.PageUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import io.swagger.models.auth.In;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import static com.aurora.constant.OptTypeConstant.UPLOAD;


@Api(tags = "轮播图管理模块")
@Slf4j
@RestController
public class CarouselController {

    @Autowired
    private CarouselService carouselService;

    @Autowired
    private UploadStrategyContext uploadStrategyContext;

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
    @GetMapping("/admin/carousels")
    public ResultVO<PageResultDTO<Carousel>> listAdminCarousels(ConditionVO conditionVO) {
        return ResultVO.ok(carouselService.listAdminCarousels(conditionVO));
    }

    @ApiOperation("添加或修改轮播图")
    @PostMapping("/admin/carousels")
    public ResultVO<Boolean> saveOrUpdateCarousel(@RequestBody Carousel carousel) {
        boolean b = carouselService.saveOrUpdate(carousel);
        return ResultVO.ok(b);
    }

    @ApiOperation("删除轮播图")
    @DeleteMapping("/admin/carousels")
    public ResultVO<Boolean> deleteCarousel(@RequestBody List<Integer> Ids) {
        boolean b = carouselService.removeByIds(Ids);
        return ResultVO.ok(b);
    }

    @OptLog(optType = UPLOAD)
    @ApiOperation("上传轮播图")
    @ApiImplicitParam(name = "file", value = "轮播图", required = true, dataType = "MultipartFile")
    @PostMapping("/admin/carousels/images")
    public ResultVO<String> saveCarouselImages(MultipartFile file) {
        return ResultVO.ok(uploadStrategyContext.executeUploadStrategy(file, FilePathEnum.CAROUSEL.getPath()));
    }

}


