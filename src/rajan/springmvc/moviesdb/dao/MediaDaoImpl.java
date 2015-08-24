package rajan.springmvc.moviesdb.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import rajan.springmvc.moviesdb.dto.FileDetails;

@Repository("mediaDao")
public class MediaDaoImpl implements MediaDao {

	private SessionFactory sessionFactory;
	
	@Autowired
	public MediaDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	private Session currentSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public List<FileDetails> getMediaDetails(String mediaType) {
		Session session = currentSession();
		Criteria criteria = session.createCriteria(FileDetails.class);
		criteria.add(Restrictions.like("parentDir", mediaType, MatchMode.ANYWHERE));
		criteria.add(Restrictions.gt("fileSize", Long.valueOf(10)));
		@SuppressWarnings("unchecked")
		final List<FileDetails> finalList = criteria.list();

		return finalList;
	}

}
