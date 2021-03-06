package rajan.springmvc.moviesdb.controller;

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

import rajan.springmvc.moviesdb.service.MediaService;

@Controller
@RequestMapping("/moviesdb/media/")
public class MediaController {

	@Resource(name = "mediaService")
	private MediaService mediaService;

	@RequestMapping(method = RequestMethod.GET, value = "/getMediaDetails")
	public void displayFileDetails(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("I am at MC, getting File Details for "
				+ request.getParameter("mediaName"));
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods",
				"POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(mediaService
				.getMediaDetails(request.getParameter("mediaName")));

		AbstractHttpMessageConverter<String> stringHttpMessageConverter = new StringHttpMessageConverter();
		MediaType jsonMimeType = MediaType.APPLICATION_JSON;
		if (stringHttpMessageConverter.canWrite(String.class, jsonMimeType)) {
			try {
				stringHttpMessageConverter.write(jsonString, jsonMimeType,
						new ServletServerHttpResponse(response));
			} catch (IOException m_Ioe) {
			} catch (HttpMessageNotWritableException p_Nwe) {
			}
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/seasonDetails")
	public void retrieveEpisodes(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		final String seriesName = request.getParameter("seriesName");
		final String seasonName = request.getParameter("seasonName");
		System.out.println("I am at MC, getting Episode Details for "
				+ seriesName+"s Season Name "+seasonName);
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods",
				"POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(mediaService.getSeasonDetails(seriesName, seasonName));

		AbstractHttpMessageConverter<String> stringHttpMessageConverter = new StringHttpMessageConverter();
		MediaType jsonMimeType = MediaType.APPLICATION_JSON;
		if (stringHttpMessageConverter.canWrite(String.class, jsonMimeType)) {
			try {
				stringHttpMessageConverter.write(jsonString, jsonMimeType,
						new ServletServerHttpResponse(response));
			} catch (IOException m_Ioe) {
			} catch (HttpMessageNotWritableException p_Nwe) {
			}
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/getNonMediaDetails")
	public void displayJunkFileDetails(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("I am at MC, getting Junk File Details");
		response.setContentType("application/json");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods",
				"POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(mediaService.getJunkMediaDetails());

		AbstractHttpMessageConverter<String> stringHttpMessageConverter = new StringHttpMessageConverter();
		MediaType jsonMimeType = MediaType.APPLICATION_JSON;
		if (stringHttpMessageConverter.canWrite(String.class, jsonMimeType)) {
			try {
				stringHttpMessageConverter.write(jsonString, jsonMimeType,
						new ServletServerHttpResponse(response));
			} catch (IOException m_Ioe) {
			} catch (HttpMessageNotWritableException p_Nwe) {
			}
		}
	}

}
