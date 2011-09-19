package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.District;

public class DistrictManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<District> listDistrict=new ArrayList<District>();
	protected District district;
	
	public ArrayList<District> selectDistricts(){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM districts");
			
			srs.beforeFirst();
			while (srs.next()) {
				
				district=new District();
				district.setDistrictID(Integer.parseInt(srs.getString("ID")));
				district.setDistrictName(srs.getString("DISTRICT_N"));
				district.setProvince(srs.getString("PROV"));
				listDistrict.add(district);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return listDistrict;
	}

}
