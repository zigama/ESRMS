package domain;

public class Discipline extends Enrollment{
	
	protected int disciplineID;
	protected String offenseType;
	protected String offenseOccurence;
	protected String offenseLocation;
	protected String disciplinaryAction;
	protected String session;
	public int getDisciplineID() {
		return disciplineID;
	}
	public void setDisciplineID(int disciplineID) {
		this.disciplineID = disciplineID;
	}
	public String getOffenseType() {
		return offenseType;
	}
	public void setOffenseType(String offenseType) {
		this.offenseType = offenseType;
	}
	public String getOffenseOccurence() {
		return offenseOccurence;
	}
	public void setOffenseOccurence(String offenseOccurence) {
		this.offenseOccurence = offenseOccurence;
	}
	public String getOffenseLocation() {
		return offenseLocation;
	}
	public void setOffenseLocation(String offenseLocation) {
		this.offenseLocation = offenseLocation;
	}
	public String getDisciplinaryAction() {
		return disciplinaryAction;
	}
	public void setDisciplinaryAction(String disciplinaryAction) {
		this.disciplinaryAction = disciplinaryAction;
	}
	public String getSession() {
		return session;
	}
	public void setSession(String session) {
		this.session = session;
	}
	
	

}
