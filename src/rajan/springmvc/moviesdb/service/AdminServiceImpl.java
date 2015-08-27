package rajan.springmvc.moviesdb.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import rajan.springmvc.moviesdb.dao.AdminDao;
import rajan.springmvc.moviesdb.dto.User;

@Service("adminService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminServiceImpl implements AdminService {
	
	@Resource(name="adminDao")
	private AdminDao adminDao;

	@Override
	public List<User> getPendingUsers() {
		// TODO Auto-generated method stub
		return adminDao.getPendingUsers();
	}

	@Override
	public boolean enableInactiveUsers(String[] userList) {

		for (String s: userList){
			adminDao.enableInactiveUsers(Integer.valueOf(s.split(":")[0].trim()), "ROLE_"+s.split(":")[1].trim());
		}
		return true;

	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return adminDao.getAllUsers();
	}

}
