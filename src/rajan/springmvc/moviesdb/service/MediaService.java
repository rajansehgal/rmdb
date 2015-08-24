package rajan.springmvc.moviesdb.service;

import java.util.List;

import rajan.springmvc.moviesdb.dto.FileDetails;

public interface MediaService {

	List<FileDetails> getMediaDetails(String mediaType);
}
