package com.juphoon.cmccrcs.videomeet.config;

import com.juphoon.cmccrcs.videomeet.interceptor.MyInterceptor1;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;


/**
 * Created by Administrator on 2017/7/21.
 */
@Configuration
public class MyWebAppConfigurer
        extends WebMvcConfigurerAdapter {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(new MyInterceptor1()).addPathPatterns("/VideoMeet/**").excludePathPatterns("/VideoMeet/videoMeetList/**")
                .excludePathPatterns("/VideoMeet/videoMeetList/{currentPhone}").excludePathPatterns("/VideoMeet/error11");
        super.addInterceptors(registry);
    }

}
