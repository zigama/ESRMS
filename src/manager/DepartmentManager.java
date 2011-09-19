package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Department;

public class DepartmentManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Department> departmentList=new ArrayList<Department>();
	Department department;
	
	public ArrayList<Department> selectDepartments(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM departments ");

			srs.beforeFirst();
			while(srs.next()){
				
				department=new Department();
				department.setDepartmentID(Integer.parseInt(srs.getString("DepartmentID")));
				department.setDepartmentName(srs.getString("DepartmentName"));
				department.setDepartmentShortName(srs.getString("DepartmentShortName"));
				
				departmentList.add(department);
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return departmentList;
	}

}
