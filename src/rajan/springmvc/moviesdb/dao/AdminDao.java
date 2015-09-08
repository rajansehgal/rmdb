package rajan.springmvc.moviesdb.dao;

import java.util.List;

import rajan.springmvc.moviesdb.dto.DirStructure;
import rajan.springmvc.moviesdb.dto.FileDetails;
import rajan.springmvc.moviesdb.dto.User;


public interface AdminDao {

	List<User> getPendingUsers();
	List<User> getAllUsers();
	void enableInactiveUsers(int id, String role);
	void deleteUser(int id);
	void disableUser(int id);
	void updateUserRole(int id, String role);
	void updateFileDetails(List<FileDetails> fileDetails);
	void updateDirStructure(List<DirStructure> dirStruct);
}
