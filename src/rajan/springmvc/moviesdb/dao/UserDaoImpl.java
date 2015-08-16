package rajan.springmvc.moviesdb.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import rajan.springmvc.moviesdb.persistence.DirStructure;
import rajan.springmvc.moviesdb.persistence.FileDetails;
import rajan.springmvc.moviesdb.persistence.User;

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
	public List<FileDetails> getMediaDetails(String mediaType) {
		Session session = currentSession();
		Criteria criteria = session.createCriteria(FileDetails.class);
		criteria.add(Restrictions.like("parentDir", mediaType, MatchMode.ANYWHERE));
		@SuppressWarnings("unchecked")
		final List<FileDetails> finalList = criteria.list();

		return finalList;
	}
}