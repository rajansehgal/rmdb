package rajan.springmvc.moviesdb.dao;

import java.util.List;

import rajan.springmvc.moviesdb.dto.FileDetails;

public interface MediaDao {

	List<FileDetails> getMediaDetails(String mediaType);
	List<FileDetails> getSeasonDetails(String seriesName, String seasonName);
	List<FileDetails> getJunkMediaDetails(long sizeCriteria);
}
