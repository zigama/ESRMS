package manager;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.User;

public class UserManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<User> listUser = new ArrayList<User>();
	protected User user;

public int countUsers(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	int rows=0;
	
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM sys_user,sys_role WHERE sys_user.role_id=sys_role.role_id ");

		srs.beforeFirst();
		while (srs.next()) {
			rows++;
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}
	return rows;
	
}	

public ArrayList<User> searchUser(User user){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM sys_user,sys_role WHERE user_id='"+user.getUserID()+"' AND sys_user.role_id=sys_role.role_id OR username='"+user.getUserName()+"' AND sys_user.role_id=sys_role.role_id");

			srs.beforeFirst();
			while (srs.next()) {
				user= new User();
				user.setUserID(Integer.parseInt(srs.getString("user_id")));
				user.setUserName(srs.getString("username"));
				user.setPassword(srs.getString("passwd"));
				user.setFullName(srs.getString("full_name"));
				user.setEmail(srs.getString("email_addr"));
				user.setRole(srs.getString("role_name"));
				user.setPhoneNumber(srs.getString("phone_number"));
				
				listUser.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	return listUser;
	}
public ArrayList<User> autoSearch(String key){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	String message="";
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM sys_user,sys_role WHERE sys_user.role_id=sys_role.role_id AND sys_user.username LIKE '%"+key+"%' ");

		srs.beforeFirst();
		while (srs.next()) {
			user= new User();
			user.setUserID(Integer.parseInt(srs.getString("user_id")));
			user.setUserName(srs.getString("username"));
			user.setPassword(srs.getString("passwd"));
			user.setFullName(srs.getString("full_name"));
			user.setEmail(srs.getString("email_addr"));
			user.setRole(srs.getString("role_name"));
			user.setPhoneNumber(srs.getString("phone_number"));
			
			listUser.add(user);
			message="Query ok!";
		}

	} catch (SQLException e) {
		e.printStackTrace();
		message="Query wrong!";
	}
	System.out.println(message);
return listUser;
}
	public ArrayList<User> selectUsers(int page,int pagerows){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		String max="limit "+(page-1)*pagerows+","+pagerows;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM sys_user,sys_role WHERE sys_user.role_id=sys_role.role_id ORDER BY full_name ASC "+max+"");

			srs.beforeFirst();
			while (srs.next()) {
				user= new User();
				user.setUserID(Integer.parseInt(srs.getString("user_id")));
				user.setUserName(srs.getString("username"));
				user.setFullName(srs.getString("full_name"));
				user.setEmail(srs.getString("email_addr"));
				user.setRole(srs.getString("role_name"));
				user.setPhoneNumber(srs.getString("phone_number"));
				
				listUser.add(user);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	return listUser;
	}
	
	public String addUser(User user) {
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		try {
				PreparedStatement prep = conn
						.prepareStatement("INSERT INTO sys_user VALUES(null,'"+user.getUserName()+"','"+user.MD5(user.getPassword())+"','"+user.getFullName()+"','"+user.getEmail()+"','"+user.getRole()+"','"+user.getPhoneNumber()+"')");
				prep.executeUpdate();
				msg="User Added Successfully...";
		} catch (Exception e) {
			
			System.out.println(e);
			msg="User Not Added, please Correct Your Data.";

		}
		return msg;

	}
	public String deleteUser(User user) {
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		try {
				PreparedStatement prep = conn
						.prepareStatement("DELETE FROM  sys_user WHERE user_id='"+user.getUserID()+"'");
				prep.executeUpdate();

				msg="User Deleted Successfully...";	
				
		} catch (Exception e) {
			
			System.out.println(e);
			msg="User Not Deleted, please make sure of your privilegies.";
		}
		return msg;

	}
	public String updateUser(User user) {
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		try {
				if(!(user.getPassword().equalsIgnoreCase(""))){
				PreparedStatement prep = conn
						.prepareStatement("UPDATE sys_user SET  passwd =  '"+user.MD5(user.getPassword())+"',full_name =  '"+user.getFullName()+"',email_addr =  '"+user.getEmail()+"',role_id =  '"+user.getRole()+"',phone_number='"+user.getPhoneNumber()+"' WHERE  user_id ='"+user.getUserID()+"' or username='"+user.getUserName()+"'");
				prep.executeUpdate();
				msg="User Account Updated Successfully...";
				}
				else {
					PreparedStatement prep = conn
					.prepareStatement("UPDATE sys_user SET full_name =  '"+user.getFullName()+"',email_addr =  '"+user.getEmail()+"',role_id =  '"+user.getRole()+"',phone_number='"+user.getPhoneNumber()+"' WHERE  user_id ='"+user.getUserID()+"'");
			prep.executeUpdate();
			
			msg="User Account Updated Successfully...";
				}
		} catch (Exception e) {
			
			System.out.println(e);
			msg="User Not Updated, please Correct Your Data.";
		}
		
		return msg;
	}
	
	public ArrayList<User> userLogin(User user) {
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String msg="";
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM sys_user WHERE username='"+user.getUserName()+"' AND passwd='"+user.getPassword()+"'");
			srs.beforeFirst();
			while (srs.next()) {
				user = new User();
				user.setUserID(Integer.parseInt(srs.getString("user_id")));
				user.setUserName(srs.getString("username"));
				user.setPassword(srs.getString("passwd"));
				user.setFullName(srs.getString("full_name"));
				user.setEmail(srs.getString("email_addr"));
				user.setRole(srs.getString("role_id"));
				user.setPhoneNumber(srs.getString("phone_number"));
				listUser.add(user);
			}
			//msg="User Is In The System User Acounts";
			
		} catch (SQLException e) {
			e.printStackTrace();
			//msg="No Such User In The System User Acounts";
		}
		
	if(listUser.isEmpty()){System.out.println("User Isn't In The System User Acounts");
	}else{
		System.out.println("User Is In The System User Acounts");
	}

	return listUser;

		
	}


}
