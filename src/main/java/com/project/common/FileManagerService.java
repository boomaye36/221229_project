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
	//송현근 서버 경로
//	public static final String FILE_UPLOAD_PATH = "/Users/songhyeongeun/Desktop/코딩/spring/221229_project/workspace/images/";
	
	//김기훈 서버 경로
	public static final String FILE_UPLOAD_PATH = "C:\\Users\\김기훈\\Desktop\\20221229\\images/";
	
	//권예지 서버 경로
	public static final String FILE_UPLOAD_PATH = "C:\\Users\\dkahs\\Desktop\\github\\mega_team_221229\\project\\workspace\\images/";
//	public static final String FILE_UPLOAD_PATH = "C:\\Users\\dkahs\\OneDrive\\_MEGA\\mega_team_221229\\project\\workspace\\images/";
//	public static final String FILE_UPLOAD_PATH = "C:\\Users\\g1\\OneDrive\\_MEGA\\mega_team_221229\\project_home\\workspace\\images/";
	
	// input: 멀티파트 파일, userLoginId
	// output: 이미지..
	public String saveFile( MultipartFile file, String loginid) {
		// 파일 디렉토리 예) palang_16205468764/sun.png
		String directoryName =  loginid + "_" + System.currentTimeMillis() + "/"; //palang_16205468764/
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
		return "/images/" + directoryName + file.getOriginalFilename();
		//return "/static/img" + directoryName + file.getOriginalFilename();
	}
	public void deleteFile(String imagePath) {
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
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
