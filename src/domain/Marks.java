package domain;

public class Marks extends Enrollment {
	
	protected int markID;
	protected String course;
	protected String session;
	protected float markQuiz;
	protected float markExam;
	protected float maxScore;
	public int getMarkID() {
		return markID;
	}
	public void setMarkID(int markID) {
		this.markID = markID;
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
	public float getMarkQuiz() {
		return markQuiz;
	}
	public void setMarkQuiz(float markQuiz) {
		this.markQuiz = markQuiz;
	}
	public float getMarkExam() {
		return markExam;
	}
	public void setMarkExam(float markExam) {
		this.markExam = markExam;
	}
	public float getMaxScore() {
		return maxScore;
	}
	public void setMaxScore(float maxScore) {
		this.maxScore = maxScore;
	}
	
	

}
