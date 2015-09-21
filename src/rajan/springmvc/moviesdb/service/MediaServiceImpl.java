package rajan.springmvc.moviesdb.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import rajan.springmvc.moviesdb.dao.MediaDao;
import rajan.springmvc.moviesdb.dto.FileDetails;

@Service("mediaService")
@Transactional(propagation = Propagation.REQUIRED)
public class MediaServiceImpl implements MediaService {
	private final static long SIZE=20;
	
	@Resource(name="mediaDao")
	private MediaDao mediaDao;

	@Override
	public List<FileDetails> getMediaDetails(String mediaType) {
		
		return mediaDao.getMediaDetails(mediaType);
	}

	@Override
	public List<FileDetails> getSeasonDetails(String seriesName, String seasonName) {
		return mediaDao.getSeasonDetails(seriesName, seasonName);
	}
	
	@Override
	public List<FileDetails> getJunkMediaDetails() {
		return mediaDao.getJunkMediaDetails(SIZE);
	}

	

}
