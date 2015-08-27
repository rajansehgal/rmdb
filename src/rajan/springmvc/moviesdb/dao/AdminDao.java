package rajan.springmvc.moviesdb.dao;

import java.util.List;

import rajan.springmvc.moviesdb.dto.User;


public interface AdminDao {

	List<User> getPendingUsers();
	List<User> getAllUsers();
	void enableInactiveUsers(int id, String role);
}
