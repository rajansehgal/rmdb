package rajan.springmvc.moviesdb.dao;

import java.util.List;

import rajan.springmvc.moviesdb.dto.User;

public interface UserDao {

	void addUser(User user);
	User getUserInfo(String username);
	List<String> getMainListing();
	List<String> getSubListing(String mainDir);
}
