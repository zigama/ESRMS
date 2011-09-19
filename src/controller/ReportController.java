package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.ImageView;

import manager.AcademicYearManager;
import manager.AttendanceManager;
import manager.DisciplineManager;
import manager.EnrollmentManager;
import manager.MarksManager;
import manager.SessionsManager;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.lowagie.text.Table;

import domain.AcademicYear;
import domain.Attendance;
import domain.Discipline;
import domain.Enrollment;
import domain.Marks;
import domain.Sessions;




/**
 * Servlet implementation class ReportController
 */
public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectAcadYears();
		request.setAttribute("years", myAcadeYear);
		Enrollment enrollment=new Enrollment();
		EnrollmentManager enrollmentMan=new EnrollmentManager();
		ArrayList<Enrollment> myEnrollment=new ArrayList<Enrollment>();
		ArrayList<Sessions> mySessions=new ArrayList<Sessions>();
		Sessions sessions=new Sessions();
		SessionsManager sessionsMan=new SessionsManager();
		mySessions=sessionsMan.selectSessions();
		request.setAttribute("sessions", mySessions);
		
		response.setContentType("application/pdf"); // Code 1
		Document document = new Document();
		try{
			PdfWriter.getInstance(document, 
				response.getOutputStream()); // Code 2
			document.open();
			//logo
			Image image = Image.getInstance("/home/zigama/workspace/ESRMS/WebContent/images/gsob.gif");
			image.setAlignment(0);
			image.scaleToFit(100,80);			
			
			//school
			
			Paragraph paragraph = new Paragraph();
			
			paragraph.add("GROUPE SCOLAIRE OFFICIEL DE BUTARE (INDATWA N'INKESHA)");
		
			paragraph.add(image);
			paragraph.setAlignment("CENTER");
			
		
			//bulletin
			if(request.getParameter("printbulletin")!=null){
				
				enrollment.setRegNO(request.getParameter("regno"));
				enrollment.setYearName(request.getParameter("yearname"));
				myEnrollment=enrollmentMan.searchEnrollmentByYear(enrollment);
				
				paragraph.add("School Bulletin");
				document.add(paragraph);
			
				// Code 3
				Paragraph line=new Paragraph();
				line.add("-------------------------");
				line.setAlignment("CENTER");
				line.setSpacingAfter(20);
				document.add(line);
				
				PdfPTable bulletin = new PdfPTable(1);
				
				
				for (Iterator iterator = myEnrollment.iterator(); iterator.hasNext();) {
					enrollment = (Enrollment) iterator.next();
					
					PdfPTable identif=new PdfPTable(1);
					identif.addCell("Registration Number: "+enrollment.getRegNO());
					identif.addCell("Full Name: "+enrollment.getFullname());
					identif.addCell("Academic Year: "+enrollment.getYearName());
					identif.addCell("Department: "+enrollment.getDepartment());
					identif.addCell("Class: "+enrollment.getClassCode());
					bulletin.addCell(identif);
					
					Marks marks=new Marks();
					MarksManager marksMan=new MarksManager();
					ArrayList<Marks> myMarks=new ArrayList<Marks>();
					marks.setRegNO(request.getParameter("regno"));
					marks.setEnrollmentID(enrollment.getEnrollmentID());
					marks.setSession(request.getParameter("sessions"));
					myMarks=marksMan.selectMarksByEnrollment(marks);
					request.setAttribute("marks", myMarks);
					float maxTotal=0,markTotal=0,maxQuizTotal=0,maxExamTotal=0,markQuizTotal=0,markExamTotal=0;
					String sessionName="";
					
					PdfPTable mark=new PdfPTable(3);
					mark.addCell("Course Titles");
					mark.addCell("Maximum Score");
					PdfPTable mark1=new PdfPTable(3);
					mark1.addCell("");
					PdfPTable max1=new PdfPTable(3);
					max1.addCell("Max Quiz");
					max1.addCell("Max Exam");
					max1.addCell("Total");
					mark1.addCell(max1);
					PdfPTable max2=new PdfPTable(3);
					max2.addCell("Mark Quiz");
					max2.addCell("Mark Exam");
					max2.addCell("Total");
					mark1.addCell(max2);
					PdfPTable mark2=new PdfPTable(3);
					for (Iterator iterator2 = myMarks.iterator(); iterator2
					.hasNext();) {
				marks = (Marks) iterator2.next();
				sessionName=marks.getSession();
				maxTotal=maxTotal+marks.getMaxScore();
				maxQuizTotal=maxQuizTotal+marks.getMaxScore()/2;
				maxExamTotal=maxExamTotal+marks.getMaxScore()/2;
				markQuizTotal=markQuizTotal+marks.getMarkQuiz();
				markExamTotal=markExamTotal+marks.getMarkExam();
				
				mark2.addCell(marks.getCourse());
				PdfPTable note1=new PdfPTable(3);
				note1.addCell(""+marks.getMaxScore()/2);
				note1.addCell(""+marks.getMaxScore()/2);
				note1.addCell(""+marks.getMaxScore());
				mark2.addCell(note1);
				PdfPTable note2=new PdfPTable(3);
				note2.addCell(""+marks.getMarkQuiz());
				note2.addCell(""+marks.getMarkExam());
				note2.addCell(""+(marks.getMarkQuiz()+marks.getMarkExam()));
				mark2.addCell(note2);

			}
					
					mark.addCell(sessionName);
					
					bulletin.addCell(mark);
					bulletin.addCell(mark1);
					bulletin.addCell(mark2);
					
					PdfPTable mark3=new PdfPTable(3);
					mark3.addCell("Total");
					PdfPTable tot1=new PdfPTable(3);
					tot1.addCell(""+maxQuizTotal);
					tot1.addCell(""+maxExamTotal);
					tot1.addCell(""+maxTotal);
					mark3.addCell(tot1);
					PdfPTable tot2=new PdfPTable(3);
					tot2.addCell(""+markQuizTotal);
					tot2.addCell(""+markExamTotal);
					
					
					markTotal=markQuizTotal+markExamTotal;
					
					tot2.addCell(""+markTotal);
					mark3.addCell(tot2);
					
					bulletin.addCell(mark3);
					PdfPTable mark4=new PdfPTable(2);
					if(maxTotal!=0){
						float percentage=(new BigDecimal( markTotal*100/maxTotal).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
						//request.setAttribute("percentage", percentage);
						
						mark4.addCell("Percentage");
						mark4.addCell(""+percentage+"%");
					}
					bulletin.addCell(mark4);
					
					PdfPTable mark5=new PdfPTable(2);
					mark5.addCell("School Stamp");
					mark5.addCell("");
					bulletin.addCell(mark5);
					
				}
				document.add(bulletin);
				
				
				
			}else if(request.getParameter("printattendance")!=null){
				
				enrollment.setRegNO(request.getParameter("regno"));
				enrollment.setYearName(request.getParameter("yearname"));
				myEnrollment=enrollmentMan.searchEnrollmentByYear(enrollment);
				
				paragraph.add("Student Attendance");
				document.add(paragraph);
			
				// Code 3
				Paragraph line=new Paragraph();
				line.add("-------------------------");
				line.setAlignment("CENTER");
				line.setSpacingAfter(20);
				document.add(line);
				//attendance table
				PdfPTable attendanceSheet = new PdfPTable(1);
				
				for (Iterator iterator = myEnrollment.iterator(); iterator.hasNext();) {
					enrollment = (Enrollment) iterator.next();
					//row 1 which is also a table of 5 rows
					PdfPTable identif=new PdfPTable(1);
					identif.addCell("Registration Number: "+enrollment.getRegNO());
					identif.addCell("Full Name: "+enrollment.getFullname());
					identif.addCell("Academic Year: "+enrollment.getYearName());
					identif.addCell("Department: "+enrollment.getDepartment());
					identif.addCell("Class: "+enrollment.getClassCode());
					attendanceSheet.addCell(identif);
					
					Attendance attendance=new Attendance();
					AttendanceManager attendanceMan=new AttendanceManager();
					ArrayList<Attendance> myAttendance=new ArrayList<Attendance>();
					attendance.setRegNO(request.getParameter("regno"));
					attendance.setEnrollmentID(enrollment.getEnrollmentID());
					attendance.setSession(request.getParameter("sessions"));
					myAttendance=attendanceMan.selectAttendanceByEnrollment(attendance);
					request.setAttribute("attendances", myAttendance);
					float percentageAttendance=0,percentageCourseAttendance=0;
					int totalAttendance=0,totalCourseAttendance=0,totalAbscence=0,totalExecusedAbscence=0;
					String sessionName="";
					//row 2 which also a table
					PdfPTable attend=new PdfPTable(1);
					//row 3
					PdfPTable attend1=new PdfPTable(6);
					attend1.addCell("Course Titles");
					attend1.addCell("Maximum attendance(min)");
					attend1.addCell("Unexcused Absence(min)");
					attend1.addCell("Excused Absence(min)");
					attend1.addCell("Total(min)");
					attend1.addCell("Percentage(%)");
					
					//row 3 which is also a table
					PdfPTable attend2=new PdfPTable(1);
					
					for (Iterator iterator2 = myAttendance.iterator(); iterator2
							.hasNext();) {
						attendance = (Attendance) iterator2.next();
						sessionName=attendance.getSession();
						totalAttendance=totalAttendance+attendance.getMaxAttendance();
						totalAbscence=totalAbscence+attendance.getAbscences();
						totalExecusedAbscence=totalExecusedAbscence+attendance.getExecusedAbscences();
						PdfPTable note2=new PdfPTable(6);
						note2.addCell(attendance.getCourse());
						note2.addCell(""+attendance.getMaxAttendance());
						
						note2.addCell(""+attendance.getAbscences());
						note2.addCell(""+attendance.getExecusedAbscences());
						note2.addCell(""+(attendance.getMaxAttendance()-(attendance.getAbscences()+attendance.getExecusedAbscences())));
						if(attendance.getMaxAttendance()!=0){
							percentageCourseAttendance=(new BigDecimal((attendance.getMaxAttendance()-(attendance.getAbscences()+attendance.getExecusedAbscences()))*100/attendance.getMaxAttendance()).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
							note2.addCell(""+percentageCourseAttendance);
						}
						attend2.addCell(note2);
							
					}
					attend.addCell(sessionName);
					
					attendanceSheet.addCell(attend);
					attendanceSheet.addCell(attend1);
					attendanceSheet.addCell(attend2);
					//row4 which is also a table
					
					PdfPTable attend3=new PdfPTable(6);
					attend3.addCell("Total");
					attend3.addCell(""+totalAttendance);
					attend3.addCell(""+totalAbscence);
					attend3.addCell(""+totalExecusedAbscence);
					totalCourseAttendance=totalAttendance-(totalAbscence+totalExecusedAbscence);
					attend3.addCell(""+totalCourseAttendance);
					attend3.addCell("");
					attendanceSheet.addCell(attend3);
					
					
					//row 5 whichis also a table
					PdfPTable attend4=new PdfPTable(2);
					if(totalAttendance!=0){
						percentageAttendance=(new BigDecimal( totalCourseAttendance*100/totalAttendance).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
						//request.setAttribute("percentageAttendance", percentageAttendance);
						attend4.addCell("Percentage");
						attend4.addCell(""+percentageAttendance+"%");
						}
						
					
					attendanceSheet.addCell(attend4);
					//row 6 which is alos a table
					PdfPTable attend5=new PdfPTable(2);
					attend5.addCell("School Stamp");
					attend5.addCell("");
					attendanceSheet.addCell(attend5);
					
					
						
				}
				document.add(attendanceSheet);
				
			}else if(request.getParameter("reportdiscipline")!=null){
				
				enrollment.setRegNO(request.getParameter("regno"));
				enrollment.setYearName(request.getParameter("yearname"));
				myEnrollment=enrollmentMan.searchEnrollmentByYear(enrollment);
				
				paragraph.add("Student Disipline");
				document.add(paragraph);
			
				// Code 3
				Paragraph line=new Paragraph();
				line.add("-------------------------");
				line.setAlignment("CENTER");
				line.setSpacingAfter(20);
				document.add(line);
				
				PdfPTable disciplineSheet = new PdfPTable(1);
				
				for (Iterator iterator = myEnrollment.iterator(); iterator.hasNext();) {
					enrollment = (Enrollment) iterator.next();
					
					PdfPTable identif=new PdfPTable(1);
					identif.addCell("Registration Number: "+enrollment.getRegNO());
					identif.addCell("Full Name: "+enrollment.getFullname());
					identif.addCell("Academic Year: "+enrollment.getYearName());
					identif.addCell("Department: "+enrollment.getDepartment());
					identif.addCell("Class: "+enrollment.getClassCode());
					disciplineSheet.addCell(identif);
					
					Discipline discipline=new Discipline();
					DisciplineManager disciplineMan=new DisciplineManager();
					ArrayList<Discipline> myDiscipline=new ArrayList<Discipline>();
					discipline.setRegNO(request.getParameter("regno"));
					discipline.setEnrollmentID(enrollment.getEnrollmentID());
					discipline.setSession(request.getParameter("sessions"));
					myDiscipline=disciplineMan.selectDisciplineByEnrollment(discipline);
					request.setAttribute("discipline", myDiscipline);
					String sessionName="";
					
					PdfPTable discip=new PdfPTable(1);
					//row 3
					PdfPTable discip1=new PdfPTable(4);
					discip1.addCell("Offense Type");
					discip1.addCell("Offense occurence date");
					discip1.addCell("Offense Occurence Location");
					discip1.addCell("Disciplinary Action");
					
					//row 3 which is also a table
					PdfPTable discip2=new PdfPTable(1);
					
					for (Iterator iterator2 = myDiscipline.iterator(); iterator2
							.hasNext();) {
						 discipline = (Discipline) iterator2.next();
						 
						 sessionName=discipline.getSession();
						 PdfPTable note2=new PdfPTable(4);
							note2.addCell(""+discipline.getOffenseType());
							note2.addCell(""+discipline.getOffenseOccurence());
							
							note2.addCell(""+discipline.getOffenseLocation());
							note2.addCell(""+discipline.getDisciplinaryAction());
							
							discip2.addCell(note2);
							
						 }
					
					discip.addCell(sessionName);
					
					disciplineSheet.addCell(discip);
					disciplineSheet.addCell(discip1);
					disciplineSheet.addCell(discip2);
					PdfPTable discip3=new PdfPTable(2);
					discip3.addCell("School Stamp");
					discip3.addCell("");
					disciplineSheet.addCell(discip3);
				}
				document.add(disciplineSheet);
				
			}else if(request.getParameter("printclasslist")!=null){
				
				enrollment.setClassCode(request.getParameter("classi"));
				enrollment.setYearName(request.getParameter("yearname"));
				myEnrollment=enrollmentMan.selectClassList(enrollment);
				
				paragraph.add("Class List");
				document.add(paragraph);
			
				// Code 3
				Paragraph line=new Paragraph();
				line.add("-------------------------");
				line.setAlignment("CENTER");
				line.setSpacingAfter(20);
				document.add(line);
				
				PdfPTable classeList = new PdfPTable(1);
				
				String classe="",acadeyear="",departement="";
				
				//row 3
				PdfPTable discip1=new PdfPTable(3);
				//row 3 which is also a table
				PdfPTable discip2=new PdfPTable(1);
				
				PdfPTable discip3=new PdfPTable(2);
				int no=1;
				for (Iterator iterator = myEnrollment.iterator(); iterator.hasNext();) {
					enrollment = (Enrollment) iterator.next();
					
					classe=enrollment.getClassCode();
					acadeyear=enrollment.getYearName();
					departement=enrollment.getDepartment();
					
					
					
								
					
					
						 
						 
						 PdfPTable note2=new PdfPTable(3);
						 	
						 note2.addCell(""+no++);
							note2.addCell(""+enrollment.getFullname());
							note2.addCell(""+enrollment.getRegNO());
							
							
							
							
							discip2.addCell(note2);
							
						 
					
					
					
					
					
				}
				PdfPTable identif=new PdfPTable(1);
				identif.addCell("Academic Year: "+acadeyear);
				identif.addCell("Department: "+departement);
				identif.addCell("Class: "+classe);
				classeList.addCell(identif);
				
				discip1.addCell("NO");
				discip1.addCell("Student Name");
				discip1.addCell("Student Registration Number");
				
				discip3.addCell("School Stamp");
				discip3.addCell("");
				
				
				classeList.addCell(discip1);
				classeList.addCell(discip2);
				classeList.addCell(discip3);
				
				document.add(classeList);
				
			
				
			}
			
			
						document.close(); 
		}catch(DocumentException e){
			e.printStackTrace();
		}

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}

}
