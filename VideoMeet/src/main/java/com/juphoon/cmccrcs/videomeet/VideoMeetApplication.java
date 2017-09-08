package com.juphoon.cmccrcs.videomeet;

import com.juphoon.cmccrcs.videomeet.interceptor.CorsFilter;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

import javax.servlet.Filter;
import java.util.ArrayList;
import java.util.List;

@SpringBootApplication
@MapperScan("com.juphoon.cmccrcs.videomeet.mapper")
public class VideoMeetApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(VideoMeetApplication.class);
	}

	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}

	@Bean
	public FilterRegistrationBean filterRegistrationBean() {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		Filter corsFilter = new CorsFilter();
		registrationBean.setFilter(corsFilter);
		List<String> urlPatterns = new ArrayList<>();
		urlPatterns.add("/search/*");
		registrationBean.setUrlPatterns(urlPatterns);
		return registrationBean;
	}

	@Bean
	public ApplicationStartup applicationStartup() {
		return new ApplicationStartup();
	}

	public static void main(String[] args) {
		SpringApplication.run(VideoMeetApplication.class, args);
	}
}
