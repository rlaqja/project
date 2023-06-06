package com.multi.gazee.member;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.util.IOUtils;
@PropertySource("classpath:application.properties")
@Service
public class ProfileAWSS3Biz {
	

	@Autowired
	private AmazonS3 s3Client;
	
	@Value("${memberImgBucket}")
    private String bucketName;
	
	
	public String uploadObject(MultipartFile multipartFile, String storedFileName) throws IOException {
		ObjectMetadata metadata = new ObjectMetadata();
		String filePath = storedFileName;
		byte[] bytes = IOUtils.toByteArray(multipartFile.getInputStream());
		metadata.setContentLength(bytes.length);
		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
		
		// 1. bucket name, 2. key : full path to the file 3. file : new File로 생성한 file instance  
		// 2. PutObjectRequest로 구현 가능 
		s3Client.putObject(new PutObjectRequest(bucketName, filePath, byteArrayInputStream, metadata));
		
		return s3Client.getUrl(bucketName, filePath).toString();
	}

	public void deleteObject( String storedFileName) throws AmazonServiceException {
		s3Client.deleteObject(new DeleteObjectRequest(bucketName , storedFileName));
	}

}


