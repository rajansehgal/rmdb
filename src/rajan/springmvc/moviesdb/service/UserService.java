package rajan.springmvc.moviesdb.service;

import java.util.List;

import rajan.springmvc.moviesdb.dto.User;

public interface UserService {

	void createUser(User user);
	User getUserInfo(String username);
	List<String> getMainListing();
	List<String> getSubListing(String mainDir);

}
