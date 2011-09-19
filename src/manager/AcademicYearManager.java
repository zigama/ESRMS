package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.AcademicYear;

public class AcademicYearManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<AcademicYear> acadeYearList=new ArrayList<AcademicYear>();
	AcademicYear acadeYear;
	
public ArrayList<AcademicYear>	selectCurrentAcadYear(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM academicyears WHERE YearStatus='Current'");

		srs.beforeFirst();
		while(srs.next()){
			
			acadeYear=new AcademicYear();
			acadeYear.setYearID(Integer.parseInt(srs.getString("YearID")));
			acadeYear.setYearName(srs.getString("YearName"));
			acadeYear.setYearStatus(srs.getString("YearStatus"));
			acadeYearList.add(acadeYear);
			
			
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return acadeYearList;
}
public ArrayList<AcademicYear>	selectAcadYears(){
	
	dbc.loadDatabaseAccess();
	Connection conn = null;
	Statement stmt;
	ResultSet srs;
	
	try {
		
		conn = dbc.connectToDatabase();

		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);
		srs = stmt.executeQuery("SELECT * FROM academicyears");

		srs.beforeFirst();
		while(srs.next()){
			
			acadeYear=new AcademicYear();
			acadeYear.setYearID(Integer.parseInt(srs.getString("YearID")));
			acadeYear.setYearName(srs.getString("YearName"));
			acadeYear.setYearStatus(srs.getString("YearStatus"));
			acadeYearList.add(acadeYear);
			
			
			
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return acadeYearList;
}

}
