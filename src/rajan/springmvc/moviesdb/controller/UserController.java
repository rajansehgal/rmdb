package rajan.springmvc.moviesdb.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.MediaType;
import org.springframework.http.converter.AbstractHttpMessageConverter;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import rajan.springmvc.moviesdb.dto.User;
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
			System.out.println(bindingResult.getFieldErrors("password").toString());
			
			return "moviesdb/regForm";
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
		List<String> seriesList = userService.getSubListing("TV Series");
		Map<String, List<String>> mapCat = new HashMap<String, List<String>>();
		Map<String, List<String>> seriesCat = new HashMap<String, List<String>>();
		for (String m : mainList) {
			mapCat.put(m, userService.getSubListing(m));

		}
		
		for (String s : seriesList) {
			seriesCat.put(s, userService.getSubListing(s));

		}
		model.addAttribute("categories", mapCat);
		
		
		
		model.addAttribute("seriesList", seriesCat);

		return "moviesdb/userHome";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/userHome/updateUserInfo")
	public void updateUserInfo(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userSelected") long userSelected, @RequestParam(value="userData") String userData, Model model) throws IOException{
		
		System.out.println("I am at UC, User Id: "+userSelected+" will be updated with data: "+userData);
		
		model.addAttribute("user", userService.updateUserInfo(userSelected, userData));
		
		
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
				
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString("User Updated Successfully");
		
 
        AbstractHttpMessageConverter<String> stringHttpMessageConverter = new StringHttpMessageConverter();
        MediaType jsonMimeType = MediaType.APPLICATION_JSON;
        if (stringHttpMessageConverter.canWrite(String.class, jsonMimeType)) {
            try {
                stringHttpMessageConverter.write(jsonString, jsonMimeType, new ServletServerHttpResponse(response));
            } catch (IOException m_Ioe) {
            } catch (HttpMessageNotWritableException p_Nwe) {
            }
        }
		
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/userHome/CurrentUserInfo")
	public void getCurrentUserInfo(HttpServletRequest request, HttpServletResponse response) throws IOException{
		final String currentUser = SecurityContextHolder.getContext().getAuthentication().getName();
		System.out.println("I am at UC, User Id: "+currentUser+" will be retrieved ");
		
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
				
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(userService.getUserInfo(currentUser));
		
 
        AbstractHttpMessageConverter<String> stringHttpMessageConverter = new StringHttpMessageConverter();
        MediaType jsonMimeType = MediaType.APPLICATION_JSON;
        if (stringHttpMessageConverter.canWrite(String.class, jsonMimeType)) {
            try {
                stringHttpMessageConverter.write(jsonString, jsonMimeType, new ServletServerHttpResponse(response));
            } catch (IOException m_Ioe) {
            } catch (HttpMessageNotWritableException p_Nwe) {
            }
        }
		
		
	}

	
	@RequestMapping(method = RequestMethod.GET, value = "/userHome/updateUserPwd")
	public void updateUserPwd(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userSelected") long userSelected, @RequestParam(value="userData") String userData, Model model) throws IOException{
		
		System.out.println("I am at UC, User Id: "+userSelected+" will be updated with Password: "+userData);
		
		model.addAttribute("user", userService.updateUserPwd(userSelected, userData));
		
		
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
				
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString("User's Password Updated Successfully");
		
 
        AbstractHttpMessageConverter<String> stringHttpMessageConverter = new StringHttpMessageConverter();
        MediaType jsonMimeType = MediaType.APPLICATION_JSON;
        if (stringHttpMessageConverter.canWrite(String.class, jsonMimeType)) {
            try {
                stringHttpMessageConverter.write(jsonString, jsonMimeType, new ServletServerHttpResponse(response));
            } catch (IOException m_Ioe) {
            } catch (HttpMessageNotWritableException p_Nwe) {
            }
        }
		
		
	}

}
