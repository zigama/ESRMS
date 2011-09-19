package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Attendance;
import domain.Marks;

public class AttendanceManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Attendance> attendanceList=new ArrayList<Attendance>();
	Attendance attendance;
	
public int countAttendance(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	int rows=0;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM attendances ");

		srs.beforeFirst();
		while (srs.next()) {
			rows++;
		}
		

		
	} catch (Exception e) {
		
		e.printStackTrace();
		// TODO: handle exception
	}
	
	return rows;
}
public String addAttendance(Attendance attendance){
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	try {
		if(attendance.getExecusedAbscences()==0){
		PreparedStatement prep = conn
		.prepareStatement("INSERT INTO attendances VALUES(null,'"+attendance.getEnrollmentID()+"','"+attendance.getCourse()+"','"+attendance.getSession()+"','"+attendance.getAbscences()+"','0','"+attendance.getMaxAttendance()+"')");
prep.executeUpdate();
msg="Student attendance has been added successfully...";
		}else{
			PreparedStatement prep = conn
			.prepareStatement("INSERT INTO attendances VALUES(null,'"+attendance.getEnrollmentID()+"','"+attendance.getCourse()+"','"+attendance.getSession()+"','0','"+attendance.getExecusedAbscences()+"','"+attendance.getMaxAttendance()+"')");
	prep.executeUpdate();
	msg="Student attendance has been added successfully...";
		}	
		
	} catch (Exception e) {
		// TODO: handle exception
		msg=" Attendance not added, Please try again...";
		e.printStackTrace();
	}
	
	return msg;
}
public ArrayList<Attendance> selectAttendances(int page, int pagerows){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	String max="limit "+(page-1)*pagerows+","+pagerows;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM attendances, courses, sessions, enrollments, student, classes, departments " +
				"WHERE attendances.EnrollmentID = enrollments.EnrollmentID " +
				"AND attendances.CourseID = courses.CourseID " +
				"AND attendances.SessionID = sessions.SessionID " +
				"AND enrollments.RegNO = student.RegNO " +
				"AND classes.DepartmentID = departments.DepartmentID " +
				"AND enrollments.ClassCode = Classes.ClassCode " +
				"ORDER BY  attendances.AttendanceID DESC "+max+"");
		srs.beforeFirst();
while(srs.next()){
			
			attendance=new Attendance();
			attendance.setAttendanceID(Integer.parseInt(srs.getString("AttendanceID")));
			attendance.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			attendance.setRegNO(srs.getString("RegNO"));
			attendance.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			attendance.setClassCode(srs.getString("ClassCode"));
			attendance.setDepartment(srs.getString("DepartmentName"));
			attendance.setCourse(srs.getString("CourseName"));
			attendance.setSession(srs.getString("SessionName"));
			attendance.setAbscences(Integer.parseInt(srs.getString("Abscences")));
			attendance.setExecusedAbscences(Integer.parseInt(srs.getString("ExecusedAbscences")));
			attendance.setMaxAttendance(Integer.parseInt(srs.getString("MaxAttendance")));
			attendance.setYearName(srs.getString("YearName"));
			
			attendanceList.add(attendance);
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return attendanceList;
}
public ArrayList<Attendance> searchAttendances( Attendance attendance){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM attendances, courses, sessions, enrollments, student, classes, departments " +
				"WHERE attendances.EnrollmentID = enrollments.EnrollmentID " +
				"AND attendances.CourseID = courses.CourseID " +
				"AND attendances.SessionID = sessions.SessionID " +
				"AND enrollments.RegNO = student.RegNO " +
				"AND classes.DepartmentID = departments.DepartmentID " +
				"AND enrollments.ClassCode = Classes.ClassCode " +
				"AND attendances.AttendanceID='"+attendance.getAttendanceID()+"' ");
		srs.beforeFirst();
		while(srs.next()){
			
			attendance=new Attendance();
			attendance.setAttendanceID(Integer.parseInt(srs.getString("AttendanceID")));
			attendance.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			attendance.setRegNO(srs.getString("RegNO"));
			attendance.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			attendance.setClassCode(srs.getString("ClassCode"));
			attendance.setDepartment(srs.getString("DepartmentName"));
			attendance.setCourse(srs.getString("CourseID"));
			attendance.setSession(srs.getString("SessionID"));
			attendance.setAbscences(Integer.parseInt(srs.getString("Abscences")));
			attendance.setExecusedAbscences(Integer.parseInt(srs.getString("ExecusedAbscences")));
			attendance.setMaxAttendance(Integer.parseInt(srs.getString("MaxAttendance")));
			attendance.setYearName(srs.getString("YearName"));
			
			attendanceList.add(attendance);
			
		}
		
		
	} catch (Exception e) {
		e.printStackTrace();
		// TODO: handle exception
	}
	if(attendanceList.isEmpty()){System.out.println("No Attendance");}
	return attendanceList;
}
public ArrayList<Attendance> filterAttendances(Attendance attendance,int page, int pagerows){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	String max="limit "+(page-1)*pagerows+","+pagerows;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM attendances, courses, sessions, enrollments, student, classes, departments " +
				"WHERE attendances.EnrollmentID = enrollments.EnrollmentID " +
				"AND attendances.CourseID = courses.CourseID " +
				"AND attendances.SessionID = sessions.SessionID " +
				"AND enrollments.RegNO = student.RegNO " +
				"AND classes.DepartmentID = departments.DepartmentID " +
				"AND enrollments.ClassCode = Classes.ClassCode " +
				"AND enrollments.RegNO='"+attendance.getRegNO()+"'ORDER BY  attendances.AttendanceID DESC "+max+"");
		srs.beforeFirst();
while(srs.next()){
			
			attendance=new Attendance();
			attendance.setAttendanceID(Integer.parseInt(srs.getString("AttendanceID")));
			attendance.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			attendance.setRegNO(srs.getString("RegNO"));
			attendance.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			attendance.setClassCode(srs.getString("ClassCode"));
			attendance.setDepartment(srs.getString("DepartmentName"));
			attendance.setCourse(srs.getString("CourseName"));
			attendance.setSession(srs.getString("SessionName"));
			attendance.setAbscences(Integer.parseInt(srs.getString("Abscences")));
			attendance.setExecusedAbscences(Integer.parseInt(srs.getString("ExecusedAbscences")));
			attendance.setMaxAttendance(Integer.parseInt(srs.getString("MaxAttendance")));
			attendance.setYearName(srs.getString("YearName"));
			
			attendanceList.add(attendance);
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return attendanceList;

}
public ArrayList<Attendance> selectAttendanceByEnrollment(Attendance attendance){
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM attendances, courses, sessions, enrollments, student, classes, departments " +
				"WHERE attendances.EnrollmentID = enrollments.EnrollmentID " +
				"AND attendances.CourseID = courses.CourseID " +
				"AND attendances.SessionID = sessions.SessionID " +
				"AND enrollments.RegNO = student.RegNO " +
				"AND classes.DepartmentID = departments.DepartmentID " +
				"AND enrollments.ClassCode = classes.ClassCode " +
				"AND enrollments.RegNO='"+attendance.getRegNO()+"'" +
				"AND attendances.EnrollmentID='"+attendance.getEnrollmentID()+"'" +
				"AND attendances.SessionID='"+attendance.getSession()+"'ORDER BY  attendances.AttendanceID DESC");
		srs.beforeFirst();
while(srs.next()){
			
			attendance=new Attendance();
			attendance.setAttendanceID(Integer.parseInt(srs.getString("AttendanceID")));
			attendance.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			attendance.setRegNO(srs.getString("RegNO"));
			attendance.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			attendance.setClassCode(srs.getString("ClassCode"));
			attendance.setDepartment(srs.getString("DepartmentName"));
			attendance.setCourse(srs.getString("CourseName"));
			attendance.setSession(srs.getString("SessionName"));
			attendance.setAbscences(Integer.parseInt(srs.getString("Abscences")));
			attendance.setExecusedAbscences(Integer.parseInt(srs.getString("ExecusedAbscences")));
			attendance.setMaxAttendance(Integer.parseInt(srs.getString("MaxAttendance")));
			attendance.setYearName(srs.getString("YearName"));
			
			attendanceList.add(attendance);
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return attendanceList;
	
}
public ArrayList<Attendance> checkAttendance(Attendance attendance){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM attendances,enrollments WHERE attendances.EnrollmentID=enrollments.EnrollmentID AND attendances.EnrollmentID='"+attendance.getEnrollmentID()+"'AND attendances.CourseID='"+attendance.getCourse()+"' AND attendances.SessionID='"+attendance.getSession()+"'AND enrollments.YearName='"+attendance.getYearName()+"' ");

		srs.beforeFirst();
		while(srs.next()){
			
			attendance=new Attendance();
			attendance.setAttendanceID(Integer.parseInt(srs.getString("AttendanceID")));
			attendance.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			attendance.setRegNO(srs.getString("RegNO"));
			attendance.setClassCode(srs.getString("ClassCode"));
			
			attendance.setCourse(srs.getString("CourseID"));
			attendance.setSession(srs.getString("SessionID"));
			attendance.setAbscences(Integer.parseInt(srs.getString("Abscences")));
			attendance.setExecusedAbscences(Integer.parseInt(srs.getString("ExecusedAbscences")));
			attendance.setMaxAttendance(Integer.parseInt(srs.getString("MaxAttendance")));
			attendance.setYearName(srs.getString("YearName"));
			
			attendanceList.add(attendance);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
		// TODO: handle exception
	}
	if(attendanceList.isEmpty()){System.out.println("No such Attendance");
		
	}else{
		System.out.println("Attendance exist");
	}
	
	
	return attendanceList;
}
public String updateAttendance(Attendance attendance){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	try {
		
		PreparedStatement prep = conn
		.prepareStatement("UPDATE attendances SET CourseID='"+attendance.getCourse()+"',SessionID='"+attendance.getSession()+"',Abscences='"+attendance.getAbscences()+"',ExecusedAbscences='"+attendance.getExecusedAbscences()+"',MaxAttendance='"+attendance.getMaxAttendance()+"' WHERE AttendanceID='"+attendance.getAttendanceID()+"' ");
		prep.executeUpdate();
		msg="Student attendance have been updated successfully...";
		
		
	} catch (Exception e) {
		// TODO: handle exception
		msg="Attendance not updated, please try again...";
		e.printStackTrace();
	}
	
	return msg;
}
public String deleteAttendance(Attendance attendance){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		PreparedStatement prep = conn
		.prepareStatement("DELETE FROM attendances WHERE AttendanceID='"+attendance.getAttendanceID()+"' ");
		prep.executeUpdate();
		msg="Student attendance have been deleted...";
		
	} catch (Exception e) {
		msg="Student attendance not deleted...";
		e.printStackTrace();
		// TODO: handle exception
	}
	
	return msg;
	
}
}
