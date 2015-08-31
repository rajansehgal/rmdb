package rajan.springmvc.moviesdb.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

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

	List<DirStructure> dirTable = new ArrayList<DirStructure>();
	List<FileDetails> fileTable = new ArrayList<FileDetails>();
	HashMap<String, Boolean> subKey = new HashMap<String, Boolean>();
	String PARENT_DIRECTORY;

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
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return adminDao.getAllUsers();
	}

	@Override
	public void syncDbwithHD(File currDir) {
		PARENT_DIRECTORY = currDir.getName();

		getDirStructure(currDir);

		for (DirStructure d : dirTable) {
			if (currDir.getName().equalsIgnoreCase(d.getParentDir())) {
				d.setTopLevel(true);
			}
		}

		for (FileDetails f : fileTable) {
			f.setHasSubtitles(subKey.containsKey(f.getFileName().substring(0,
					f.getFileName().lastIndexOf('.'))));
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
					fileDetails.setFileName(f.getName());
					String parentDir = "/";
					fileDetails.setFileSize((f.length() / 1024 / 1024));

					File temp = f.getParentFile();
					while (true) {

						parentDir = "/" + temp.getName() + parentDir;

						if (temp.getName().equalsIgnoreCase(PARENT_DIRECTORY)) {
							break;
						} else {
							temp = temp.getParentFile();
						}
					}

					fileDetails.setParentDir(parentDir);

					fileTable.add(fileDetails);
				}

			}
		}
	}

}
