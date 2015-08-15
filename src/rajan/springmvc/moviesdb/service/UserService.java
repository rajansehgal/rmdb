package rajan.springmvc.moviesdb.service;

import java.util.List;

import rajan.springmvc.moviesdb.persistence.FileDetails;
import rajan.springmvc.moviesdb.persistence.User;

public interface UserService {

	void createUser(User user);
	User getUserInfo(String username);
	List<String> getMainListing();
	List<String> getSubListing(String mainDir);
	List<FileDetails> getMediaDetails(String mediaType);
}
