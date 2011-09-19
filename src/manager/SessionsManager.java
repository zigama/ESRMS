package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Courses;
import domain.Sessions;

public class SessionsManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Sessions> sessionsList=new ArrayList<Sessions>();
	Sessions sessions;
	
public ArrayList<Sessions> selectSessions(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {

			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM sessions");
			
			srs.beforeFirst();
			while(srs.next()){
				
				sessions=new Sessions();
				sessions.setSessionID(Integer.parseInt(srs.getString("SessionID")));
				sessions.setSessionName(srs.getString("SessionName"));
				sessions.setSessionType(srs.getString("SessionType"));
				
				sessionsList.add(sessions);
			}

			
		} catch (Exception e) {
			
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return sessionsList;
	}


}
