package rajan.springmvc.moviesdb.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import rajan.springmvc.moviesdb.dto.DirStructure;
import rajan.springmvc.moviesdb.dto.User;

@Repository("userDao")
public class UserDaoImpl implements UserDao {
	private SessionFactory sessionFactory;

	@Autowired
	public UserDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	private Session currentSession() {
		return sessionFactory.getCurrentSession();
	}

	public void addUser(User user) {
		currentSession().save(user);
	}

	@Override
	public User getUserInfo(String username) {

		Session session = currentSession();
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Restrictions.eq("username", username));
		return (User) criteria.list().get(0);
	}

	@Override
	public List<String> getMainListing() {

		Session session = currentSession();
		Criteria criteria = session.createCriteria(DirStructure.class);
		criteria.add(Restrictions.eq("topLevel", true));
		criteria.add(Restrictions.ne("dirName", "TV Series"));
		criteria.setProjection(Projections.property("dirName"));
		@SuppressWarnings("unchecked")
		final List<String> finalList = criteria.list();

		return finalList;
	}

	
	@Override
	public List<String> getSubListing(String mainDir) {
		
		Session session = currentSession();
		Criteria criteria = session.createCriteria(DirStructure.class);
		criteria.add(Restrictions.eq("topLevel", false));
		criteria.add(Restrictions.eq("parentDir", mainDir));
		criteria.setProjection(Projections.property("dirName"));
		@SuppressWarnings("unchecked")
		final List<String> finalList = criteria.list();

		return finalList;
	}

	@Override
	public User updateUserInfo(long userId, String userData) {
		Session session = currentSession();
		User userToUpdate = (User) session.get(User.class, (long) userId);
		userToUpdate.setFullName(userData.split(":")[0]);
		userToUpdate.setEmail(userData.split(":")[1]);
		boolean emailFlag = (userData.split(":")[2].equals("true"))?true:false;
		userToUpdate.setUpdateByEmail(emailFlag);
		session.update(userToUpdate);
		return userToUpdate;
	}


	@Override
	public User updateUserPwd(long userId, String userData) {
		Session session = currentSession();
		User userToUpdate = (User) session.get(User.class, (long) userId);
		userToUpdate.setPassword(userData);
		session.update(userToUpdate);
		return userToUpdate;
	}

	
}
