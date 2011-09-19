package domain;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class User {

	protected int userID;
	protected String userName;
	protected String password;
	protected String fullName;
	protected String email;
	protected String role;
	protected String phoneNumber;
	
	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	private static String convertToHex(byte[] data){
		
		StringBuffer buf=new StringBuffer();
		for(int i=0;i<data.length;i++){int halfbyte=(data[i]>>>4)& 0x0F;
		int two_halfs=0;
		do{if((0<=halfbyte)&& (halfbyte<=9))buf.append((char)('0'+halfbyte));
		else buf.append((char)('a'+(halfbyte-10)));
		halfbyte=data[i]&0x0F;
		} while(two_halfs++ <1);}
		
		return buf.toString();
		}
		
		public static String MD5(String text ) throws NoSuchAlgorithmException, UnsupportedEncodingException{
			
			MessageDigest md;
			md=MessageDigest.getInstance("MD5");
			
			byte[] md5hash=new byte[32];
			md.update(text.getBytes("iso-8859-1"), 0, text.length());
			md5hash=md.digest();
			return convertToHex(md5hash);
			
		}
		
	
	
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password){
		
		this.password=password;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	
}
