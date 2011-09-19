package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Courses;

public class CourseManager {
	

	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Courses> courseList=new ArrayList<Courses>();
	Courses course;

	public ArrayList<Courses> selectCourses(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {

			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM courses");
			
			srs.beforeFirst();
			while(srs.next()){
				
				course=new Courses();
				course.setCourseID(Integer.parseInt(srs.getString("CourseID")));
				course.setCourseName(srs.getString("CourseName"));
				
				courseList.add(course);
			}

			
		} catch (Exception e) {
			
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return courseList;
	}

}
