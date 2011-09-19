package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Enrollment;

public class EnrollmentManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Enrollment> enrollmentList=new ArrayList<Enrollment>();
	Enrollment enrollment;

public int countEnrollments(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	int rows=0;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM enrollments ");

		srs.beforeFirst();
		while (srs.next()) {
			rows++;
		}
		
	} catch (Exception e) {
		
		// TODO: handle exception
	}
	
	return rows;
}	
	
public String addEnrollment(Enrollment enroll){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		PreparedStatement prep = conn
		.prepareStatement("INSERT INTO enrollments VALUES(null,'"+enroll.getRegNO()+"','"+enroll.getClassCode()+"','"+enroll.getYearName()+"')");
prep.executeUpdate();
msg="Student "+enroll.getRegNO()+" have been enrolled in "+enroll.getClassCode()+" successfully for "+enroll.getYearName()+" academic year...";
		
		
	} catch (Exception e) {
		
	msg="Student "+enroll.getRegNO()+" haven't been enrolled";
		// TODO: handle exception
	}
	
	return msg;
}

public ArrayList<Enrollment> selectEnrollments(int page,int pagerows){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	String max="limit "+(page-1)*pagerows+","+pagerows;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM enrollments ORDER BY EnrollmentID DESC "+max+" ");

		srs.beforeFirst();
		while(srs.next()){
			
			enrollment=new Enrollment();
			enrollment.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			enrollment.setRegNO(srs.getString("RegNO"));
			enrollment.setClassCode(srs.getString("ClassCode"));
			enrollment.setYearName(srs.getString("YearName"));
			enrollmentList.add(enrollment);
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return enrollmentList;
}

public ArrayList<Enrollment> checkEnrollment(Enrollment enrollment){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM enrollments WHERE RegNO='"+enrollment.getRegNO()+"' AND YearName='"+enrollment.getYearName()+"' ");

		srs.beforeFirst();
		while(srs.next()){
			
			enrollment=new Enrollment();
			enrollment.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			enrollment.setRegNO(srs.getString("RegNO"));
			enrollment.setClassCode(srs.getString("ClassCode"));
			enrollment.setYearName(srs.getString("YearName"));
			enrollmentList.add(enrollment);
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	if(enrollmentList.isEmpty()){System.out.println("No such enrollment");
		
	}else{
		System.out.println("enrollment exist");
	}
	
	return enrollmentList;	
}
public ArrayList<Enrollment> searchEnrollment(Enrollment enrollment){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM enrollments WHERE RegNO='"+enrollment.getRegNO()+"' OR EnrollmentID='"+enrollment.getEnrollmentID()+"' ORDER BY EnrollmentID DESC");

		srs.beforeFirst();
		while(srs.next()){
			
			enrollment=new Enrollment();
			enrollment.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			enrollment.setRegNO(srs.getString("RegNO"));
			enrollment.setClassCode(srs.getString("ClassCode"));
			enrollment.setYearName(srs.getString("YearName"));
			enrollmentList.add(enrollment);
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	if(enrollmentList.isEmpty()){System.out.println("No such enrollment");
		
	}else{
		System.out.println("enrollment exist");
	}
	
	return enrollmentList;	
}

public ArrayList<Enrollment> searchEnrollmentByYear(Enrollment enrollment){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM enrollments,student,classes,departments WHERE enrollments.RegNO=student.RegNO AND enrollments.ClassCode=classes.ClassCode AND classes.DepartmentID=departments.DepartmentID AND enrollments.RegNO='"+enrollment.getRegNO()+"' AND enrollments.YearName='"+enrollment.getYearName()+"' ");

		srs.beforeFirst();
		while(srs.next()){
			
			enrollment=new Enrollment();
			enrollment.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			enrollment.setRegNO(srs.getString("RegNO"));
			enrollment.setClassCode(srs.getString("ClassCode"));
			enrollment.setYearName(srs.getString("YearName"));
			enrollment.setDepartment(srs.getString("DepartmentName"));
			enrollment.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			
			enrollmentList.add(enrollment);
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	if(enrollmentList.isEmpty()){System.out.println("No such enrollment");
		
	}else{
		System.out.println("enrollment exist");
	}
	

	
	return enrollmentList;
}

public String updateEnrollment(Enrollment enrollment){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		
		PreparedStatement prep = conn
		.prepareStatement("UPDATE enrollments SET ClassCode='"+enrollment.getClassCode()+"' WHERE EnrollmentID='"+enrollment.getEnrollmentID()+"' ");
		prep.executeUpdate();
		msg="Student "+enrollment.getRegNO()+" have been enrolled in "+enrollment.getClassCode()+" successfully for "+enrollment.getYearName()+" academic year...";

		
	} catch (Exception e) {
		
		msg="Student "+enrollment.getRegNO()+" Enrollment not updated...";
		// TODO: handle exception
	}
	
	return msg;
}
public String deleteEnrollment(Enrollment enrollment){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		
		PreparedStatement prep = conn
		.prepareStatement("DELETE FROM enrollments WHERE EnrollmentID='"+enrollment.getEnrollmentID()+"' ");
		prep.executeUpdate();
		msg="Student enrollment has been deleted...";

		
	} catch (Exception e) {
		
		msg="Student Enrollment not deleted...";
		// TODO: handle exception
	}
	
	return msg;
}
public ArrayList<Enrollment> selectClassList(Enrollment enrollment){
	
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM enrollments,student,classes,departments " +
				"WHERE enrollments.RegNO=student.RegNO " +
				"AND enrollments.ClassCode=classes.ClassCode " +
				"AND classes.DepartmentID=departments.DepartmentID " +
				"AND enrollments.ClassCode='"+enrollment.getClassCode()+"' " +
						"AND enrollments.YearName='"+enrollment.getYearName()+"'ORDER BY LastName ASC ");

		srs.beforeFirst();
		while(srs.next()){
			
			enrollment=new Enrollment();
			enrollment.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			enrollment.setRegNO(srs.getString("RegNO"));
			enrollment.setClassCode(srs.getString("ClassCode"));
			enrollment.setYearName(srs.getString("YearName"));
			enrollment.setDepartment(srs.getString("DepartmentName"));
			enrollment.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			
			enrollmentList.add(enrollment);
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	if(enrollmentList.isEmpty()){System.out.println("No student for this class"+enrollment.getClassCode()+enrollment.getYearName());
		
	}else{
		System.out.println("students  exist");
	}
	


	
	return enrollmentList;	
}

}
