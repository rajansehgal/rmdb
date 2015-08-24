package rajan.springmvc.moviesdb.service;

import java.util.List;

import rajan.springmvc.moviesdb.dto.User;

public interface AdminService {

	List<User> getPendingUsers();
}
