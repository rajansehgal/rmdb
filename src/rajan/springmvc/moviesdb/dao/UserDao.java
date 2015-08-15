package rajan.springmvc.moviesdb.dao;

import java.util.List;

import rajan.springmvc.moviesdb.persistence.FileDetails;
import rajan.springmvc.moviesdb.persistence.User;

public interface UserDao {

	void addUser(User user);
	User getUserInfo(String username);
	List<String> getMainListing();
	List<String> getSubListing(String mainDir);
	List<FileDetails> getMediaDetails(String mediaType);
}
