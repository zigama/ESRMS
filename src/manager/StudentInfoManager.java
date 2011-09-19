package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import dbaccess.JDBCFun;
import domain.Student;
import domain.User;

public class StudentInfoManager {

	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Student> listStudentInfo=new ArrayList<Student>();
	protected Student studentInfo;
	
	public String selectNewRegNO(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		String regNO="";
		Calendar cal=Calendar.getInstance();
	    int year=cal.get(Calendar.YEAR);
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT MAX(`StudID`) FROM `student`");
			
			srs.beforeFirst();
			while(srs.next()){
			if (srs.getObject(1)==null) {
				
				
					int regno=0;
					regno++;
					regNO=regNO+regno+"/"+year;
				}else{
					
					int seleregno=Integer.parseInt(srs.getObject(1).toString());
					seleregno++;
					regNO=regNO+seleregno+"/"+year;
				}
				
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(regNO);
		return regNO;
	}
public int countStudents(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	int rows=0;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM student ");

		srs.beforeFirst();
		while (srs.next()) {
			rows++;
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return rows;
	
}
	
public ArrayList<Student> autoSearch(String key){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	String message="";
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM student,sector,districts WHERE student.Sector=sector.SectorCode AND sector.DistID=districts.ID AND student.RegNO LIKE '%"+key+"%' ");

		srs.beforeFirst();
		while(srs.next()){
			studentInfo=new Student();
		studentInfo.setStudentFirstName(srs.getString("FirstName"));
		studentInfo.setStudentLastName(srs.getString("LastName"));
		studentInfo.setStudentRegNO(srs.getString("RegNo"));
		studentInfo.setFatherName(srs.getString("FatherName"));
		studentInfo.setMotherName(srs.getString("MotherName"));
		studentInfo.setStudentSex(srs.getString("Sex"));
		studentInfo.setStudentBirthdate(srs.getString("Birthdate"));
		studentInfo.setStudentCitizenship(srs.getString("Citizenship"));
		studentInfo.setStudentDistrict(srs.getString("DISTRICT_N"));
		studentInfo.setStudentSector(srs.getString("SectorName"));
		studentInfo.setStudentCellule(srs.getString("Cellule"));
		studentInfo.setStudentVillage(srs.getString("Village"));
		studentInfo.setGuardianName(srs.getString("GuardianName"));
		studentInfo.setStudentGuardianID(srs.getString("GuardianNatID"));
		studentInfo.setGuardianPhoneNO(srs.getString("GuardianPhoneNO"));
		studentInfo.setGuardianRelationship(srs.getString("GuardianRelationship"));
		studentInfo.setStudentUserName(srs.getString("username"));
		
		listStudentInfo.add(studentInfo);
		message="student query ok!";
		}
	} catch (Exception e) {
		// TODO: handle exception
		message="student query wrong";
	}
	
	System.out.println(message);
	return listStudentInfo;
	
}
public String addStudentInfos(Student student){
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		
		PreparedStatement prep = conn
		.prepareStatement("INSERT INTO student VALUES(null,'"+student.getStudentFirstName()+"','"+student.getStudentLastName()+"','"+student.getStudentRegNO()+"','"+student.getFatherName()+"','"+student.getMotherName()+"','"+student.getStudentSex()+"','"+student.getStudentBirthdate()+"','"+student.getStudentCitizenship()+"','"+student.getStudentDistrict()+"','"+student.getStudentSector()+"','"+student.getStudentCellule()+"','"+student.getStudentVillage()+"','"+student.getStudentGuardianID()+"','"+student.getGuardianName()+"','"+student.getGuardianRelationship()+"','"+student.getGuardianPhoneNO()+"','"+student.getStudentUserName()+"')");
prep.executeUpdate();
msg="Student "+student.getStudentRegNO()+" Infos have been added successfully...";
		
	} catch (Exception e) {
		// TODO: handle exception
		msg="Student Infos haven't been added successfully...";
		System.out.println(e);
	}
	
	
	return msg;
}
public String updateStudentInfos(Student student){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		
		PreparedStatement prep = conn
		.prepareStatement("UPDATE student SET  FirstName =  '"+student.getStudentFirstName()+"',LastName =  '"+student.getStudentLastName()+"',FatherName =  '"+student.getFatherName()+"',MotherName =  '"+student.getMotherName()+"',Sex='"+student.getStudentSex()+"',Birthdate='"+student.getStudentBirthdate()+"',Citizenship='"+student.getStudentCitizenship()+"',District='"+student.getStudentDistrict()+"',Sector='"+student.getStudentSector()+"',Cellule='"+student.getStudentCellule()+"',Village='"+student.getStudentVillage()+"',GuardianNatID='"+student.getStudentGuardianID()+"', GuardianRelationship='"+student.getGuardianRelationship()+"',GuardianName='"+student.getGuardianName()+"',GuardianPhoneNO='"+student.getGuardianPhoneNO()+"' WHERE  RegNO='"+student.getStudentRegNO()+"'");
prep.executeUpdate();

msg="Student "+student.getStudentRegNO()+" Infos updated successfully";
		
	} catch (Exception e) {
		
		
		msg="Student infos haven't been updated...";
		// TODO: handle exception
	}
	
	return msg;
	
}
public String deleteStudentInfos(Student student){
	
	dbc.loadDatabaseAccess();
	Connection conn = dbc.connectToDatabase();
	String msg="";
	
	try {
		
		PreparedStatement prep = conn
		.prepareStatement("DELETE FROM  student WHERE RegNO='"+student.getStudentRegNO()+"'");
prep.executeUpdate();

msg="Student "+student.getStudentRegNO()+" infos deleted successfully...";
		
	} catch (Exception e) {
		
		msg="Student "+student.getStudentRegNO()+" infos not deleted, try again ...";
		// TODO: handle exception
	}
	
	return msg;
}

public ArrayList<Student> searchStudentInfos(Student student){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM student WHERE RegNO='"+student.getStudentRegNO()+"' OR username='"+student.getStudentUserName()+"'");

		srs.beforeFirst();
		while (srs.next()) {
			studentInfo=new Student();
			studentInfo.setStudentFirstName(srs.getString("FirstName"));
			studentInfo.setStudentLastName(srs.getString("LastName"));
			studentInfo.setStudentRegNO(srs.getString("RegNo"));
			studentInfo.setFatherName(srs.getString("FatherName"));
			studentInfo.setMotherName(srs.getString("MotherName"));
			studentInfo.setStudentSex(srs.getString("Sex"));
			studentInfo.setStudentBirthdate(srs.getString("Birthdate"));
			studentInfo.setStudentCitizenship(srs.getString("Citizenship"));
			studentInfo.setStudentDistrict(srs.getString("District"));
			studentInfo.setStudentSector(srs.getString("Sector"));
			studentInfo.setStudentCellule(srs.getString("Cellule"));
			studentInfo.setStudentVillage(srs.getString("Village"));
			studentInfo.setGuardianName(srs.getString("GuardianName"));
			studentInfo.setStudentGuardianID(srs.getString("GuardianNatID"));
			studentInfo.setGuardianPhoneNO(srs.getString("GuardianPhoneNO"));
			studentInfo.setGuardianRelationship(srs.getString("GuardianRelationship"));
			studentInfo.setStudentUserName(srs.getString("username"));
			
			listStudentInfo.add(studentInfo);
			
		}
		
		
	} catch (Exception e) {
		// TODO: handle exception
		System.out.println(e);
	}
	
	
	return listStudentInfo;
}

public ArrayList<Student> selectStudents(int page,int pagerows){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	String max="limit "+(page-1)*pagerows+","+pagerows;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM student,sector,districts WHERE student.Sector=sector.SectorCode AND sector.DistID=districts.ID ORDER BY RegNO ASC "+max+" ");

		srs.beforeFirst();
		while(srs.next()){
			studentInfo=new Student();
		studentInfo.setStudentFirstName(srs.getString("FirstName"));
		studentInfo.setStudentLastName(srs.getString("LastName"));
		studentInfo.setStudentRegNO(srs.getString("RegNo"));
		studentInfo.setFatherName(srs.getString("FatherName"));
		studentInfo.setMotherName(srs.getString("MotherName"));
		studentInfo.setStudentSex(srs.getString("Sex"));
		studentInfo.setStudentBirthdate(srs.getString("Birthdate"));
		studentInfo.setStudentCitizenship(srs.getString("Citizenship"));
		studentInfo.setStudentDistrict(srs.getString("DISTRICT_N"));
		studentInfo.setStudentSector(srs.getString("SectorName"));
		studentInfo.setStudentCellule(srs.getString("Cellule"));
		studentInfo.setStudentVillage(srs.getString("Village"));
		studentInfo.setGuardianName(srs.getString("GuardianName"));
		studentInfo.setStudentGuardianID(srs.getString("GuardianNatID"));
		studentInfo.setGuardianPhoneNO(srs.getString("GuardianPhoneNO"));
		studentInfo.setGuardianRelationship(srs.getString("GuardianRelationship"));
		studentInfo.setStudentUserName(srs.getString("username"));
		
		listStudentInfo.add(studentInfo);
		}
	} catch (Exception e) {
		// TODO: handle exception
		System.out.println(e);
	}
	
	return listStudentInfo;
}
	
}
