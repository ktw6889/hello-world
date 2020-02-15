package com.ktw.nolja.common.util;

import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.Properties;

import javax.crypto.Cipher;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ktw.nolja.common.constant.CommonConstant;
import com.ktw.nolja.common.vo.MemberInfoVO;
import com.ktw.nolja.common.vo.RSAKeyInfoVO;

/*
 * Class 설명 : Util Class
 * Null 체크, 세션에 Team, Member, Rsa Key 셋
 * 암호화, 복호화 메서드
 */
public class CommonUtil {
	public static boolean isNullString(String str) {
		if(str != null && !"".equals(str)) {
			return false;	
		}
		return true;
	}
	
	public static boolean isNotNullString(String str) {
		if(str != null && !"".equals(str)) {
			return true;	
		}
		return false;
	}
	
	public static String nvlString(String str) {
		return nvlString(str, "");
	}
	
	public static String nvlString(String str, String defStr) {
		if(isNotNullString(str)) {
			return str;	
		}
		return defStr;
	}
	
	public static void setClubInfoVO(HttpServletRequest request, Object clubInfoVO) {
		HttpSession session = request.getSession();
		session.setAttribute(CommonConstant.CLUB_INFO_SESSION, clubInfoVO);
	}
	
	public static Object getClubInfoVO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return session.getAttribute(CommonConstant.CLUB_INFO_SESSION);
	}
	
	public static void setMemberInfoVO(HttpServletRequest request, MemberInfoVO memberInfoVO) {
		HttpSession session = request.getSession();
		session.setAttribute(CommonConstant.MEMBER_INFO_SESSION, memberInfoVO);
	}
	
	public static void removeMemberInfoVO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute(CommonConstant.MEMBER_INFO_SESSION);
	}
	
	public static MemberInfoVO getMemberInfoVO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (MemberInfoVO)session.getAttribute(CommonConstant.MEMBER_INFO_SESSION);
	}
	
	public static void setManagerInfoVO(HttpServletRequest request, MemberInfoVO memberInfoVO) {
		HttpSession session = request.getSession();
		session.setAttribute(CommonConstant.MANAGER_INFO_SESSION, memberInfoVO);
	}
	
	public static void removeManagerInfoVO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute(CommonConstant.MANAGER_INFO_SESSION);
	}
	
	public static MemberInfoVO getManagerInfoVO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (MemberInfoVO)session.getAttribute(CommonConstant.MANAGER_INFO_SESSION);
	}
	
	public static void setRSAKeyInfoVO(HttpServletRequest request, RSAKeyInfoVO rsaKeyInfoVO) {
		HttpSession session = request.getSession();
		session.setAttribute(CommonConstant.RSA_KEY_SESSION, rsaKeyInfoVO);
	}
	
	public static RSAKeyInfoVO getRSAKeyInfoVO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (RSAKeyInfoVO)session.getAttribute(CommonConstant.RSA_KEY_SESSION);
	}
	
	public static String decryptRsa(PrivateKey privateKey, String securedValue) {
		String decryptedValue = "";
		try {
			Cipher cipher = Cipher.getInstance("RSA");
			byte[] encryptedBytes = hexToByteArray(securedValue);
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
			decryptedValue = new String(decryptedBytes, "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return decryptedValue;
	}
	
	public static String encryptRsa(String modulus, String exponent, String securedValue) {
		String encryptedValue = "";
		try {
			Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			
			RSAPublicKeySpec publicSpec = new RSAPublicKeySpec(new BigInteger(modulus,16), new BigInteger(exponent,16));
			PublicKey publicKey = keyFactory.generatePublic(publicSpec);
			
			cipher.init(Cipher.ENCRYPT_MODE, publicKey);
			byte[] cipherText = cipher.doFinal(securedValue.getBytes("utf-8"));
			encryptedValue = byteArrayToHex(cipherText);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encryptedValue;
	}
	
	public static String encodeMd5(String securedValue) throws Exception {
		MessageDigest m = MessageDigest.getInstance("MD5");
		m.update(securedValue.getBytes(), 0, securedValue.length());
	    String digest = new BigInteger(1, m.digest()).toString(16);
	    return digest;
	}
	
	
	/**
	 * 비밀번호찾기_메일발송
	 * @param rcvEmail
	 * @param password
	 * @throws Exception
	 */
	public static void findPassSendMail(String rcvEmail , String password) throws Exception {
        
		String smtpServer = CommonInfo.getInstance().getSmtpServer();
        int smtpPort=Integer.parseInt(CommonInfo.getInstance().getSmtpPort());
        
        final String sendId = CommonInfo.getInstance().getSendMailId();
        final String sendPass = CommonInfo.getInstance().getSendMailPass();
        String sendEmailAddress = CommonInfo.getInstance().getSendMailAddress();   
         
        //---받는 분
        String subject = "안녕하세요. 파이팅싸커 입니다."; //---제목
        String content = "회원님의 임시 비밀번호는 "+password+" 입니다.";  //---내용

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", smtpServer);
		props.put("mail.smtp.port", smtpPort);

		Session session = Session.getInstance(props,
		
		new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(sendId, sendPass);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(sendEmailAddress));
		message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(rcvEmail));
		message.setSubject(subject);
		message.setText(content);
	
		Transport.send(message);
	
		System.out.println("Done");

	}
	
	// private --------------------------------------------------------------------------------------------------------------
	public static byte[] hexToByteArray(String hex) {
	    if (hex == null || hex.length() == 0) {
	        return null;
	    }
	    byte[] ba = new byte[hex.length() / 2];
	    for (int i = 0; i < ba.length; i++) {
	        ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
	    }
	    return ba;
	}
	
	private static String byteArrayToHex(byte[] ba) {
	    if (ba == null || ba.length == 0) {
	        return null;
	    }
	    StringBuffer sb = new StringBuffer(ba.length * 2);
	    String hexNumber;
	    for (int x = 0; x < ba.length; x++) {
	        hexNumber = "0" + Integer.toHexString(0xff & ba[x]);

	        sb.append(hexNumber.substring(hexNumber.length() - 2));
	    }
	    return sb.toString();
	} 
	
}