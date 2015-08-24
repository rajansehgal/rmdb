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
	private boolean hasSubtitles;
	private long fileSize;
	
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
	
	
	
	

}
