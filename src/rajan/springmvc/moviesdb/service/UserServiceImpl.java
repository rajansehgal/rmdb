package rajan.springmvc.moviesdb.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import rajan.springmvc.moviesdb.dao.UserDao;
import rajan.springmvc.moviesdb.dto.User;

@Service("userService")
@Transactional(propagation = Propagation.REQUIRED)
public class UserServiceImpl implements UserService {

	@Resource(name = "userDao")
	private UserDao userDao;

	@Override
	public void createUser(User user) {
		userDao.addUser(user);

	}

	@Override
	public User getUserInfo(String username) {
		return userDao.getUserInfo(username);

	}

	@Override
	public List<String> getMainListing() {
		return userDao.getMainListing();
	}

	@Override
	public List<String> getSubListing(String mainDir) {
		
		return userDao.getSubListing(mainDir);
	}


}
