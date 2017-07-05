package com.juphoon.cmccrcs.videomeet;

import com.juphoon.cmccrcs.videomeet.service.TokenService;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.http.ResponseEntity;

/**
 * Created by JeffWang on 2017/6/29.
 */
public class ApplicationStartup implements ApplicationListener<ContextRefreshedEvent> {

    public void onApplicationEvent(ContextRefreshedEvent event) {

        if(event.getApplicationContext().getParent() == null) {
            System.out.println("onApplicationEvent");
            //在容器加载完毕后获取dao层来操作数据库
            TokenService tokenService = event.getApplicationContext().getBean(TokenService.class);
            tokenService.requestTokenByIAM();
        }
    }
}