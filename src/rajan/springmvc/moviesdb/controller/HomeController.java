package rajan.springmvc.moviesdb.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
		// private SpitterService spitterService;
	// @Inject
	// public HomeController(SpitterService spitterService){
	// this.spitterService=spitterService;
	// }

	// @Resource(name = "spitterService")
	// private SpitterService spitterService;

	@RequestMapping({ "/", "/home" })
	public String showHomePage(Map<String, Object> model) {
		System.out.println("I am at HC");
		model.put("moviesdb", new String("Home"));
		return "template";
	}
	
}