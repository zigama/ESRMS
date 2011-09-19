package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Attendance;
import domain.Discipline;

public class DisciplineManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Discipline> disciplineList=new ArrayList<Discipline>();
	Discipline discipline;
	
	public int countDiscpline(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		int rows=0;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM discipline ");

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
	
	public String addDiscipline(Discipline discipline){
		
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		
		try {
			PreparedStatement prep = conn
			.prepareStatement("INSERT INTO discipline VALUES(null,'"+discipline.getEnrollmentID()+"','"+discipline.getOffenseType()+"','"+discipline.getOffenseOccurence()+"','"+discipline.getOffenseLocation()+"','"+discipline.getDisciplinaryAction()+"','"+discipline.getSession()+"')");
	prep.executeUpdate();
	msg="Student discipline has been added successfully...";
			
		} catch (Exception e) {
			// TODO: handle exception
			msg="Student discipline not added, please try again...";
			e.printStackTrace();
		}
		
		return msg;
	}
	public String updateDiscipline(Discipline discipline){
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		try {
			
			PreparedStatement prep = conn
			.prepareStatement("UPDATE discipline SET OffenseType='"+discipline.getOffenseType()+"',SessionID='"+discipline.getSession()+"',OffenseOccurence='"+discipline.getOffenseOccurence()+"',OffenseLocation='"+discipline.getOffenseLocation()+"',DisciplinaryAction='"+discipline.getDisciplinaryAction()+"' WHERE DisciplineID='"+discipline.getDisciplineID()+"' ");
			prep.executeUpdate();
			msg="Student discipline have been updated successfully...";
			
			
		} catch (Exception e) {
			// TODO: handle exception
			msg="Discipline not updated, please try again...";
			e.printStackTrace();
		}
		
		return msg;
	}
	public String deleteDiscipline(Discipline discipline){
		
		dbc.loadDatabaseAccess();
		Connection conn = dbc.connectToDatabase();
		String msg="";
		
		try {
			PreparedStatement prep = conn
			.prepareStatement("DELETE FROM discipline WHERE DisciplineID='"+discipline.getDisciplineID()+"' ");
			prep.executeUpdate();
			msg="Student discipline has been deleted...";
			
		} catch (Exception e) {
			msg="Student discipline not deleted...";
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return msg;
		
	}
	public ArrayList<Discipline> selectDiscipline( int page, int pagerows){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String max="limit "+(page-1)*pagerows+","+pagerows;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM discipline, sessions, enrollments, student, classes, departments " +
					"WHERE discipline.EnrollmentID = enrollments.EnrollmentID " +
					"AND discipline.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = Classes.ClassCode " +
					"ORDER BY  discipline.DisciplineID DESC "+max+"");
			srs.beforeFirst();
			while(srs.next()){
				
				discipline=new Discipline();
				discipline.setDisciplineID(Integer.parseInt(srs.getString("DisciplineID")));
				discipline.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				discipline.setRegNO(srs.getString("RegNO"));
				discipline.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				discipline.setClassCode(srs.getString("ClassCode"));
				discipline.setDepartment(srs.getString("DepartmentName"));
				discipline.setOffenseType(srs.getString("OffenseType"));
				discipline.setOffenseOccurence(srs.getString("OffenseOccurence"));
				discipline.setOffenseLocation(srs.getString("OffenseLocation"));
				discipline.setDisciplinaryAction(srs.getString("DisciplinaryAction"));
				discipline.setSession(srs.getString("SessionName"));
				discipline.setYearName(srs.getString("YearName"));
				
				disciplineList.add(discipline);
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return disciplineList;
	}
	public ArrayList<Discipline> filterDiscipline(Discipline discipline,int page, int pagerows){
		
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String max="limit "+(page-1)*pagerows+","+pagerows;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM discipline, sessions, enrollments, student, classes, departments " +
					"WHERE discipline.EnrollmentID = enrollments.EnrollmentID " +
					"AND discipline.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = Classes.ClassCode " +
					"AND enrollments.RegNO='"+discipline.getRegNO()+"' ORDER BY  discipline.DisciplineID DESC "+max+"");
			srs.beforeFirst();
			while(srs.next()){
				
				discipline=new Discipline();
				discipline.setDisciplineID(Integer.parseInt(srs.getString("DisciplineID")));
				discipline.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				discipline.setRegNO(srs.getString("RegNO"));
				discipline.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				discipline.setClassCode(srs.getString("ClassCode"));
				discipline.setDepartment(srs.getString("DepartmentName"));
				discipline.setOffenseType(srs.getString("OffenseType"));
				discipline.setOffenseOccurence(srs.getString("OffenseOccurence"));
				discipline.setOffenseLocation(srs.getString("OffenseLocation"));
				discipline.setDisciplinaryAction(srs.getString("DisciplinaryAction"));
				discipline.setSession(srs.getString("SessionName"));
				discipline.setYearName(srs.getString("YearName"));
				
				disciplineList.add(discipline);
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return disciplineList;
	}
	public ArrayList<Discipline> selectDisciplineByEnrollment(Discipline discipline){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM discipline, sessions, enrollments, student, classes, departments " +
					"WHERE discipline.EnrollmentID = enrollments.EnrollmentID " +
					"AND discipline.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = classes.ClassCode " +
					"AND enrollments.RegNO='"+discipline.getRegNO()+"' " +
					"AND discipline.EnrollmentID='"+discipline.getEnrollmentID()+"'" +
					"AND discipline.SessionID='"+discipline.getSession()+"' ORDER BY  discipline.DisciplineID DESC ");
			srs.beforeFirst();
			while(srs.next()){
				
				discipline=new Discipline();
				discipline.setDisciplineID(Integer.parseInt(srs.getString("DisciplineID")));
				discipline.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				discipline.setRegNO(srs.getString("RegNO"));
				discipline.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				discipline.setClassCode(srs.getString("ClassCode"));
				discipline.setDepartment(srs.getString("DepartmentName"));
				discipline.setOffenseType(srs.getString("OffenseType"));
				discipline.setOffenseOccurence(srs.getString("OffenseOccurence"));
				discipline.setOffenseLocation(srs.getString("OffenseLocation"));
				discipline.setDisciplinaryAction(srs.getString("DisciplinaryAction"));
				discipline.setSession(srs.getString("SessionName"));
				discipline.setYearName(srs.getString("YearName"));
				
				disciplineList.add(discipline);
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return disciplineList;

		
	}
	public ArrayList<Discipline> searchDiscipline(Discipline discipline){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM discipline, sessions, enrollments, student, classes, departments " +
					"WHERE discipline.EnrollmentID = enrollments.EnrollmentID " +
					"AND discipline.SessionID = sessions.SessionID " +
					"AND enrollments.RegNO = student.RegNO " +
					"AND classes.DepartmentID = departments.DepartmentID " +
					"AND enrollments.ClassCode = Classes.ClassCode " +
					"AND discipline.DisciplineID='"+discipline.getDisciplineID()+"' ");
			srs.beforeFirst();
			while(srs.next()){
				
				discipline=new Discipline();
				discipline.setDisciplineID(Integer.parseInt(srs.getString("DisciplineID")));
				discipline.setEnrollmentID(Integer.parseInt(srs.getString("EnrollmentID")));
				discipline.setRegNO(srs.getString("RegNO"));
				discipline.setFullname(srs.getString("LastName")+" "+srs.getString("FirstName"));
				discipline.setClassCode(srs.getString("ClassCode"));
				discipline.setDepartment(srs.getString("DepartmentName"));
				discipline.setOffenseType(srs.getString("OffenseType"));
				discipline.setOffenseOccurence(srs.getString("OffenseOccurence"));
				discipline.setOffenseLocation(srs.getString("OffenseLocation"));
				discipline.setDisciplinaryAction(srs.getString("DisciplinaryAction"));
				discipline.setSession(srs.getString("SessionID"));
				discipline.setYearName(srs.getString("YearName"));
				
				disciplineList.add(discipline);
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		return disciplineList;
	}
}
