package com.terzobang.common;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component   // controller, service, repository
public class FileManagerService {
	
	//public final static String FILE_UPLOAD_PATH = "C:\\STS\\dailylookpic/";
	public final static String FILE_UPLOAD_PATH = "/home/ec2-user/upload_images/";
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<String> saveFile(List<MultipartFile> files, int ItemId) {
		List <String> imagesPath = new ArrayList<>(); // 최종 return 
		String directoryName = ItemId + "_" + System.currentTimeMillis() + "/";
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
	
	
	public void deleteFile(List<String> imagePathList) throws IOException {
		//  imagePath: /images/marobiana_1658476222233/20220629_140829.jpg
		// D:\\shinboram\\spring_project\\sns\\workspace\\images/ /images/marobiana_1658476222233/20220629_140829.jpg
		// 전체 경로와 imagePath간의 중복되는 /images/ 문자열을 제거한 후 실제 저장 경로를 찾는다.

		for (String imagePath : imagePathList) {
			imagePath = imagePath.replace("/images/", "");
			Path path = Paths.get(FILE_UPLOAD_PATH + imagePath);
			if (Files.exists(path)) { // 이미지 파일이 있으면 삭제
				Files.delete(path);
			}
			Path lastPath = path;
		}
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePathList.get(0).replace("/images/", ""));
		path = path.getParent();
		logger.debug(path.toString());
		
		if (Files.exists(path)) { // 폴더가 있으면 삭제
			Files.delete(path);
			}
			
		}
		
	}

