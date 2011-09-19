package domain;

public class Attendance extends Enrollment{
	
	protected int attendanceID;
	protected String course;
	protected String session;
	protected int abscences;
	protected int execusedAbscences;
	protected int maxAttendance;
	public int getAttendanceID() {
		return attendanceID;
	}
	public void setAttendanceID(int attendanceID) {
		this.attendanceID = attendanceID;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getSession() {
		return session;
	}
	public void setSession(String session) {
		this.session = session;
	}
	public int getAbscences() {
		return abscences;
	}
	public void setAbscences(int abscences) {
		this.abscences = abscences;
	}
	public int getExecusedAbscences() {
		return execusedAbscences;
	}
	public void setExecusedAbscences(int execusedAbscences) {
		this.execusedAbscences = execusedAbscences;
	}
	public int getMaxAttendance() {
		return maxAttendance;
	}
	public void setMaxAttendance(int maxAttendance) {
		this.maxAttendance = maxAttendance;
	}
	
	
	
}
