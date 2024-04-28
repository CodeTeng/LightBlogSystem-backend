package com.aurora.util;

import org.commonmark.Extension;
import org.commonmark.ext.gfm.tables.TableBlock;
import org.commonmark.ext.gfm.tables.TablesExtension;
import org.commonmark.ext.heading.anchor.HeadingAnchorExtension;
import org.commonmark.node.Link;
import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.AttributeProvider;
import org.commonmark.renderer.html.AttributeProviderContext;
import org.commonmark.renderer.html.AttributeProviderFactory;
import org.commonmark.renderer.html.HtmlRenderer;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @description:
 * @author: ~Teng~
 * @date: 2024/3/21 14:41
 */
public class MarkdownToHtmlUtil {
    /**
     * markdown格式转换成HTML格式
     */
    public static String markdownToHtml(String markdown) {
        Parser parser = Parser.builder().build();
        Node document = parser.parse(markdown);
        HtmlRenderer renderer = HtmlRenderer.builder().build();
        return renderer.render(document);
    }

    /**
     * 增加扩展[标题锚点，表格生成]
     * Markdown转换成HTML
     */
    public static String markdownToHtmlExtensions(String markdown) {
        //h标题生成id
        Set<Extension> headingAnchorExtensions = Collections.singleton(HeadingAnchorExtension.create());
        //转换table的HTML
//        List<Extension> tableExtension = Arrays.asList(TablesExtension.create());
        List<Extension> tableExtension = Collections.singletonList(TablesExtension.create());
        Parser parser = Parser.builder()
                .extensions(tableExtension)
                .build();
        Node document = parser.parse(markdown);
        HtmlRenderer renderer = HtmlRenderer.builder()
                .extensions(headingAnchorExtensions)
                .extensions(tableExtension)
                .attributeProviderFactory(new AttributeProviderFactory() {
                    public AttributeProvider create(AttributeProviderContext context) {
                        return new CustomAttributeProvider();
                    }
                })
                .build();
        return renderer.render(document);
    }

    /**
     * 处理标签的属性
     */
    static class CustomAttributeProvider implements AttributeProvider {
        @Override
        public void setAttributes(Node node, String tagName, Map<String, String> attributes) {
            //改变a标签的target属性为_blank
            if (node instanceof Link) {
                attributes.put("target", "_blank");
            }
            if (node instanceof TableBlock) {
                attributes.put("class", "ui celled table");
            }
        }
    }

    public static void main(String[] args) throws IOException {
        String src = "## SpringBoot 的概述\n" +
                "Spring Boot 是 Spring 项目中的一个子工程，与我们所熟知的 Spring-framework 同属于 Spring 的产品\n" +
                "其最主要作用就是帮助开发人员快速的构建庞大的 Spring 项目，并且尽可能的减少一切xml配置，做到开箱即用，迅速上手，让开发人员关注业务而非配置\n" +
                "主要特点:\n" +
                "1. 自动配置 : 不需要再关注各个框架的整合配置, SpringBoot 全部已经配置好了\n" +
                "2. 起步依赖 : 我们在需要使用某个框架的时候, 直接添加这个框架的启动器依赖即可 , 不需要在关注jar包的冲突和整合\n" +
                "设计目的： 用来简化 Spring应用的初始搭建以及开发过程\n" +
                "总结：\n" +
                "1. 为所有 Spring 开发提供一个更快更广泛的入门体验。\n" +
                "2. 零配置。无冗余代码生成和XML 强制配置，遵循“约定大于配置” 。\n" +
                "3. 集成了大量常用的第三方库的配置， SpringBoot 应用为这些第三方库提供了几乎可以零配置的开箱即用的能力。\n" +
                "4. 提供一系列大型项目常用的非功能性特征，如嵌入服务器等。\n" +
                "思考：为什么我们在添加启动器的时候不需要在启动器的坐标中指定版本？\n" +
                "因为我们指定了项目的父工程，在spring-boot-starter-parent中已经通过Maven的版本锁定了Jar包的版本，所以就不需要再指定了";
        System.out.println(markdownToHtmlExtensions(src));
    }
}
