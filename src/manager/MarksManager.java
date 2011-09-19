package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Enrollment;
import domain.Marks;

public class MarksManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Marks> marksList=new ArrayList<Marks>();
	Marks marks;
	
	public int countMarks(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		int rows=0;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM marks ");

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
	public ArrayList<Marks> selectMarksByEnrollment(Marks marks){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		try {

			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM marks, courses, sessions, enrollments, student, classes, departments " +
					"WHERE marks.EnrollmentID = enrollments.EnrollmentID " +
					"AND marks.CourseID = courses.CourseID " +
					"AND marks.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = classes.ClassCode " +
					"AND enrollments.RegNO='"+marks.getRegNO()+"'" +
					"AND marks.EnrollmentID='"+marks.getEnrollmentID()+"'" +
					"AND marks.SessionID='"+marks.getSession()+"' ORDER BY  marks.MarkID DESC ");
			srs.beforeFirst();
			while(srs.next()){
				
				marks=new Marks();
				marks.setMarkID(Integer.parseInt(srs.getString("MarkID")));
				marks.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				marks.setRegNO(srs.getString("RegNO"));
				marks.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				marks.setClassCode(srs.getString("ClassCode"));
				marks.setDepartment(srs.getString("DepartmentName"));
				marks.setCourse(srs.getString("CourseName"));
				marks.setSession(srs.getString("SessionName"));
				marks.setMarkQuiz(Float.parseFloat(srs.getString("MarkQuiz")));
				marks.setMarkExam(Float.parseFloat(srs.getString("MarkExam")));
				marks.setMaxScore(Float.parseFloat(srs.getString("MaxScore")));
				marks.setYearName(srs.getString("YearName"));
				
				marksList.add(marks);
				
			}
			
		} catch (Exception e) {
			
			
			// TODO: handle exception
		}
		if(marksList.isEmpty()){System.out.println("No marks");}

		
		return marksList;
		
	}
	public ArrayList<Marks> filterMarks(Marks marks,int page, int pagerows){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String max="limit "+(page-1)*pagerows+","+pagerows;
		
		try {

			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM marks, courses, sessions, enrollments, student, classes, departments " +
					"WHERE marks.EnrollmentID = enrollments.EnrollmentID " +
					"AND marks.CourseID = courses.CourseID " +
					"AND marks.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = classes.ClassCode " +
					"AND enrollments.RegNO='"+marks.getRegNO()+"' ORDER BY  marks.MarkID DESC "+max+" ");
			srs.beforeFirst();
			while(srs.next()){
				
				marks=new Marks();
				marks.setMarkID(Integer.parseInt(srs.getString("MarkID")));
				marks.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				marks.setRegNO(srs.getString("RegNO"));
				marks.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				marks.setClassCode(srs.getString("ClassCode"));
				marks.setDepartment(srs.getString("DepartmentName"));
				marks.setCourse(srs.getString("CourseName"));
				marks.setSession(srs.getString("SessionName"));
				marks.setMarkQuiz(Float.parseFloat(srs.getString("MarkQuiz")));
				marks.setMarkExam(Float.parseFloat(srs.getString("MarkExam")));
				marks.setMaxScore(Float.parseFloat(srs.getString("MaxScore")));
				marks.setYearName(srs.getString("YearName"));
				
				marksList.add(marks);
				
			}
			
		} catch (Exception e) {
			
			
			// TODO: handle exception
		}
		if(marksList.isEmpty()){System.out.println("No marks");}

		
		return marksList;
	}
	public String addMarks(Marks marks){
		
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		
		try {
			PreparedStatement prep = conn
			.prepareStatement("INSERT INTO marks VALUES(null,'"+marks.getEnrollmentID()+"','"+marks.getCourse()+"','"+marks.getSession()+"','"+marks.getMarkQuiz()+"','"+marks.getMarkExam()+"','"+marks.getMaxScore()+"')");
	prep.executeUpdate();
	msg="Student marks have been added successfully...";
			
			
			
		} catch (Exception e) {
			
			msg=" Marks not added, Please try again...";
			// TODO: handle exception
		}
		
		return msg;
	}

	public String updateMarks(Marks marks){
		
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		
		try {
			PreparedStatement prep = conn
			.prepareStatement("UPDATE marks SET CourseID='"+marks.getCourse()+"',SessionID='"+marks.getSession()+"',MarkQuiz='"+marks.getMarkQuiz()+"',MarkExam='"+marks.getMarkExam()+"',MaxScore='"+marks.getMaxScore()+"' WHERE MarkID='"+marks.getMarkID()+"' ");
			prep.executeUpdate();
			msg="Student marks have been updated successfully...";

			
		} catch (Exception e) {
			
			msg="Marks not updated, please try again...";
			// TODO: handle exception
		}
		
		return msg;
	}
	
	public String deleteMarks(Marks marks){
		
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		
		try {
			PreparedStatement prep = conn
			.prepareStatement("DELETE FROM marks WHERE MarkID='"+marks.getMarkID()+"' ");
			prep.executeUpdate();
			msg="Student marks have been deleted...";

			
		} catch (Exception e) {
			
			msg="Student marks not deleted...";
			// TODO: handle exception
		}
		
		return msg;
		
	}
	
	public ArrayList<Marks> selectMarks(int page, int pagerows){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String max="limit "+(page-1)*pagerows+","+pagerows;
		try {

			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM marks, courses, sessions, enrollments, student, classes, departments " +
					"WHERE marks.EnrollmentID = enrollments.EnrollmentID " +
					"AND marks.CourseID = courses.CourseID " +
					"AND marks.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = classes.ClassCode " +
					"ORDER BY  marks.MarkID DESC "+max+"");
			srs.beforeFirst();
			while(srs.next()){
				
				marks=new Marks();
				marks.setMarkID(Integer.parseInt(srs.getString("MarkID")));
				marks.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				marks.setRegNO(srs.getString("RegNO"));
				marks.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				marks.setClassCode(srs.getString("ClassCode"));
				marks.setDepartment(srs.getString("DepartmentName"));
				marks.setCourse(srs.getString("CourseName"));
				marks.setSession(srs.getString("SessionName"));
				marks.setMarkQuiz(Float.parseFloat(srs.getString("MarkQuiz")));
				marks.setMarkExam(Float.parseFloat(srs.getString("MarkExam")));
				marks.setMaxScore(Float.parseFloat(srs.getString("MaxScore")));
				marks.setYearName(srs.getString("YearName"));
				
				marksList.add(marks);
				
			}
			
		} catch (Exception e) {
			
			
			// TODO: handle exception
		}
		if(marksList.isEmpty()){System.out.println("No marks");}
		return marksList;
	}
	public ArrayList<Marks> checkMarks(Marks marks){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM marks,enrollments WHERE marks.EnrollmentID=enrollments.EnrollmentID AND marks.EnrollmentID='"+marks.getEnrollmentID()+"'AND marks.CourseID='"+marks.getCourse()+"' AND marks.SessionID='"+marks.getSession()+"'AND enrollments.YearName='"+marks.getYearName()+"' ");

			srs.beforeFirst();
			while(srs.next()){
				
				marks=new Marks();
				marks.setMarkID(Integer.parseInt(srs.getString("MarkID")));
				marks.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				marks.setRegNO(srs.getString("RegNO"));
				
				marks.setClassCode(srs.getString("ClassCode"));
				marks.setSession(srs.getString("SessionID"));
				marks.setCourse(srs.getString("CourseID"));
				marks.setMarkQuiz(Float.parseFloat(srs.getString("MarkQuiz")));
				marks.setMarkExam(Float.parseFloat(srs.getString("MarkExam")));
				marks.setMaxScore(Float.parseFloat(srs.getString("MaxScore")));
				marks.setYearName(srs.getString("YearName"));
				
				marksList.add(marks);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		if(marksList.isEmpty()){System.out.println("No such Marks");
			
		}else{
			System.out.println("Marks exist");
		}
		
		return marksList;	
	}

public ArrayList<Marks> searchMarks(Marks marks){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {

		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM marks, courses, sessions, enrollments, student, classes, departments " +
				"WHERE marks.EnrollmentID = enrollments.EnrollmentID " +
				"AND marks.CourseID = courses.CourseID " +
				"AND marks.SessionID = sessions.SessionID " +
				"AND enrollments.RegNO = student.RegNO " +
				"AND classes.DepartmentID = departments.DepartmentID " +
				"AND enrollments.ClassCode = classes.ClassCode " +
				"AND marks.MarkID='"+marks.getMarkID()+"' ");
		srs.beforeFirst();
		while(srs.next()){
			
			marks=new Marks();
			marks.setMarkID(Integer.parseInt(srs.getString("MarkID")));
			marks.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
			marks.setRegNO(srs.getString("RegNO"));
			marks.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
			marks.setClassCode(srs.getString("ClassCode"));
			marks.setDepartment(srs.getString("DepartmentName"));
			marks.setCourse(srs.getString("CourseID"));
			marks.setSession(srs.getString("SessionID"));
			marks.setMarkQuiz(Float.parseFloat(srs.getString("MarkQuiz")));
			marks.setMarkExam(Float.parseFloat(srs.getString("MarkExam")));
			marks.setMaxScore(Float.parseFloat(srs.getString("MaxScore")));
			marks.setYearName(srs.getString("YearName"));
			
			marksList.add(marks);
			
		}
		
	} catch (Exception e) {
		
		
		// TODO: handle exception
	}
	if(marksList.isEmpty()){System.out.println("No marks");}
	return marksList;
}
}
