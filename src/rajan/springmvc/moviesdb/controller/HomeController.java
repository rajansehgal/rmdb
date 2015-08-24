package rajan.springmvc.moviesdb.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping({ "/", "/home" })
	public String showHomePage(Map<String, Object> model) {
		System.out.println("I am at HC");
		model.put("moviesdb", new String("Home"));
		return "user_template";
	}
	
}