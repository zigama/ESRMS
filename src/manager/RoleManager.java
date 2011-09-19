package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dbaccess.JDBCFun;
import domain.Role;



public class RoleManager {
	
	protected JDBCFun dbc = new JDBCFun();
	protected ArrayList<Role> listRole = new ArrayList<Role>();
	protected Role role;
	
	public ArrayList<Role> selectRoles() {

		dbc.loadDatabaseAccess();
		Connection conn = null;
		Statement stmt;
		ResultSet srs;
		
			try {
				conn = dbc.connectToDatabase();

				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
				srs = stmt.executeQuery("SELECT * FROM sys_role");

				srs.beforeFirst();
				while (srs.next()) {
					
					role = new Role();
					
					role.setRoleID(Integer.parseInt(srs.getString("role_id")));
					role.setRoleName(srs.getString("role_name"));
					role.setSuperUser(Integer.parseInt(srs.getString("super_user")));
					
					listRole.add(role);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		
		return listRole;
	}

}
