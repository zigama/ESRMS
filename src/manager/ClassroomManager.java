package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Classroom;

public class ClassroomManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Classroom> classroomList=new ArrayList<Classroom>();
	Classroom classroom;
	
public ArrayList<Classroom> selectClasses(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM classes,departments WHERE classes.DepartmentID=departments.DepartmentID");

		srs.beforeFirst();
		while(srs.next()){
			
			classroom=new Classroom();
			classroom.setClassID(Integer.parseInt(srs.getString("ClassID")));
			classroom.setClassCode(srs.getString("ClassCode"));
			classroom.setDepartmentID(Integer.parseInt(srs.getString("DepartmentID")));
			classroom.setDepartmentName(srs.getString("DepartmentName"));
			classroom.setDepartmentShortName(srs.getString("DepartmentShortName"));
			
			classroomList.add(classroom);
			
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return classroomList;
}
public ArrayList<Classroom> selectClass(String clas){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM classes,departments WHERE classes.DepartmentID=departments.DepartmentID AND classes.ClassCode='"+clas+"'");

		srs.beforeFirst();
		while(srs.next()){
			
			classroom=new Classroom();
			classroom.setClassID(Integer.parseInt(srs.getString("ClassID")));
			classroom.setClassCode(srs.getString("ClassCode"));
			classroom.setDepartmentID(Integer.parseInt(srs.getString("DepartmentID")));
			classroom.setDepartmentName(srs.getString("DepartmentName"));
			classroom.setDepartmentShortName(srs.getString("DepartmentShortName"));
			
			classroomList.add(classroom);
			
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return classroomList;
	
}

}
