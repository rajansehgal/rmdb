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
	
	@RequestMapping(method = RequestMethod.GET, value = "/userHome/getMediaDetails")
	public void displayFileDetails(HttpServletRequest request, HttpServletResponse response) throws IOException{
		///System.out.println("I am at UC, getting File Details for "+request.getHeader("mediaName"));
		//mv.addObject(userService.getMediaDetails(req.getHeader("MediaName")));
		System.out.println("I am at UC, getting File Details for "+request.getParameter("mediaName"));
		//PrintWriter out = response.getWriter();
		//JSONObject result = new JSONObject();
		//result.put("test", "TEST");
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		//out.println(result);
		
		
		ObjectMapper mapper = new ObjectMapper();
		Object userData = userService.getMediaDetails(request.getParameter("mediaName"));
		String jsonString = mapper.writeValueAsString(userService.getMediaDetails(request.getParameter("mediaName")));
		
 
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
