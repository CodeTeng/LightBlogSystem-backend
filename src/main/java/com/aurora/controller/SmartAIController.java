package com.aurora.controller;

import com.aurora.model.vo.ResultVO;
import com.aurora.service.SmartAIService;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/4/27 21:29
 */
@RestController
@RequestMapping("/smartAi")
public class SmartAIController {
    @Resource
    private SmartAIService smartAIService;

    @GetMapping("/query")
    @ApiOperation("向智能小助手提问")
    public ResultVO<?> query(String queryMessage) {
        return ResultVO.ok(smartAIService.query(queryMessage));
    }
}
