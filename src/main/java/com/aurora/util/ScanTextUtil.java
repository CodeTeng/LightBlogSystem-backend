package com.aurora.util;

import com.aliyun.imageaudit20191230.Client;
import com.aliyun.imageaudit20191230.models.ScanTextRequest;
import com.aliyun.imageaudit20191230.models.ScanTextResponse;
import com.aliyun.imageaudit20191230.models.ScanTextResponseBody;
import com.aliyun.teautil.models.RuntimeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lhd
 * @date 2024/4/28
 * @desc 文章内容审核工具
 */
@Component
public class ScanTextUtil {

    /**
     * 指定文本检测的应用场景，可选值包括：
     * - spam：文字垃圾内容识别
     * - politics：文字敏感内容识别
     * - abuse：文字辱骂内容识别
     * - terrorism：文字暴恐内容识别
     * - porn：文字鉴黄内容识别
     * - flood：文字灌水内容识别
     * - contraband：文字违禁内容识别
     * - ad：文字广告内容识别
     */
    final String[] TextLabels = {"spam", "politics", "abuse", "terrorism", "porn", "flood", "contraband", "ad"};

    @Autowired
    private Client scanClient;

    /**
     * 获得指定文本检测的应用场景类型
     *
     * @return 校验的类型列表
     */
    public List<ScanTextRequest.ScanTextRequestLabels> getScanTextLabels() {
        List<ScanTextRequest.ScanTextRequestLabels> scanTextLabelList = new ArrayList<>();
        for (String label : TextLabels) {
            ScanTextRequest.ScanTextRequestLabels scanTextRequestLabels =
                    new ScanTextRequest.ScanTextRequestLabels().setLabel(label);
            scanTextLabelList.add(scanTextRequestLabels);
        }
        return scanTextLabelList;
    }

    public Map<String,String> doScanText(String content) {
        // 请求任务列表
        List<ScanTextRequest.ScanTextRequestTasks> taskList = new ArrayList<>();

        ScanTextRequest.ScanTextRequestTasks task = new ScanTextRequest.ScanTextRequestTasks()
                .setContent(content);
        taskList.add(task);

        ScanTextRequest scanTextRequest = new ScanTextRequest()
                //设置任务
                .setTasks(taskList)
                // 设置文本检验场景
                .setLabels(getScanTextLabels());

        RuntimeOptions runtimeOptions = new RuntimeOptions();
        runtimeOptions.setConnectTimeout(3000);
        runtimeOptions.setReadTimeout(6000);

        Map<String, String> resultMap = new HashMap<>();
        try {
            // 获得响应结果
            ScanTextResponse response = scanClient.scanTextWithOptions(scanTextRequest,runtimeOptions);


            // 处理数据
            List<ScanTextResponseBody.ScanTextResponseBodyDataElements> elements = response.body.data.elements;
            for (ScanTextResponseBody.ScanTextResponseBodyDataElements element : elements) {
                for (ScanTextResponseBody.ScanTextResponseBodyDataElementsResults result : element.results) {
                    if(!result.suggestion.equals("pass")){
                        resultMap.put("suggestion",result.suggestion);
                        resultMap.put("label",result.label);
                        return resultMap;
                    }
                }
            }

            resultMap.put("suggestion", "pass");
            return resultMap;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

