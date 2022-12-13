package com.terzobang;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class developController {
	@RequestMapping("/developing")
	public String mypage() {
		return "/mypage/main";
	}
	
	@RequestMapping("/test")
	public String test() {
		return "/test";
	}
	
	@RequestMapping("test2")
	@ResponseBody
	public String test2(@RequestParam("orderCount") List<Integer> orderCount) {
		
		
		return orderCount.get(0).getClass().getName();
	}

}
