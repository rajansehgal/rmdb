package rajan.springmvc.moviesdb.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import rajan.springmvc.moviesdb.dto.User;

@Repository("adminDao")
public class AdminDaoImpl implements AdminDao {
	
	
	private SessionFactory sessionFactory;

	@Autowired
	public AdminDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	private Session currentSession() {
		return sessionFactory.getCurrentSession();
	}
	

	@Override
	public List<User> getPendingUsers() {
		Session session = currentSession();
		Criteria criteria = session.createCriteria(User.class);
		Criterion status = Restrictions.eq("approved", false);
		Criterion role = Restrictions.isNull("role");
		LogicalExpression orExp = Restrictions.or(status, role);
		criteria.add(orExp);
		@SuppressWarnings("unchecked")
		final List<User> finalList = criteria.list();

		return finalList;
	}

	@Override
	public void enableInactiveUsers(int id, String role) {
				
		Session session = currentSession();
		User userToActivate = (User) session.get(User.class, (long) id);
		userToActivate.setRole(role);
		userToActivate.setApproved(true);
		session.saveOrUpdate(userToActivate);
	}

	@Override
	public List<User> getAllUsers() {
		Session session = currentSession();
		Criteria criteria = session.createCriteria(User.class);
		@SuppressWarnings("unchecked")
		final List<User> finalList = criteria.list();
		return finalList;
	}

	

}
