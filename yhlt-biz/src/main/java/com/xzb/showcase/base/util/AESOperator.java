package com.xzb.showcase.base.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**AES 是一种可逆加密算法，对用户的敏感信息加密处理
* 对原始数据进行AES加密后，在进行Base64编码转化；
*/
@SuppressWarnings("restriction")
public class AESOperator {
	/*
	* 加密用的Key 可以用26个字母和数字组成
	* 此处使用AES-128-CBC加密模式，key需要为16位。
	*/
	private AESOperator() {

	}

	/**
	 * 加密
	 * @param encodeSrc   需要加密的字符串
	 * @param encodeKey   加密用的Key,可以用26个字母和数字组成,此处使用AES-128-CBC加密模式，key需要为16位。
	 * @param ivParameter 使用CBC模式，需要一个向量iv，可增加加密算法的强度
	 * @return
	 * @throws Exception
	 */
	public static String encrypt(String encodeSrc,String encodeKey,String ivParameter) throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		byte[] raw = encodeKey.getBytes();
		SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		IvParameterSpec iv = new IvParameterSpec(ivParameter.getBytes());//使用CBC模式，需要一个向量iv，可增加加密算法的强度
		cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
		byte[] encrypted = cipher.doFinal(encodeSrc.getBytes("utf-8"));
		return new BASE64Encoder().encode(encrypted);//此处使用BASE64做转码。
	}

	/**
	 * 解密
	 * @param decodeSrc    需要解密的串
	 * @param decodeKey    解密的key
	 * @param ivParameter  向量
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(String decodeSrc,String decodeKey,String ivParameter) throws Exception {
		try {
			byte[] raw = decodeKey.getBytes("ASCII");
			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			IvParameterSpec iv = new IvParameterSpec(ivParameter.getBytes());
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
			byte[] encrypted1 = new BASE64Decoder().decodeBuffer(decodeSrc);//先用base64解密
			byte[] original = cipher.doFinal(encrypted1);
			String originalString = new String(original, "utf-8");
			return originalString;
		} catch (Exception ex) {
			return null;
		}
	}
	
	public static void main(String[] args) {
		String password="123456";
		String passwordMd5 = MD5Util.MD5(password);
		System.out.println(passwordMd5);
		String encodeKey=passwordMd5.substring(0,16);
		String ivParameter=passwordMd5.substring(passwordMd5.length()-16);
		try {
			String passwordAes= encrypt(password, encodeKey, ivParameter);
			System.out.println(passwordAes);
			System.out.println(decrypt(passwordAes, encodeKey, ivParameter));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
