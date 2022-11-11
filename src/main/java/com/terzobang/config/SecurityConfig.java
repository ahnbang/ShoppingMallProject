
package com.terzobang.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity // spring security 적용 Annotation
@Configuration
public class SecurityConfig {
		
		//http 보안설정
	    @Bean
	    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	    	// 권한체크 범위 설정
	    	http.authorizeHttpRequests()
	            .mvcMatchers("/", "/static/**").permitAll()
	            .antMatchers("/**").permitAll();
	            /**
	            .antMatchers("/", "/index", "/member/sign_in", "/member/sign_up_view", "/member/sign_up", "/test", "/member/sign_up").permitAll() //인증 없이 접근 가능한 url, 그외는 전부 인증 필요
	            		.anyRequest().authenticated();
	           **/
	    	
	        // 로그인 부분 설정
	        http.formLogin()
	            .loginPage("/security/login")
	            .loginProcessingUrl("/secure/login_exe")
	            .usernameParameter("userid")
	            .defaultSuccessUrl("/")
	            .permitAll();
	        
	        // 로그아웃 부분 설정
	    	http.logout()
	            	.permitAll();
	    	
	    	
	    	http.csrf().disable();
	        return http.build();
	    }
	    
	    @Bean
	    public WebSecurityCustomizer webSecurityCustomizer() {
	        return (web) -> web
	                .ignoring()
	                .antMatchers("/resources/**");
	    }
	
	//해쉬함수로 암호화처리
	   @Bean
	   public PasswordEncoder passwordEncoder() {
		   return new BCryptPasswordEncoder();
    }
	
	

}
