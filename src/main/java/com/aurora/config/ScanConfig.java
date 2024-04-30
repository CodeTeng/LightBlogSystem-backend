package com.aurora.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author lhd
 * @date 2024/4/28
 * @desc 文章内容审核配置类
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "aliyun.imageaudit")
public class ScanConfig {
    private String accessKeyId;
    private String accessKeySecret;
    private String endpoint;


    /**
     * 使用AK&SK初始化账号Client
     * @return Client
     * @throws Exception
     */
    @Bean("scanClient")
    public com.aliyun.imageaudit20191230.Client scanClient() throws Exception {
        com.aliyun.teaopenapi.models.Config config = new com.aliyun.teaopenapi.models.Config()
                .setAccessKeyId(accessKeyId)
                .setAccessKeySecret(accessKeySecret);
        config.endpoint = endpoint;
        return new com.aliyun.imageaudit20191230.Client(config);
    }
}
