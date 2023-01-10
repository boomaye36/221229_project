package com.project.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.project.common.FileManagerService;
import com.project.interceptor.PermissionInterceptor;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Autowired
	private PermissionInterceptor interceptor;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
		.addResourceHandler("/images/**") // localhost 뒤에 주소 (웹주소)  http://localhost/images/palang_16205468764/sun.png
		.addResourceLocations("file://" + FileManagerService.FILE_UPLOAD_PATH); //실제 파일 위치 경로 // mac의 경우 하나만 적어야함 file:/
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(interceptor)

		.addPathPatterns("/**") // /post/post_list_view  /** 아래 디렉토리까지 확인
		.excludePathPatterns("/favicon.ico", "/error", "/user/sign_out", "/static/**");
	}
}