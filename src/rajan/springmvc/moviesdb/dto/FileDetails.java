package rajan.springmvc.moviesdb.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="File_Details")
public class FileDetails implements Serializable {

	private static final long serialVersionUID = 2L;
	
	private int id;
	private String fileName;
	private String parentDir;
	private String filePath;
	private boolean hasSubtitles;
	private long fileSize;
	private long fileSizeOrig;
	private String displayName;
	private String category;
	private int seasonNo;
	private int episodeNo;
	

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Column
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Column
	public String getParentDir() {
		return parentDir;
	}
	public void setParentDir(String parentDir) {
		this.parentDir = parentDir;
	}
	
	@Column
	public boolean isHasSubtitles() {
		return hasSubtitles;
	}
	public void setHasSubtitles(boolean hasSubtitles) {
		this.hasSubtitles = hasSubtitles;
	}
	
	@Column
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	@Column
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	
	@Column
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Column
	public long getFileSizeOrig() {
		return fileSizeOrig;
	}
	public void setFileSizeOrig(long fileSizeOrig) {
		this.fileSizeOrig = fileSizeOrig;
	}
	
	@Column
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	@Column
	public int getSeasonNo() {
		return seasonNo;
	}
	public void setSeasonNo(int seasonNo) {
		this.seasonNo = seasonNo;
	}
	
	@Column
	public int getEpisodeNo() {
		return episodeNo;
	}
	public void setEpisodeNo(int episodeNo) {
		this.episodeNo = episodeNo;
	}
	
	

}
