package com.ktw.nolja.common.vo;

import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

public class RSAKeyInfoVO {
	private PrivateKey privateKey;
	private PublicKey publicKey;
	
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
}