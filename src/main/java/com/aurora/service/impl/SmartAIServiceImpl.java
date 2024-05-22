package com.aurora.service.impl;

import com.alibaba.dashscope.aigc.conversation.Conversation;
import com.alibaba.dashscope.aigc.conversation.ConversationParam;
import com.alibaba.dashscope.aigc.conversation.ConversationResult;
import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationOutput;
import com.alibaba.dashscope.aigc.generation.GenerationParam;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.aigc.generation.models.QwenParam;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.MessageManager;
import com.alibaba.dashscope.common.Role;
import com.alibaba.dashscope.exception.ApiException;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import com.alibaba.dashscope.utils.Constants;
import com.aurora.service.SmartAIService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/4/27 21:30
 */
@Service
public class SmartAIServiceImpl implements SmartAIService {
    @Value("${aliyun.tong-yi.api-key}")
    private String apiKey;

    @Override
    public String query(String queryMessage) {
        Constants.apiKey = apiKey;
//        try {
//            Generation gen = new Generation();
//            MessageManager msgManager = new MessageManager(10);
//            Message systemMsg = Message.builder().role(Role.SYSTEM.getValue()).content("你是一名全面的智能小助手").build();
//            Message userMsg = Message.builder().role(Role.USER.getValue()).content(queryMessage).build();
//            msgManager.add(systemMsg);
//            msgManager.add(userMsg);
//            QwenParam param = QwenParam.builder().model(Generation.Models.QWEN_PLUS).messages(msgManager.get()).resultFormat(QwenParam.ResultFormat.MESSAGE).build();
//            GenerationResult result = gen.call(param);
//            GenerationOutput output = result.getOutput();
//            Message message = output.getChoices().get(0).getMessage();
//            return message.getContent();
//        } catch (Exception e) {
//            return "智能小助手现在不在线，请稍后再试～";
//        }

        try {
            Conversation conversation = new Conversation();
            ConversationParam param = ConversationParam
                    .builder()
                    .apiKey(apiKey)
                    .model(Conversation.Models.QWEN_PLUS)
                    .prompt(queryMessage)
                    .build();
            ConversationResult result = conversation.call(param);
            return result.getOutput().getText();
        } catch (Exception e) {
            return "智能小助手现在不在线，请稍后再试～";
        }
    }
}
