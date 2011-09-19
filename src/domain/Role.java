package domain;

public class Role {
	
	protected int roleID;
	protected String roleName;
	protected int superUser;
	public int getRoleID() {
		return roleID;
	}
	public void setRoleID(int roleID) {
		this.roleID = roleID;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public int getSuperUser() {
		return superUser;
	}
	public void setSuperUser(int superUser) {
		this.superUser = superUser;
	}
	
	

}
