package rajan.springmvc.moviesdb.service;

import java.io.File;
import java.util.List;

import rajan.springmvc.moviesdb.dto.User;

public interface AdminService {

	List<User> getPendingUsers();
	List<User> getAllUsers();
	boolean enableInactiveUsers(String[] userList);
	void syncDbwithHD(File currDir);
}
