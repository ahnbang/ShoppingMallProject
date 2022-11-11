package com.terzobang.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component 
public class FileManagerService {
	public final static String FILE_UPLOAD_PATH = "C:\\STS\\terzobang/";
	
	public List<String> saveFile(String loginId, int boardId, List<MultipartFile> files) {
		List <String> imagesPath = new ArrayList<>(); // 최종 return 
		String directoryName = loginId + "_" + boardId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}
		
		
		for (MultipartFile file : files) {
			try {
					byte[] bytes = file.getBytes();
					Path path = Paths.get(filePath + file.getOriginalFilename());
					Files.write(path, bytes);
					imagesPath.add("/images/" + directoryName + file.getOriginalFilename());

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
				}return imagesPath;
		}
	
	
	public void deleteFile(String imagePath) throws IOException {
		
		imagePath = imagePath.replace("/images/", ""); 
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath);
		if (Files.exists(path)) { 
			Files.delete(path);
		}
		
		path = path.getParent();
		if (Files.exists(path)) { 
			Files.delete(path);
		}
	}
}
