package com.terzobang;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class testController {
	
	@RequestMapping("test")
	public String Test() {
		return "admin/index";
	}
	
	@RequestMapping("test2")
	public String Test2() {
		return "admin/layout-static";
	}

}
