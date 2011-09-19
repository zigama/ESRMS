package dbaccess;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class JDBCFun {
	
	
	public void loadDatabaseAccess(){
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(ClassNotFoundException e){
			
		}
	}
	
	public  Connection connectToDatabase() {
		String conUrl = "jdbc:mysql://localhost:3306/esrms";
		Connection connection = null;
		try {
			connection = (Connection) DriverManager.getConnection(conUrl, "root", "");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
	

}
