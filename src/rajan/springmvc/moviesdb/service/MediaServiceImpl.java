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
	
	@Resource(name="mediaDao")
	private MediaDao mediaDao;

	@Override
	public List<FileDetails> getMediaDetails(String mediaType) {
		
		return mediaDao.getMediaDetails(mediaType);
	}

}
