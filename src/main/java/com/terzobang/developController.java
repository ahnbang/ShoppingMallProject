package com.terzobang;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class developController {
	@RequestMapping("/developing")
	public String mypage() {
		return "/mypage/main";
	}

}
