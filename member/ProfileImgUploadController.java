package com.multi.gazee.member;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ProfileImgUploadController {
	
	@Autowired
	private ProfileAWSS3Biz s3Service;
	@Autowired
	MemberDAO dao;
	// 파일 업로드 처리
	@RequestMapping(value = "member/profile", method = RequestMethod.POST)
	public @ResponseBody void uploadMultipleFileHandler(@RequestParam("file") List<MultipartFile> multiFileList, MemberVO bag,HttpSession session) {
	    StringBuilder message = new StringBuilder();
	    String id = (String)session.getAttribute("id");
	    				
	    for (MultipartFile file : multiFileList) {
	        String originalFileName = file.getOriginalFilename();
	        String uuidFileName = getUuidFileName(originalFileName);
	        bag.setId(id);
	        bag.setProfileImg(uuidFileName);
	        try {
	            // ========= 서버에 파일 저장 ========= // 
	            s3Service.uploadObject(file, uuidFileName);
	            message.append("https://gazee.product.image.s3.ap-northeast-2.amazonaws.com/").append(uuidFileName).append("\n");
	        } catch (Exception e) {
	        	throw new RuntimeException("Failed to upload " + uuidFileName, e);
	        }
	        dao.profileImg(bag);
	    }
	}

	private static String getUuidFileName(String originalFileName) {
		return UUID.randomUUID().toString() + "_" + originalFileName;
	}
}