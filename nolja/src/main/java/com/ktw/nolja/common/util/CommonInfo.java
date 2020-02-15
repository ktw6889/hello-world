package com.ktw.nolja.common.util;

import java.io.InputStream;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.Properties;

import com.ktw.nolja.club.service.NoljaClubService;

/*
 * Class 주요기능 : config.properties의 정보 로딩
 */
public class CommonInfo {
	private static CommonInfo mInstance;
	
	private String uploadPath;
	private int uploadMaxSize;
	private String uploadEncoding;
	private String urlMain;
	private String urlManagerMain;
	private String urlAdminMain;
	private String urlSoccerMain;
	
	private String versionNo;
	private String versionDate;
	
	//mail
	private String smtpServer;
	private String smtpPort;
	private String sendMailId;
	private String sendMailPass;
	private String SendMailAddress;
	
	private CommonInfo() {
		try {
			Properties prop = new Properties();
			String propFileName = "config.properties";
			InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
			if (inputStream != null) {
				prop.load(inputStream);
			}

			this.urlMain = prop.getProperty("url.main");
			this.uploadPath = prop.getProperty("upload.path");
			this.uploadMaxSize =  Integer.parseInt(prop.getProperty("upload.maxSize"));
			this.uploadEncoding = prop.getProperty("upload.encoding");
			
			this.versionNo = prop.getProperty("version.no");
			this.versionDate = prop.getProperty("version.date");
			
					
			//mail
			this.smtpServer = prop.getProperty("mail.stmpServer");
			this.smtpPort = prop.getProperty("mail.stmpPort");
			this.sendMailId = prop.getProperty("mail.sendMailId");
			this.sendMailPass = prop.getProperty("mail.sendMailPass");
			this.SendMailAddress = prop.getProperty("mail.sendMailAddress");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static CommonInfo getInstance() {
		if(mInstance == null) {
			mInstance = new CommonInfo();
		}
		return mInstance;
	}
	
	private PrivateKey privateKey;
	private PublicKey publicKey;
	private NoljaClubService clubService;	

	public NoljaClubService getClubService() {
		return clubService;
	}

	public void setClubService(NoljaClubService clubService) {
		this.clubService = clubService;
	}

	public PrivateKey getPrivateKey() {
		return privateKey;
	}
	public void setPrivateKey(PrivateKey privateKey) {
		this.privateKey = privateKey;
	}
	public PublicKey getPublicKey() {
		return publicKey;
	}
	public void setPublicKey(PublicKey publicKey) {
		this.publicKey = publicKey;
	}
	public String[] getModulusExponent() {
		String[] returnStr = new String[2];
		try {
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			if(publicKey != null) {
				RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
				returnStr[0] = publicSpec.getModulus().toString(16);
				returnStr[1] = publicSpec.getPublicExponent().toString(16);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public int getUploadMaxSize() {
		return uploadMaxSize;
	}
	public void setUploadMaxSize(int uploadMaxSize) {
		this.uploadMaxSize = uploadMaxSize;
	}
	public String getUploadEncoding() {
		return uploadEncoding;
	}
	public void setUploadEncoding(String uploadEncoding) {
		this.uploadEncoding = uploadEncoding;
	}
	public String getUrlMain() {
		return urlMain;
	}
	public void setUrlMain(String urlMain) {
		this.urlMain = urlMain;
	}
	public String getUrlManagerMain() {
		return urlManagerMain;
	}
	public void setUrlManagerMain(String urlManagerMain) {
		this.urlManagerMain = urlManagerMain;
	}
	public String getUrlSoccerMain() {
		return urlSoccerMain;
	}
	public void setUrlSoccerMain(String urlSoccerMain) {
		this.urlSoccerMain = urlSoccerMain;
	}
	
	public String getVersionNo() {
		return versionNo;
	}
	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}
	public String getVersionDate() {
		return versionDate;
	}
	public void setVersionDate(String versionDate) {
		this.versionDate = versionDate;
	}
	public String getUrlAdminMain() {
		return urlAdminMain;
	}
	public void setUrlAdminMain(String urlAdminMain) {
		this.urlAdminMain = urlAdminMain;
	}

	public String getSmtpServer() {
		return smtpServer;
	}

	public void setSmtpServer(String smtpServer) {
		this.smtpServer = smtpServer;
	}

	public String getSmtpPort() {
		return smtpPort;
	}

	public void setSmtpPort(String smtpPort) {
		this.smtpPort = smtpPort;
	}

	public String getSendMailId() {
		return sendMailId;
	}

	public void setSendMailId(String sendMailId) {
		this.sendMailId = sendMailId;
	}

	public String getSendMailPass() {
		return sendMailPass;
	}

	public void setSendMailPass(String sendMailPass) {
		this.sendMailPass = sendMailPass;
	}

	public String getSendMailAddress() {
		return SendMailAddress;
	}

	public void setSendMailAddress(String sendMailAddress) {
		SendMailAddress = sendMailAddress;
	}
	
}