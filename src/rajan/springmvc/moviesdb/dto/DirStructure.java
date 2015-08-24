package rajan.springmvc.moviesdb.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Dir_Structure")
public class DirStructure implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String dirName;
	private String parentDir;
	private boolean topLevel;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Column
	public String getDirName() {
		return dirName;
	}
	public void setDirName(String dirName) {
		this.dirName = dirName;
	}
	
	@Column
	public String getParentDir() {
		return parentDir;
	}
	public void setParentDir(String parentDir) {
		this.parentDir = parentDir;
	}
	
	@Column
	public boolean isTopLevel() {
		return topLevel;
	}
	public void setTopLevel(boolean topLevel) {
		this.topLevel = topLevel;
	}
	
	
	

	
	
	

}
