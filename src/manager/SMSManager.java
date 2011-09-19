package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.SMS;
import domain.User;

public class SMSManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<SMS> listSMS=new ArrayList<SMS>();
	protected SMS sms;
	
public int countSMS(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		int rows=0;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM ozekimessageout");

			srs.beforeFirst();
			while (srs.next()) {
				rows++;
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return rows;
	}
	public String addSMS(SMS sms){
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		
		try {
			PreparedStatement prep = conn
					.prepareStatement("INSERT INTO ozekimessageout VALUES(null,'"+sms.getSmsSender()+"','"+sms.getSmsReceiver()+"','"+sms.getSmsMessage()+"',null,null,null,null,null,'"+sms.getSmsStatus()+"',null)");
			prep.executeUpdate();

			msg="A message has been sent...";	
			
	} catch (Exception e) {
		
		System.out.println(e);
		msg="Error occured, Message cannot be sent...";
	}
		
		return msg;
		
	}
	public ArrayList<SMS> selectSMSs(int page, int pagerows){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String max="limit "+(page-1)*pagerows+","+pagerows;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM ozekimessageout ORDER BY id DESC "+max+"");

			srs.beforeFirst();
			
			while (srs.next()) {
				
				sms = new SMS();
				
				sms.setSmsID(Integer.parseInt(srs.getString("id")));
				sms.setSmsSender(srs.getString("sender"));
				sms.setSmsReceiver(srs.getString("receiver"));
				sms.setSmsMessage(srs.getString("msg"));
				sms.setSmsSentTime(srs.getString("senttime"));
				sms.setSmsStatus(srs.getString("status"));
				sms.setSmsErrorMsg(srs.getString("errormsg"));
				
				listSMS.add(sms);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return listSMS;
		
	}
	public ArrayList<SMS> searchSMS(SMS sms){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM ozekimessageout WHERE id='"+sms.getSmsID()+"'");

			srs.beforeFirst();
			while (srs.next()) {
				sms= new SMS();
				sms.setSmsID(Integer.parseInt(srs.getString("id")));
				sms.setSmsSender(srs.getString("sender"));
				sms.setSmsReceiver(srs.getString("receiver"));
				sms.setSmsMessage(srs.getString("msg"));
				sms.setSmsSentTime(srs.getString("senttime"));
				sms.setSmsStatus(srs.getString("status"));
				sms.setSmsErrorMsg(srs.getString("errormsg"));
				
				listSMS.add(sms);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	return listSMS;
	}
	public String deleteSMS(SMS sms) {
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		try {
				PreparedStatement prep = conn
						.prepareStatement("DELETE FROM  ozekimessageout WHERE id='"+sms.getSmsID()+"'");
				prep.executeUpdate();

				msg="SMS Deleted Successfully...";	
				
		} catch (Exception e) {
			
			System.out.println(e);
			msg="SMS Not Deleted, please make sure of your privilegies.";
		}
		return msg;

	}
	public String updateSMS(SMS sms) {
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		try {
				
					PreparedStatement prep = conn
					.prepareStatement("UPDATE ozekimessageout SET receiver='"+sms.getSmsReceiver()+"',msg='"+sms.getSmsMessage()+"',status =  '"+sms.getSmsStatus()+"' WHERE  id ='"+sms.getSmsID()+"'");
			prep.executeUpdate();
						
			msg="SMS Updated Successfully...";
				
		} catch (Exception e) {
			
			System.out.println(e);
			msg="SMS Not Updated, please Correct Your Data.";
		}
		
		return msg;
	}

}
