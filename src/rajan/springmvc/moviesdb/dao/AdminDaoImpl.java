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

import rajan.springmvc.moviesdb.dto.DirStructure;
import rajan.springmvc.moviesdb.dto.FileDetails;
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
	public void deleteUser(int id) {
		Session session = currentSession();
		User userToDelete = (User) session.get(User.class, (long) id);
		session.delete(userToDelete);
	}

	@Override
	public void disableUser(int id) {
		Session session = currentSession();
		User userToDisable = (User) session.get(User.class, (long) id);
		userToDisable.setApproved(false);
		session.saveOrUpdate(userToDisable);
	}

	@Override
	public void updateUserRole(int id, String role) {
		Session session = currentSession();
		User userToUpdate = (User) session.get(User.class, (long) id);
		userToUpdate.setRole(role);
		session.saveOrUpdate(userToUpdate);
	}

	@Override
	public List<User> getAllUsers() {
		Session session = currentSession();
		Criteria criteria = session.createCriteria(User.class);
		@SuppressWarnings("unchecked")
		final List<User> finalList = criteria.list();
		return finalList;
	}

	@Override
	public void updateFileDetails(List<FileDetails> fileDetails) {
		Session session = currentSession();
		session.createQuery("DELETE FROM FileDetails").executeUpdate();
		
		for (FileDetails f:fileDetails){
			session.save(f);
		}
		session.flush();
	}

	@Override
	public void updateDirStructure(List<DirStructure> dirStruct) {
		Session session = currentSession();
		session.createQuery("DELETE FROM DirStructure").executeUpdate();
		
		for (DirStructure d:dirStruct){
		session.save(d);
		}
		session.flush();
	}

	@Override
	public void cleanUpDb(long fileId) {
		Session session = currentSession();
		
		session.createQuery("DELETE FROM FileDetails Where id="+fileId).executeUpdate();
		session.flush();
		//	System.out.println("Dummy Deletion of record with File Id: "+fileId);
		
		
	}

		

}
