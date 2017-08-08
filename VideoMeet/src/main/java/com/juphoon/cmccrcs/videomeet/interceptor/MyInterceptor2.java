package com.juphoon.cmccrcs.videomeet.interceptor;


import com.google.gson.Gson;
import com.juphoon.cmccrcs.videomeet.common.ResponseEntity;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/8/7.
 */

public class MyInterceptor2 implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        Cookie[] cookies = request.getCookies();
        String username = null;
        if(cookies==null)
        {

        response.getWriter().print(createJsonString(ResponseEntity.cookieTimeFail()));
//            response.getWriter().print(ResponseEntity.cookieTimeFail());
//            System.out.println(ResponseEntity.cookieTimeFail());
            return false;
        }

        for (int i = 0; i < cookies.length; i++)
        {
                Cookie c = cookies[i];
                if (c.getName().equalsIgnoreCase("name"))
                {
                    username = c.getValue();
                   c.setMaxAge(60*30);

                    response.addCookie(c);
                }

        }

            if (username == null)
            {

               response.getWriter().print(createJsonString(ResponseEntity.cookieTimeFail()));
//                response.getWriter().print(ResponseEntity.cookieTimeFail());
//                System.out.println(ResponseEntity.cookieTimeFail());
                return false;
            }

        return true;// 只有返回true才会继续向下执行，返回false取消当前请求
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        // System.out.println(">>>MyInterceptor1>>>>>>>请求处理之后进行调用，但是在视图被渲染之前（Controller方法调用之后）");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        //System.out.println(">>>MyInterceptor1>>>>>>>在整个请求结束之后被调用，也就是在DispatcherServlet 渲染了对应的视图之后执行（主要是用于进行资源清理工作）");
    }


    private  String createJsonString(Object value)
    {
        Gson gson = new Gson();
        String str = gson.toJson(value);
        return str;
    }
}


