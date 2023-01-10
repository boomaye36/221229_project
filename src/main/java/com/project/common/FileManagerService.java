package com.project.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component  // 일반적인 스프링 빈
public class FileManagerService {
	private Logger log = LoggerFactory.getLogger(FileManagerService.class);
	//실제 이미지가 저장될 경로(서버)
	public static final String FILE_UPLOAD_PATH = "/Users/songhyeongeun/Desktop/코딩/spring/221229_project/clone/src/main/resources/static/img";
	// input: 멀티파트 파일, userLoginId
	// output: 이미지..
	public String saveFile( MultipartFile file) {
		// 파일 디렉토리 예) palang_16205468764/sun.png
		String directoryName =  "_" + System.currentTimeMillis() + "/"; //palang_16205468764/
		String filePath = FILE_UPLOAD_PATH + directoryName; 
		
		File directory = new File(filePath);
		if(directory.mkdir() == false) {
			return null; //디렉토리 생성 실패 시 null 리턴
		}
		//파일 업로드 : byte 단위로 업로드한다.
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath  + file.getOriginalFilename()); // OriginalFilename은 사용자가 업로드한 파일 이름
			Files.write(path, bytes);
			//System.out.println("path ###"+path);
		} catch (IOException e) {
			
			e.printStackTrace();
			return null;
		}
		// 성공 했으면 이미지 url path를 리턴한다. (WebMvConfig 에서 매핑한 이미지 path)
		// http://localhost/images/palang_16205468764/sun.png
		return "/post/" + directoryName +file.getOriginalFilename();
	}
	public void deleteFile(String imagePath) {
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/post/", ""));
		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				log.error("[이미지 삭제] 디렉토리 삭제 실패 imagePath:{}", imagePath );
			}		}
		
		path = path.getParent();
		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				log.error("[이미지 삭제] 디렉토리 삭제 실패 imagePath:{}", imagePath );
			}
		}
	}
	
}
