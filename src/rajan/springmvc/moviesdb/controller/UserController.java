package rajan.springmvc.moviesdb.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import rajan.springmvc.moviesdb.persistence.User;
import rajan.springmvc.moviesdb.service.UserService;

@Controller
@RequestMapping("/moviesdb")
public class UserController {

	@Resource(name = "userService")
	private UserService userService;

	@RequestMapping(method = RequestMethod.GET, params = "new")
	public String displayRegForm(Model model) {
		System.out.println("Inside UC: Displaying user form");
		model.addAttribute("user", new User());
		return "moviesdb/regForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String createUser(@Valid User user, BindingResult bindingResult) {
		System.out.println("Inside UC, Processing User: " + user.getUsername());
		if (bindingResult.hasErrors()) {
			return "/moviesdb/";
		}
		userService.createUser(user);
		return "redirect:/moviesdb/" + user.getUsername();
	}

	@RequestMapping(method = RequestMethod.GET, value = "/{username}")
	public String displayWelcomeMsg(@PathVariable String username, Model model) {
		System.out.println("I am at UC, getting user by name");
		model.addAttribute("moviesdb", userService.getUserInfo(username));
		return "moviesdb/welcomePage";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/userHome")
	public String displayUserHome(Model model) {
		System.out.println("I am at UC, displaying User Home");
		List<String> mainList = userService.getMainListing();
		Map<String, List<String>> mapCat = new HashMap<String, List<String>>();
		for (String m : mainList) {
			mapCat.put(m, userService.getSubListing(m));

		}
		model.addAttribute("categories", mapCat);

		return "moviesdb/userHome";
	}
}
