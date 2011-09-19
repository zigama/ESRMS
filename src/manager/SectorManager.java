package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.District;
import domain.Sector;

public class SectorManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Sector> listSector=new ArrayList<Sector>();
	protected Sector sector;
	
	public ArrayList<Sector> selectSectors(int district){
		
		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
		String there="";
		
		try {
			conn = dbc.connectToDatabase();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			srs = stmt.executeQuery("SELECT * FROM sector,districts WHERE sector.DistID=districts.ID AND sector.DistID='"+district+"' ");
			
			srs.beforeFirst();
			while (srs.next()) {
				
				sector=new Sector();
				sector.setSectorID(Integer.parseInt(srs.getString("SectorCode")));
				sector.setSectorName(srs.getString("SectorName"));
				sector.setDistrictName(srs.getString("DISTRICT_N"));
				sector.setDistrictID(Integer.parseInt(srs.getString("DistID")));
				listSector.add(sector);
				there="sectors zirtsibura";
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			there="sectors wapi";
			
			// TODO: handle exception
		}
		
System.out.println(there);
		
		return listSector;
	}
}
