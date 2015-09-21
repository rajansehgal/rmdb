package rajan.springmvc.moviesdb.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import rajan.springmvc.moviesdb.dao.AdminDao;
import rajan.springmvc.moviesdb.dto.DirStructure;
import rajan.springmvc.moviesdb.dto.FileDetails;
import rajan.springmvc.moviesdb.dto.User;

@Service("adminService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminServiceImpl implements AdminService {

	List<DirStructure> dirTable;
	List<FileDetails> fileTable;
	HashMap<String, Boolean> subKey;
	String PARENT_DIRECTORY;
	private final static String SERIES = "TV Series";

	@Resource(name = "adminDao")
	private AdminDao adminDao;

	@Override
	public List<User> getPendingUsers() {
		// TODO Auto-generated method stub
		return adminDao.getPendingUsers();
	}

	@Override
	public boolean enableInactiveUsers(String[] userList) {

		for (String s : userList) {
			adminDao.enableInactiveUsers(
					Integer.valueOf(s.split(":")[0].trim()),
					"ROLE_" + s.split(":")[1].trim());
		}
		return true;

	}

	@Override
	public String updateUser(String selectedUser, String actionReqd) {
		
		int id= Integer.valueOf(selectedUser.split(":")[0].trim());
		if (actionReqd!=null){
			if (actionReqd.equals("Update Role")){
				adminDao.updateUserRole(id,
					"ROLE_" + selectedUser.split(":")[1].trim());
				return "Selected User has been successfully Updated";
			} else if (actionReqd.equals("Delete")){
				adminDao.deleteUser(id);
				return "Selected User has been successfully Deleted";
			} else if (actionReqd.equals("Disable")){
				adminDao.disableUser(id);
				return "Selected User has been successfully Disabled";
			} else {
				return "Invalid Choice of Action: "+actionReqd;
			}
		}
		
		return "No Action taken as User Info Received is Null";
	}

	
	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return adminDao.getAllUsers();
	}

	@Override
	public void syncDbwithHD(File currDir) {
		PARENT_DIRECTORY = currDir.getName();
		dirTable = new ArrayList<DirStructure>();
		fileTable = new ArrayList<FileDetails>();
		subKey = new HashMap<String, Boolean>();

		getDirStructure(currDir);

		for (DirStructure d : dirTable) {
			if (currDir.getName().equalsIgnoreCase(d.getParentDir())) {
				d.setTopLevel(true);
			}
		}

		if (!subKey.isEmpty()){
			for (FileDetails f : fileTable) {
				f.setHasSubtitles(subKey.containsKey(f.getFileName().substring(0,
						f.getFileName().lastIndexOf('.'))));
			}
		}
		

		adminDao.updateDirStructure(dirTable);
		adminDao.updateFileDetails(fileTable);

	}

	private void getDirStructure(File dirToScan) {

		File[] fileList = dirToScan.listFiles();
		DirStructure dirStruct = null;
		FileDetails fileDetails = null;

		for (File f : fileList) {

			if (f.isDirectory()) {
				dirStruct = new DirStructure();
				dirStruct.setDirName(f.getName());
				dirStruct.setParentDir(f.getParentFile().getName());
				dirTable.add(dirStruct);
				getDirStructure(f);
			}

			if (f.isFile()) {
				if (f.getName().endsWith(".srt")) {
					subKey.put(
							f.getName().substring(0,
									f.getName().indexOf(".srt")), true);
				} else {
					fileDetails = new FileDetails();
					String parentDir = "/";
					

					File temp = f.getParentFile();
					while (true) {

						parentDir = "/" + temp.getName() + parentDir;

						if (temp.getName().equalsIgnoreCase(PARENT_DIRECTORY)) {
							break;
						} else {
							temp = temp.getParentFile();
						}
					}
					
					if (f.getParentFile().isDirectory() && f.getParentFile().getName().contains("(") && f.getParentFile().getName().contains(")")){
						fileDetails.setDisplayName(f.getParentFile().getName().substring(0, f.getParentFile().getName().indexOf("(") - 1));
					} else {
						fileDetails.setDisplayName(f.getName());
					}


					fileDetails.setFileName(f.getName());
					fileDetails.setFileSize((f.length() / 1024 / 1024));
					fileDetails.setFileSizeOrig(f.length());
					fileDetails.setParentDir(parentDir);
					fileDetails.setFilePath(f.getAbsolutePath());
					
					if(parentDir.contains(SERIES)){
						fileDetails.setCategory(SERIES);
						
						if (f.getParentFile().getName().startsWith("E") && f.getParentFile().getName().substring(1).trim().matches("\\d+")){
							//System.out.println(f.getParentFile().getName().substring(1).trim()+f.getAbsolutePath());
							fileDetails.setEpisodeNo(Integer.parseInt(f.getParentFile().getName().trim().substring(1).trim()));
							if(f.getParentFile().getParentFile().getName().toUpperCase().startsWith("SEASON")){
								fileDetails.setSeasonNo(Integer.parseInt(f.getParentFile().getParentFile().getName().substring(6).trim()));
							}
						} else if(f.getParentFile().getName().toUpperCase().startsWith("SEASON")){
							fileDetails.setSeasonNo(Integer.parseInt(f.getParentFile().getName().substring(6).trim()));
							//System.out.println(f.getParentFile().getName().substring(6).trim());
						} else {
							System.out.println(f.getParentFile().getName().substring(1).trim()+" for "+f.getAbsolutePath());
						}
						
						
					}
					
					

					fileTable.add(fileDetails);
				}

			}
		}
	}

	@Override
	public void cleanUpHD(String[] fileList) {
		long fileId;
		String filePath;
		for (String s: fileList){
			System.out.println("Original String is: "+s);
			fileId= Long.valueOf(s.split("##")[0]);
			filePath = StringEscapeUtils.unescapeHtml(s.split("##")[1]);
			File tempFile = new File(filePath);
			System.out.println("Checking If I can delete: "+filePath);
			if (tempFile.exists() && tempFile.canExecute()){
				System.out.println("Yes I can, so shall I");
				if (tempFile.delete()){
					System.out.println("FIle Deleted, Lets get rid of it from Db");
					adminDao.cleanUpDb(fileId);
				}
			}
			}
		
	}

	
}
