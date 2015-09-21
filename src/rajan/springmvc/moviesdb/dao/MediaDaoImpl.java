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
	
	@Override
	public List<FileDetails> getSeasonDetails(String seriesName, String seasonName) {
		Session session = currentSession();
		System.out.println("Series Name is: "+seriesName+" and Season Name is: "+seasonName);
		int seasonNo = Integer.parseInt(seasonName.substring(6).trim());
		System.out.println("Season # is: "+seasonNo);
		Criteria criteria = session.createCriteria(FileDetails.class);
		criteria.add(Restrictions.like("parentDir", seriesName, MatchMode.ANYWHERE));
		criteria.add(Restrictions.eq("seasonNo", Integer.valueOf(seasonNo)));
		criteria.add(Restrictions.gt("fileSize", Long.valueOf(10)));
		@SuppressWarnings("unchecked")
		final List<FileDetails> finalList = criteria.list();

		return finalList;
	}

	@Override
	public List<FileDetails> getJunkMediaDetails(long sizeCriteria) {
		Session session = currentSession();
		Criteria criteria = session.createCriteria(FileDetails.class);
		criteria.add(Restrictions.lt("fileSize", Long.valueOf(sizeCriteria)));
		@SuppressWarnings("unchecked")
		final List<FileDetails> finalList = criteria.list();

		return finalList;
	}

	

}
