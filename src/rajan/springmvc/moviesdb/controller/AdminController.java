package rajan.springmvc.moviesdb.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.MediaType;
import org.springframework.http.converter.AbstractHttpMessageConverter;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import rajan.springmvc.moviesdb.service.AdminService;

@Controller
@RequestMapping("/moviesdb/admin/")
public class AdminController {

	private final static String DRIVE_LABEL="H:\\";
	@Resource(name="adminService")
	private AdminService adminService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/disabledUsers")
	public void displayInactiveUsers(HttpServletRequest request, HttpServletResponse response) throws IOException{
		System.out.println("I am at AC, getting Pending User Details");
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
				
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(adminService.getPendingUsers());
		
 
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
	
	@RequestMapping(method = RequestMethod.GET, value = "/AllUsers")
	public void displayAllUsers(HttpServletRequest request, HttpServletResponse response) throws IOException{
		System.out.println("I am at AC, getting All Users Details");
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
				
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(adminService.getAllUsers());
		
 
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

	
	@RequestMapping(method = RequestMethod.GET, value = "/enableUsers")
	public void enableInactiveUsers(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userList[]") String[] userList) throws IOException{
		String[] userListTemp=userList;
		for(String s: userListTemp){
			System.out.println("I am at AC, enabling User: "+s);
		}
		System.out.println("I am at AC, enabling Users: "+userListTemp.toString()+" and Length is "+userListTemp.length);
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		
		
		 ObjectMapper mapper = new ObjectMapper();
		 Object userData = new String(((adminService.enableInactiveUsers(userList))?"User(s) Updated Successfully":" User(s) Update Failed"));
		 String jsonString = mapper.writeValueAsString(userData);
		 
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
	
	@RequestMapping(method = RequestMethod.GET, value = "/updateUser")
	public void updateUser(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userSelected") String userSelected, @RequestParam(value="userAction") String userAction) throws IOException{
		
			System.out.println("I am at AC, updating User: "+userSelected);
		
		
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		
		
		 ObjectMapper mapper = new ObjectMapper();
		 Object userData = new String(adminService.updateUser(userSelected, userAction));
		 String jsonString = mapper.writeValueAsString(userData);
		 
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
	
	@RequestMapping(method = RequestMethod.GET, value = "/syncDbwithHD")
	public void syncHDtoLocalDb(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		System.out.println("I am at AC, updating Db");
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		
        File currDir = new File("H:\\Media & Entertainment");
        String msg="";
		
		if (currDir.canRead()){
			long startTime=System.nanoTime();
			adminService.syncDbwithHD(currDir);
			msg="Time Taken is: "+(System.nanoTime()-startTime)/1000000+" ms";
			
		} else {
			msg="HD not connected";
		}
		
		 ObjectMapper mapper = new ObjectMapper();
		 Object userData = new String(msg);
		 String jsonString = mapper.writeValueAsString(userData);
		 
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
	
	@RequestMapping(method = RequestMethod.POST, value = "/cleanupHd")
	public void cleanHDJunkData(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="filesSelected[]") String[] filesSelected) throws IOException{
		
			System.out.println("I am at AC, Cleaning FIles");	
		
		
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		
        File currDir = new File(DRIVE_LABEL);
        String msg="";
		
		if (currDir.canRead()){
			long startTime=System.nanoTime();
			adminService.cleanUpHD(filesSelected);
			msg="Time Taken is: "+(System.nanoTime()-startTime)/1000000+" ms";
			
		} else {
			msg="HD not connected";
		}
		
		 ObjectMapper mapper = new ObjectMapper();
		 Object userData = new String(msg);
		 String jsonString = mapper.writeValueAsString(userData);
		 
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
