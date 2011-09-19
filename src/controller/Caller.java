package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.AcademicYearManager;
import manager.AttendanceManager;
import manager.ClassroomManager;
import manager.CourseManager;
import manager.DisciplineManager;
import manager.DistrictManager;
import manager.EnrollmentManager;
import manager.MarksManager;
import manager.RoleManager;
import manager.SMSManager;
import manager.SectorManager;
import manager.SessionsManager;
import manager.StudentInfoManager;
import manager.UserManager;
import dbaccess.JDBCFun;
import domain.AcademicYear;
import domain.Attendance;
import domain.Classroom;
import domain.Courses;
import domain.Discipline;
import domain.District;
import domain.Enrollment;
import domain.Marks;
import domain.Role;
import domain.SMS;
import domain.Sector;
import domain.Sessions;
import domain.Student;
import domain.User;



/**
 * Servlet implementation class Caller
 */
public class Caller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Caller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Initialization of the Global Variables and instances during the application Navigation
		String welcome="";
		int pagenum=0;
		String direction=request.getParameter("mdl");
		User user = new User();
		UserManager userMan = new UserManager();
		District district=new District();
		DistrictManager districtMan=new DistrictManager();
		Sector sector=new Sector();
		SectorManager sectorMan=new SectorManager();
		Student studentInfo=new Student();
		StudentInfoManager studentInfoMan=new StudentInfoManager();
		HttpSession session = request.getSession(true);
				
if (direction==null || direction.equals("logout")) {
			//Destroy an existing session from the Application server memory. and redirect the user to the start.
			session.invalidate();
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);
			// response.sendRedirect("index.jsp");
			
		}else if(direction.equals("Logged")){
			//what happen if a user need to close the current Module and go back to the welcome page
			request.setAttribute("myLoggedUser", request.getAttribute("myLoggedUser"));
			
			request.getRequestDispatcher("/modules/welcome.jsp").forward(request,
					response);
			
		}else if(direction.equals("login")){
			// what happen when we login the system
			String logStatus="";
			
		// when the login button is clicked	
		if(request.getParameter("Login")!=null){
			// get the username and the password, by hashing the password
			user.setUserName(request.getParameter("username"));
			try {
				user.setPassword(user.MD5(request.getParameter("password")));
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//retrieve information about the logged user
			ArrayList<User> loginUser=new ArrayList<User>();
			loginUser=userMan.userLogin(user);
			//what if the user is in the database
			if(!(loginUser.isEmpty())){
				
				for (Iterator numberOfUser = loginUser.iterator(); numberOfUser
						.hasNext();) {
					User myLoggedUser = (User) numberOfUser.next();
					//session implementation and user added to the session
					
					if (session.isNew() == false) {
						session.invalidate();
						session = request.getSession(true);
						//set session max timeout
						session.setMaxInactiveInterval(60*5);
						}
					 welcome="Welcome";
					session.setAttribute("myLoggedUser", myLoggedUser);
					session.setAttribute("welcome", welcome);
					User userBean = (User)session.getAttribute("myLoggedUser");
					if (userBean == null) {
						response.sendRedirect("index.jsp");
					return;
					}
					
					//request.setAttribute("myLoggedUser",myLoggedUser);
				}
				
				
				//Send a correct user to the welcome page
				
				request.getRequestDispatcher("/modules/welcome.jsp").forward(request,
						response);
			// if no such user in the database	
			}else if(loginUser.isEmpty()){
				
				logStatus="Check your Username and Password and try again.";
				request.setAttribute("logStatus", logStatus);
				request.getRequestDispatcher("/index.jsp").forward(request,
						response);
			}
			
		}else{
			session.invalidate();
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);
		}
		
		}


// call the administrator module
else if(direction.equals("accesscon")&& request.getSession().getAttribute("myLoggedUser")!=null){
			
			//initialize a user
			ArrayList<User> myUsers=new ArrayList<User>();
			//initialize user roles
			RoleManager roleMan=new RoleManager();
			ArrayList<Role> myRole=new ArrayList<Role>();
			myRole=roleMan.selectRoles();
		//request for editing the user profile
			if(request.getParameter("edit").equals("UseProfile")){
				
				user.setUserID(Integer.parseInt(request.getParameter("user")));
				ArrayList<User> requestUser=new ArrayList<User>();
				requestUser=userMan.searchUser(user);
				request.setAttribute("roles",myRole);				
				request.setAttribute("userToUpdate",requestUser);
				
				}else if(request.getParameter("edit").equals("new")){
					//request for adding new user accounts
					request.setAttribute("roles",myRole);
				}else if(request.getParameter("edit").equals("all")){
					
					
					//paging purposes	
					  int recordCount=userMan.countUsers();
					  int pagerows=10;
					double lastpage=Math.ceil((double)recordCount/(double)pagerows);
					if(pagenum<1){pagenum=1;
					}else if(pagenum>(int)lastpage){
						pagenum=(int)lastpage;
					}
					if(request.getParameter("pagenum")==null){
						
						pagenum=1;
					}else{
						pagenum=Integer.parseInt(request.getParameter("pagenum"));
					}
					//end of paging purposes
					
					if(request.getParameter("FilterUsers")!=null){
						// filter users by user name
						user.setUserName(request.getParameter("filter_username"));
						myUsers=userMan.searchUser(user);
						request.setAttribute("pagenum", pagenum);
					    request.setAttribute("lastpage", (int)lastpage);
						request.setAttribute("users", myUsers);
					}else{
						//request for all users display
					
						
					    myUsers=userMan.selectUsers(pagenum,pagerows);
					    request.setAttribute("pagenum", pagenum);
					    request.setAttribute("lastpage", (int)lastpage);
						request.setAttribute("users", myUsers);
					}
				}
				
			
		request.getRequestDispatcher("/modules/accesscon.jsp").forward(request,
				response);
			
	}//start messages modules control
	else if(direction.equals("msg")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		//initialize a message
		SMS sms=new SMS();
		ArrayList<SMS> mySMSs=new ArrayList<SMS>();
		//Initialize message manager
		SMSManager smsMan=new SMSManager();
if(request.getParameter("edit").equals("smsProfile")){
			
			sms.setSmsID(Integer.parseInt(request.getParameter("sms")));
			ArrayList<SMS> requestSMS=new ArrayList<SMS>();
			requestSMS=smsMan.searchSMS(sms);
							
			request.setAttribute("smsToUpdate",requestSMS);
			
			}else if(request.getParameter("edit").equals("all")){
				
				//paging purposes	
				  int recordCount=smsMan.countSMS();
				  int pagerows=10;
				double lastpage=Math.ceil((double)recordCount/(double)pagerows);
				if(pagenum<1){pagenum=1;
				}else if(pagenum>(int)lastpage){
					pagenum=(int)lastpage;
				}
				if(request.getParameter("pagenum")==null){
					
					pagenum=1;
				}else{
					pagenum=Integer.parseInt(request.getParameter("pagenum"));
				}
				//end of paging purposes
				
			//request for all users display
			    mySMSs=smsMan.selectSMSs(pagenum, pagerows);
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
				request.setAttribute("SMSs", mySMSs);
		}
		
		
		request.getRequestDispatcher("/modules/message.jsp").forward(request,
				response);
	}else if(direction.equals("personinfo")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		ArrayList<District> myDistricts=new ArrayList<District>();
		ArrayList<Sector> mySectors=new ArrayList<Sector>();
		myDistricts=districtMan.selectDistricts();
		request.setAttribute("districts", myDistricts);
		String regNumber=studentInfoMan.selectNewRegNO();
		request.setAttribute("newRegNO", regNumber);
		
		//initialize student Infos
		ArrayList<Student> myStudent=new ArrayList<Student>();
		
	//request for editing the student profile
		if(request.getParameter("edit").equals("UseProfile")){
			
			studentInfo.setStudentRegNO(request.getParameter("student"));
			ArrayList<Student> requestStudent=new ArrayList<Student>();
			requestStudent=studentInfoMan.searchStudentInfos(studentInfo);
			for (Iterator numberOfRequest = requestStudent.iterator(); numberOfRequest
					.hasNext();) {
				studentInfo = (Student) numberOfRequest.next();
				mySectors=sectorMan.selectSectors(Integer.parseInt(studentInfo.getStudentDistrict()));
				request.setAttribute("sectors", mySectors);
			}
							
			request.setAttribute("studentToUpdate",requestStudent);
			
			}else if(request.getParameter("edit").equals("new")){
				//request for adding new student
				request.setAttribute("newRegNO", regNumber);
				
				
			}else if(request.getParameter("edit").equals("all")){
				
				
				//paging purposes	
				  int recordCount=studentInfoMan.countStudents();
				  int pagerows=10;
				double lastpage=Math.ceil((double)recordCount/(double)pagerows);
				if(pagenum<1){pagenum=1;
				}else if(pagenum>(int)lastpage){
					pagenum=(int)lastpage;
				}
				if(request.getParameter("pagenum")==null){
					
					pagenum=1;
				}else{
					pagenum=Integer.parseInt(request.getParameter("pagenum"));
				}
				//end of paging purposes
				
				if(request.getParameter("FilterStudent")!=null){
					// filter users by user name
					studentInfo.setStudentRegNO(request.getParameter("filter_regNO"));
					myStudent=studentInfoMan.searchStudentInfos(studentInfo);
					for (Iterator numberOfStudent = myStudent.iterator(); numberOfStudent
							.hasNext();) {
					 studentInfo = (Student) numberOfStudent.next();
					 String dist=studentInfo.getStudentDistrict();
					 String sect=studentInfo.getStudentSector();
					 for (Iterator numberOfDistrict = myDistricts.iterator(); numberOfDistrict
							.hasNext();) {
						 district = (District) numberOfDistrict.next();
						 if(district.getDistrictID()==Integer.parseInt(dist)){
							 mySectors=sectorMan.selectSectors(Integer.parseInt(studentInfo.getStudentDistrict()));
							 for (Iterator numberOfSectors = mySectors.iterator(); numberOfSectors
									.hasNext();) {
								 sector = (Sector) numberOfSectors.next();
								 if(sector.getSectorID()==Integer.parseInt(sect)){
									 
									 String secto=sector.getSectorName();
									 
									 studentInfo.setStudentSector(secto);
								 }
								
								
							}
								
							 String disti=district.getDistrictName();
							studentInfo.setStudentDistrict(disti);
						 }
							
						
						
					}
					
						
					}
					
					request.setAttribute("pagenum", pagenum);
				    request.setAttribute("lastpage", (int)lastpage);
					request.setAttribute("students", myStudent);
				}else{
					//request for all users display
				
					
				    myStudent=studentInfoMan.selectStudents(pagenum, pagerows);
				    			
				    request.setAttribute("pagenum", pagenum);
				    request.setAttribute("lastpage", (int)lastpage);
					request.setAttribute("students", myStudent);
				}
		

		
			}
		
		request.getRequestDispatcher("/modules/personinfo/personinfo.jsp").forward(request,
				response);
	}else if(direction.equals("enrollment")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		ArrayList<Enrollment> myEnrollment=new ArrayList<Enrollment>();
		Enrollment enrollment=new Enrollment();
		EnrollmentManager enrollmentMan=new EnrollmentManager();
		
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectCurrentAcadYear();
		String year="";
		for (Iterator numberOfYears = myAcadeYear.iterator(); numberOfYears.hasNext();) {
			acadeYear = (AcademicYear) numberOfYears.next();
			 year = acadeYear.getYearName();
					}
		request.setAttribute("curryear", year);		
		
		ArrayList<Classroom> myClass=new ArrayList<Classroom>();
		Classroom classroom=new Classroom();
		ClassroomManager classroomMan = new ClassroomManager();
		myClass=classroomMan.selectClasses();
		request.setAttribute("classes", myClass);
		
		if(request.getParameter("edit").equals("UseProfile")){
			
			enrollment.setEnrollmentID(Integer.parseInt(request.getParameter("enrollment")));
			myEnrollment=enrollmentMan.searchEnrollment(enrollment)	;
			
			 for (Iterator numberOfEnrollments = myEnrollment.iterator(); numberOfEnrollments.hasNext();) {
				 enrollment = (Enrollment) numberOfEnrollments.next();
				 
				Student student=new Student();
				student.setStudentRegNO(enrollment.getRegNO());
				ArrayList<Student> myStudent=new ArrayList<Student>();
				myStudent=studentInfoMan.searchStudentInfos(student);
				for (Iterator numberOfStudent = myStudent.iterator(); numberOfStudent
						.hasNext();) {
					 student = (Student) numberOfStudent.next();
					 String name=student.getStudentFirstName()+" "+student.getStudentLastName();
					 enrollment.setFullname(name);
					
				}
				 
				 myClass=classroomMan.selectClass(enrollment.getClassCode());
				 for (Iterator numberOfClass = myClass.iterator(); numberOfClass
						.hasNext();) {
					classroom = (Classroom) numberOfClass.next();
					
					String department=classroom.getDepartmentName()+"("+classroom.getDepartmentShortName()+")";
					enrollment.setDepartment(department);
					
					
				}
				
				
			}			
		    
		   
			request.setAttribute("enrollmentToUpdate", myEnrollment);
			
		}else if(request.getParameter("edit").equals("all")){
			
			
			//paging purposes	
			  int recordCount=enrollmentMan.countEnrollments();
			  int pagerows=10;
			double lastpage=Math.ceil((double)recordCount/(double)pagerows);
			if(pagenum<1){pagenum=1;
			}else if(pagenum>(int)lastpage){
				pagenum=(int)lastpage;
			}
			if(request.getParameter("pagenum")==null){
				
				pagenum=1;
			}else{
				pagenum=Integer.parseInt(request.getParameter("pagenum"));
			}
			//end of paging purposes
			
			if(request.getParameter("FilterEnrollment")!=null){
				enrollment.setRegNO(request.getParameter("filter_regNO"));
				myEnrollment=enrollmentMan.searchEnrollment(enrollment)	;
				
				 for (Iterator numberOfEnrollments = myEnrollment.iterator(); numberOfEnrollments.hasNext();) {
					 enrollment = (Enrollment) numberOfEnrollments.next();
					 
					Student student=new Student();
					student.setStudentRegNO(enrollment.getRegNO());
					ArrayList<Student> myStudent=new ArrayList<Student>();
					myStudent=studentInfoMan.searchStudentInfos(student);
					for (Iterator numberOfStudent = myStudent.iterator(); numberOfStudent
							.hasNext();) {
						 student = (Student) numberOfStudent.next();
						 String name=student.getStudentFirstName()+" "+student.getStudentLastName();
						 enrollment.setFullname(name);
						
					}
					 
					 myClass=classroomMan.selectClass(enrollment.getClassCode());
					 for (Iterator numberOfClass = myClass.iterator(); numberOfClass
							.hasNext();) {
						classroom = (Classroom) numberOfClass.next();
						
						String department=classroom.getDepartmentName()+"("+classroom.getDepartmentShortName()+")";
						enrollment.setDepartment(department);
						
						
					}
					
					
				}			
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("enrollments", myEnrollment);
			
				
			}else{
				
				//request for all enrollments display
				
				
			    myEnrollment=enrollmentMan.selectEnrollments(pagenum, pagerows);
			    
			    for (Iterator numberOfEnrollments = myEnrollment.iterator(); numberOfEnrollments.hasNext();) {
					 enrollment = (Enrollment) numberOfEnrollments.next();
					 
					Student student=new Student();
					student.setStudentRegNO(enrollment.getRegNO());
					ArrayList<Student> myStudent=new ArrayList<Student>();
					myStudent=studentInfoMan.searchStudentInfos(student);
					for (Iterator numberOfStudent = myStudent.iterator(); numberOfStudent
							.hasNext();) {
						 student = (Student) numberOfStudent.next();
						 String name=student.getStudentFirstName()+" "+student.getStudentLastName();
						 enrollment.setFullname(name);
						
					}
					 
					 myClass=classroomMan.selectClass(enrollment.getClassCode());
					 for (Iterator numberOfClass = myClass.iterator(); numberOfClass
							.hasNext();) {
						classroom = (Classroom) numberOfClass.next();
						
						String department=classroom.getDepartmentName()+"("+classroom.getDepartmentShortName()+")";
						enrollment.setDepartment(department);
						
						
					}
					
					
				}			
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("enrollments", myEnrollment);
				
			}
			
		}
		
		
		request.getRequestDispatcher("/modules/enrollment/enrollment.jsp").forward(request,
				response);
	}else if(direction.equals("score")&& request.getSession().getAttribute("myLoggedUser")!=null){
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectAcadYears();
		request.setAttribute("years", myAcadeYear);
		ArrayList<Sessions> mySessions=new ArrayList<Sessions>();
		Sessions sessions=new Sessions();
		SessionsManager sessionsMan=new SessionsManager();
		mySessions=sessionsMan.selectSessions();
		request.setAttribute("sessions", mySessions);
		ArrayList<Courses> myCourses=new ArrayList<Courses>();
		Courses course=new Courses();
		CourseManager courseMan=new CourseManager();
		myCourses=courseMan.selectCourses();
		request.setAttribute("courses", myCourses);
		
		ArrayList<Marks> myMarks=new ArrayList<Marks>();
		Marks marks=new Marks();
		MarksManager marksMan=new MarksManager();
		
		
		if(request.getParameter("edit").equals("UseProfile")){
			
			marks.setMarkID(Integer.parseInt(request.getParameter("score")));
			myMarks=marksMan.searchMarks(marks);
			request.setAttribute("scoreToUpdate", myMarks);
			}else if(request.getParameter("edit").equals("all")){
		
			
			
			//paging purposes	
			  int recordCount=marksMan.countMarks();
			  int pagerows=10;
			double lastpage=Math.ceil((double)recordCount/(double)pagerows);
			if(pagenum<1){pagenum=1;
			}else if(pagenum>(int)lastpage){
				pagenum=(int)lastpage;
			}
			if(request.getParameter("pagenum")==null){
				
				pagenum=1;
			}else{
				pagenum=Integer.parseInt(request.getParameter("pagenum"));
			}
			//end of paging purposes
			
			if(request.getParameter("FilterMarks")!=null){
				marks.setRegNO(request.getParameter("filter_regNO"));
				myMarks=marksMan.filterMarks(marks, pagenum, pagerows)	;
				
							
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("scores", myMarks);
			
				
			}else{
				myMarks=marksMan.selectMarks(pagenum,pagerows)	;
				
				
				request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("scores", myMarks);
			}
		
			}
		request.getRequestDispatcher("/modules/score/score.jsp").forward(request,
				response);
	}else if(direction.equals("attendance")&& request.getSession().getAttribute("myLoggedUser")!=null){
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectAcadYears();
		request.setAttribute("years", myAcadeYear);
		ArrayList<Sessions> mySessions=new ArrayList<Sessions>();
		Sessions sessions=new Sessions();
		SessionsManager sessionsMan=new SessionsManager();
		mySessions=sessionsMan.selectSessions();
		request.setAttribute("sessions", mySessions);
		ArrayList<Courses> myCourses=new ArrayList<Courses>();
		Courses course=new Courses();
		CourseManager courseMan=new CourseManager();
		myCourses=courseMan.selectCourses();
		request.setAttribute("courses", myCourses);
		
		ArrayList<Attendance> myAttendance=new ArrayList<Attendance>();
		Attendance attendance=new Attendance();
		AttendanceManager attendanceMan=new AttendanceManager();
		
		if(request.getParameter("edit").equals("UseProfile")){
			
			attendance.setAttendanceID(Integer.parseInt(request.getParameter("attendance")));
			myAttendance=attendanceMan.searchAttendances(attendance);
			request.setAttribute("attendanceToUpdate", myAttendance);
			
		}else if(request.getParameter("edit").equals("all")){
			
			//paging purposes	
			  int recordCount=attendanceMan.countAttendance();
			  int pagerows=10;
			double lastpage=Math.ceil((double)recordCount/(double)pagerows);
			if(pagenum<1){pagenum=1;
			}else if(pagenum>(int)lastpage){
				pagenum=(int)lastpage;
			}
			if(request.getParameter("pagenum")==null){
				
				pagenum=1;
			}else{
				pagenum=Integer.parseInt(request.getParameter("pagenum"));
			}
			//end of paging purposes
			if(request.getParameter("FilterAttendance")!=null){
				attendance.setRegNO(request.getParameter("filter_regNO"));
				myAttendance=attendanceMan.filterAttendances(attendance, pagenum, pagerows)	;
				
							
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("attendances", myAttendance);
			
				
			}else{
				myAttendance=attendanceMan.selectAttendances(pagenum, pagerows);
				
				
				request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("attendances", myAttendance);
			}
			
			
		}
		
		request.getRequestDispatcher("/modules/attendance/attendance.jsp").forward(request,
				response);
	}else if(direction.equals("discipline")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectAcadYears();
		request.setAttribute("years", myAcadeYear);
		ArrayList<Sessions> mySessions=new ArrayList<Sessions>();
		Sessions sessions=new Sessions();
		SessionsManager sessionsMan=new SessionsManager();
		mySessions=sessionsMan.selectSessions();
		request.setAttribute("sessions", mySessions);
		
		Discipline discipline=new Discipline();
		DisciplineManager disciplineMan=new DisciplineManager();
		ArrayList<Discipline> myDiscipline=new ArrayList<Discipline>();
		
		if(request.getParameter("edit").equals("UseProfile")){
			
			discipline.setDisciplineID(Integer.parseInt(request.getParameter("discipline")));
			myDiscipline=disciplineMan.searchDiscipline(discipline);
			
			request.setAttribute("disciplineToUpdate", myDiscipline);
			
			}else if(request.getParameter("edit").equals("all")){
			
			//paging purposes	
			  int recordCount=disciplineMan.countDiscpline();
			  int pagerows=10;
			double lastpage=Math.ceil((double)recordCount/(double)pagerows);
			if(pagenum<1){pagenum=1;
			}else if(pagenum>(int)lastpage){
				pagenum=(int)lastpage;
			}
			if(request.getParameter("pagenum")==null){
				
				pagenum=1;
			}else{
				pagenum=Integer.parseInt(request.getParameter("pagenum"));
			}
			//end of paging purposes
			if(request.getParameter("FilterDiscipline")!=null){
				discipline.setRegNO(request.getParameter("filter_regNO"));
				myDiscipline=disciplineMan.filterDiscipline(discipline, pagenum, pagerows);
				
							
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("disciplines", myDiscipline);
			
				
			}else{
				myDiscipline=disciplineMan.selectDiscipline(pagenum, pagerows);
				
				
				request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("disciplines", myDiscipline);
			}
		
			}
		request.getRequestDispatcher("/modules/discipline/discipline.jsp").forward(request,
				response);
	}else if(direction.equals("monitor")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
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
		Student student=new Student();
		student.setStudentUserName(request.getParameter("username"));
		ArrayList<Student> myStudent=new ArrayList<Student>();
		myStudent=studentInfoMan.searchStudentInfos(student);
		for (Iterator iterator = myStudent.iterator(); iterator.hasNext();) {
			 student = (Student) iterator.next();
			String regno=student.getStudentRegNO();
			request.setAttribute("studentRegNO", regno);
			
			
		}
		if(request.getParameter("regno")!=null && request.getParameter("yearname")!=null && request.getParameter("sessions")!=null){
			
			
			
			enrollment.setRegNO(request.getParameter("regno"));
			enrollment.setYearName(request.getParameter("yearname"));
			myEnrollment=enrollmentMan.searchEnrollmentByYear(enrollment);
			request.setAttribute("enrollment", myEnrollment);
			for (Iterator iterator = myEnrollment.iterator(); iterator.hasNext();) {
				enrollment = (Enrollment) iterator.next();
				
				Marks marks=new Marks();
				MarksManager marksMan=new MarksManager();
				ArrayList<Marks> myMarks=new ArrayList<Marks>();
				marks.setRegNO(request.getParameter("regno"));
				marks.setEnrollmentID(enrollment.getEnrollmentID());
				marks.setSession(request.getParameter("sessions"));
				myMarks=marksMan.selectMarksByEnrollment(marks);
				request.setAttribute("marks", myMarks);
				float maxTotal=0,markTotal=0,maxQuizTotal=0,maxExamTotal=0,markQuizTotal=0,markExamTotal=0;
				
				for (Iterator iterator2 = myMarks.iterator(); iterator2
						.hasNext();) {
					marks = (Marks) iterator2.next();
					String sessionName=marks.getSession();
					String sessionID=request.getParameter("sessions");
					request.setAttribute("sessionName", sessionName);
					request.setAttribute("sessionID", sessionID);
					
					maxTotal=maxTotal+marks.getMaxScore();
					maxQuizTotal=maxQuizTotal+marks.getMaxScore()/2;
					maxExamTotal=maxExamTotal+marks.getMaxScore()/2;
					markQuizTotal=markQuizTotal+marks.getMarkQuiz();
					markExamTotal=markExamTotal+marks.getMarkExam();

				}
				markTotal=markQuizTotal+markExamTotal;
				if(maxTotal!=0){
					float percentage=(new BigDecimal( markTotal*100/maxTotal).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
					request.setAttribute("percentage", percentage);
				}
				
				request.setAttribute("maxTotal", maxTotal);
				request.setAttribute("maxQuizTotal", maxQuizTotal);
				request.setAttribute("maxExamTotal", maxExamTotal);
				request.setAttribute("markQuizTotal", markQuizTotal);
				request.setAttribute("markExamTotal", markExamTotal);
				request.setAttribute("markTotal", markTotal);
				
				
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
				for (Iterator iterator2 = myAttendance.iterator(); iterator2
						.hasNext();) {
					attendance = (Attendance) iterator2.next();
					totalAttendance=totalAttendance+attendance.getMaxAttendance();
					totalAbscence=totalAbscence+attendance.getAbscences();
					totalExecusedAbscence=totalExecusedAbscence+attendance.getExecusedAbscences();
					if(attendance.getMaxAttendance()!=0){
						percentageCourseAttendance=(new BigDecimal((attendance.getMaxAttendance()-(attendance.getAbscences()+attendance.getExecusedAbscences()))*100/attendance.getMaxAttendance()).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
					}
				}
				totalCourseAttendance=totalAttendance-(totalAbscence+totalExecusedAbscence);
				if(totalAttendance!=0){
					percentageAttendance=(new BigDecimal( totalCourseAttendance*100/totalAttendance).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
					request.setAttribute("percentageAttendance", percentageAttendance);
					}
				
				request.setAttribute("percentageCourseAttendance", percentageCourseAttendance);
				request.setAttribute("totalAttendance", totalAttendance);
				request.setAttribute("totalAbscence", totalAbscence);
				request.setAttribute("totalExecusedAbscence", totalExecusedAbscence);
				request.setAttribute("totalCourseAttendance", totalCourseAttendance);
				
				Discipline discipline=new Discipline();
				DisciplineManager disciplineMan=new DisciplineManager();
				ArrayList<Discipline> myDiscipline=new ArrayList<Discipline>();
				discipline.setRegNO(request.getParameter("regno"));
				discipline.setEnrollmentID(enrollment.getEnrollmentID());
				discipline.setSession(request.getParameter("sessions"));
				myDiscipline=disciplineMan.selectDisciplineByEnrollment(discipline);
				request.setAttribute("discipline", myDiscipline);
				
				
			}
			
		}
		
		request.getRequestDispatcher("/modules/monitor/monitor.jsp").forward(request,response);
		
	}else if(direction.equals("profile")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		//personal information
		ArrayList<District> myDistricts=new ArrayList<District>();
		ArrayList<Sector> mySectors=new ArrayList<Sector>();
		myDistricts=districtMan.selectDistricts();
		request.setAttribute("districts", myDistricts);
		Student student=new Student();
		student.setStudentUserName(request.getParameter("username"));
		ArrayList<Student> myStudent=new ArrayList<Student>();
		myStudent=studentInfoMan.searchStudentInfos(student);
		for (Iterator iterator = myStudent.iterator(); iterator.hasNext();) {
			studentInfo = (Student) iterator.next();
			 String dist=studentInfo.getStudentDistrict();
			 request.setAttribute("dist", dist);
			 String sect=studentInfo.getStudentSector();
			 request.setAttribute("sect", sect);
			 for (Iterator numberOfDistrict = myDistricts.iterator(); numberOfDistrict
					.hasNext();) {
				 district = (District) numberOfDistrict.next();
				 if(district.getDistrictID()==Integer.parseInt(dist)){
					 mySectors=sectorMan.selectSectors(Integer.parseInt(studentInfo.getStudentDistrict()));
					 for (Iterator numberOfSectors = mySectors.iterator(); numberOfSectors
							.hasNext();) {
						 sector = (Sector) numberOfSectors.next();
						 if(sector.getSectorID()==Integer.parseInt(sect)){
							 
							 String secto=sector.getSectorName();
							 
							 studentInfo.setStudentSector(secto);
						 }
						
						
					}
						
					 String disti=district.getDistrictName();
					studentInfo.setStudentDistrict(disti);
				 }
					
				}
		
		}			
					request.setAttribute("sectors", mySectors);
					request.setAttribute("students", myStudent);
		
		request.getRequestDispatcher("/modules/monitor/profile.jsp").forward(request,response);
		
	}else if(direction.equals("analysis")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
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
		ArrayList<Classroom> myClass=new ArrayList<Classroom>();
		Classroom classroom=new Classroom();
		ClassroomManager classroomMan = new ClassroomManager();
		
		/*Student student=new Student();
		student.setStudentUserName(request.getParameter("username"));
		ArrayList<Student> myStudent=new ArrayList<Student>();
		myStudent=studentInfoMan.searchStudentInfos(student);
		for (Iterator iterator = myStudent.iterator(); iterator.hasNext();) {
			 student = (Student) iterator.next();
			String regno=student.getStudentRegNO();
			request.setAttribute("studentRegNO", regno);
			
			
		}*/
		if(request.getParameter("regno")!=null && request.getParameter("yearname")!=null && request.getParameter("sessions")!=null){
			
			//personal information
			ArrayList<District> myDistricts=new ArrayList<District>();
			ArrayList<Sector> mySectors=new ArrayList<Sector>();
			myDistricts=districtMan.selectDistricts();
			request.setAttribute("districts", myDistricts);
			
			//initialize student Infos
			ArrayList<Student> myStudent=new ArrayList<Student>();
							
				studentInfo.setStudentRegNO(request.getParameter("regno"));
				
						myStudent=studentInfoMan.searchStudentInfos(studentInfo);
						for (Iterator numberOfStudent = myStudent.iterator(); numberOfStudent
								.hasNext();) {
						 studentInfo = (Student) numberOfStudent.next();
						 String dist=studentInfo.getStudentDistrict();
						 String sect=studentInfo.getStudentSector();
						 for (Iterator numberOfDistrict = myDistricts.iterator(); numberOfDistrict
								.hasNext();) {
							 district = (District) numberOfDistrict.next();
							 if(district.getDistrictID()==Integer.parseInt(dist)){
								 mySectors=sectorMan.selectSectors(Integer.parseInt(studentInfo.getStudentDistrict()));
								 for (Iterator numberOfSectors = mySectors.iterator(); numberOfSectors
										.hasNext();) {
									 sector = (Sector) numberOfSectors.next();
									 if(sector.getSectorID()==Integer.parseInt(sect)){
										 
										 String secto=sector.getSectorName();
										 
										 studentInfo.setStudentSector(secto);
									 }
									
									
								}
									
								 String disti=district.getDistrictName();
								studentInfo.setStudentDistrict(disti);
							 }
								
							
							
						}
						
							
						}
						request.setAttribute("students", myStudent);
						
					
						
			// score/results
			enrollment.setRegNO(request.getParameter("regno"));
			enrollment.setYearName(request.getParameter("yearname"));
			myEnrollment=enrollmentMan.searchEnrollmentByYear(enrollment);
			request.setAttribute("enrollment", myEnrollment);
			for (Iterator iterator = myEnrollment.iterator(); iterator.hasNext();) {
				enrollment = (Enrollment) iterator.next();
				
				Marks marks=new Marks();
				MarksManager marksMan=new MarksManager();
				ArrayList<Marks> myMarks=new ArrayList<Marks>();
				marks.setRegNO(request.getParameter("regno"));
				marks.setEnrollmentID(enrollment.getEnrollmentID());
				marks.setSession(request.getParameter("sessions"));
				myMarks=marksMan.selectMarksByEnrollment(marks);
				request.setAttribute("marks", myMarks);
				float maxTotal=0,markTotal=0,maxQuizTotal=0,maxExamTotal=0,markQuizTotal=0,markExamTotal=0;
				
				for (Iterator iterator2 = myMarks.iterator(); iterator2
						.hasNext();) {
					marks = (Marks) iterator2.next();
					String sessionName=marks.getSession();
					String sessionID=request.getParameter("sessions");
					request.setAttribute("sessionName", sessionName);
					request.setAttribute("sessionID", sessionID);
					
					maxTotal=maxTotal+marks.getMaxScore();
					maxQuizTotal=maxQuizTotal+marks.getMaxScore()/2;
					maxExamTotal=maxExamTotal+marks.getMaxScore()/2;
					markQuizTotal=markQuizTotal+marks.getMarkQuiz();
					markExamTotal=markExamTotal+marks.getMarkExam();

				}
				markTotal=markQuizTotal+markExamTotal;
				if(maxTotal!=0){
					float percentage=(new BigDecimal( markTotal*100/maxTotal).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
					request.setAttribute("percentage", percentage);
				}
				
				request.setAttribute("maxTotal", maxTotal);
				request.setAttribute("maxQuizTotal", maxQuizTotal);
				request.setAttribute("maxExamTotal", maxExamTotal);
				request.setAttribute("markQuizTotal", markQuizTotal);
				request.setAttribute("markExamTotal", markExamTotal);
				request.setAttribute("markTotal", markTotal);
				
				
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
				for (Iterator iterator2 = myAttendance.iterator(); iterator2
						.hasNext();) {
					attendance = (Attendance) iterator2.next();
					totalAttendance=totalAttendance+attendance.getMaxAttendance();
					totalAbscence=totalAbscence+attendance.getAbscences();
					totalExecusedAbscence=totalExecusedAbscence+attendance.getExecusedAbscences();
					if(attendance.getMaxAttendance()!=0){
						percentageCourseAttendance=(new BigDecimal((attendance.getMaxAttendance()-(attendance.getAbscences()+attendance.getExecusedAbscences()))*100/attendance.getMaxAttendance()).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
					}
				}
				totalCourseAttendance=totalAttendance-(totalAbscence+totalExecusedAbscence);
				if(totalAttendance!=0){
					percentageAttendance=(new BigDecimal( totalCourseAttendance*100/totalAttendance).setScale(2,BigDecimal.ROUND_CEILING).floatValue());
					request.setAttribute("percentageAttendance", percentageAttendance);
					}
				
				request.setAttribute("percentageCourseAttendance", percentageCourseAttendance);
				request.setAttribute("totalAttendance", totalAttendance);
				request.setAttribute("totalAbscence", totalAbscence);
				request.setAttribute("totalExecusedAbscence", totalExecusedAbscence);
				request.setAttribute("totalCourseAttendance", totalCourseAttendance);
				
				Discipline discipline=new Discipline();
				DisciplineManager disciplineMan=new DisciplineManager();
				ArrayList<Discipline> myDiscipline=new ArrayList<Discipline>();
				discipline.setRegNO(request.getParameter("regno"));
				discipline.setEnrollmentID(enrollment.getEnrollmentID());
				discipline.setSession(request.getParameter("sessions"));
				myDiscipline=disciplineMan.selectDisciplineByEnrollment(discipline);
				request.setAttribute("discipline", myDiscipline);
				
				
			}
			
		}
		
		request.getRequestDispatcher("/modules/analysis/analysis.jsp").forward(request,response);
		
	}else if(direction.equals("alert")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectAcadYears();
		request.setAttribute("years", myAcadeYear);
		ArrayList<Sessions> mySessions=new ArrayList<Sessions>();
		Sessions sessions=new Sessions();
		SessionsManager sessionsMan=new SessionsManager();
		mySessions=sessionsMan.selectSessions();
		request.setAttribute("sessions", mySessions);
		
		Discipline discipline=new Discipline();
		DisciplineManager disciplineMan=new DisciplineManager();
		ArrayList<Discipline> myDiscipline=new ArrayList<Discipline>();
		
		if(request.getParameter("edit").equals("UseProfile")){
			
			discipline.setDisciplineID(Integer.parseInt(request.getParameter("discipline")));
			myDiscipline=disciplineMan.searchDiscipline(discipline);
			for (Iterator iterator = myDiscipline.iterator(); iterator
			.hasNext();) {
		discipline = (Discipline) iterator.next();
		
		Student student=new Student();
		student.setStudentRegNO(discipline.getRegNO());
		StudentInfoManager studentMan=new StudentInfoManager();
		ArrayList<Student> myStudent=new ArrayList<Student>();
		myStudent=studentMan.searchStudentInfos(student);
		for (Iterator iterator2 = myStudent.iterator(); iterator2
				.hasNext();) {
			student = (Student) iterator2.next();
			
			String guardianPhoneNO=student.getGuardianPhoneNO();
			request.setAttribute("guardianPhoneNO", guardianPhoneNO);
			
			
		}
		
		
		
	}
			request.setAttribute("disciplineToUpdate", myDiscipline);
			
			}else if(request.getParameter("edit").equals("all")){
			
			//paging purposes	
			  int recordCount=disciplineMan.countDiscpline();
			  int pagerows=10;
			double lastpage=Math.ceil((double)recordCount/(double)pagerows);
			if(pagenum<1){pagenum=1;
			}else if(pagenum>(int)lastpage){
				pagenum=(int)lastpage;
			}
			if(request.getParameter("pagenum")==null){
				
				pagenum=1;
			}else{
				pagenum=Integer.parseInt(request.getParameter("pagenum"));
			}
			//end of paging purposes
			if(request.getParameter("FilterDiscipline")!=null){
				discipline.setRegNO(request.getParameter("filter_regNO"));
				myDiscipline=disciplineMan.filterDiscipline(discipline, pagenum, pagerows);
				
							
			    request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("disciplines", myDiscipline);
			
				
			}else{
				myDiscipline=disciplineMan.selectDiscipline(pagenum, pagerows);
				
				
				request.setAttribute("pagenum", pagenum);
			    request.setAttribute("lastpage", (int)lastpage);
			   
				request.setAttribute("disciplines", myDiscipline);
			}
		
			}
		request.getRequestDispatcher("/modules/communication/alert.jsp").forward(request,
				response);
		
		
	}else if(direction.equals("classlist")&& request.getSession().getAttribute("myLoggedUser")!=null){
		
		ArrayList<AcademicYear> myAcadeYear=new ArrayList<AcademicYear>();
		AcademicYear acadeYear=new AcademicYear();
		AcademicYearManager acadeYearMan=new AcademicYearManager();
		myAcadeYear=acadeYearMan.selectAcadYears();
		request.setAttribute("years", myAcadeYear);
		
		ArrayList<Classroom> myClass=new ArrayList<Classroom>();
		Classroom classroom=new Classroom();
		ClassroomManager classroomMan = new ClassroomManager();
		myClass=classroomMan.selectClasses();
		request.setAttribute("classes", myClass);
		
		if(request.getParameter("classi")!=null && request.getParameter("yearname")!=null){
			
			ArrayList<Enrollment> myClassEnrollment=new ArrayList<Enrollment>();
			Enrollment enrollment=new Enrollment();
			EnrollmentManager enrollmentMan=new EnrollmentManager();
			
			enrollment.setClassCode(request.getParameter("classi"));
			enrollment.setYearName(request.getParameter("yearname"));
			
			myClassEnrollment=enrollmentMan.selectClassList(enrollment);
			String classe="",acadeyear="",departement="";
			if(myClassEnrollment.isEmpty()){
				
				String errorMsg="No students available for your specification, for more info contact the Head of studies!";
				request.setAttribute("errorMsg", errorMsg);
			}
			for (Iterator iterator = myClassEnrollment.iterator(); iterator
					.hasNext();) {
			enrollment = (Enrollment) iterator.next();
			
			classe=enrollment.getClassCode();
			acadeyear=enrollment.getYearName();
			departement=enrollment.getDepartment();
				
			}
			request.setAttribute("classe", classe);
			request.setAttribute("acadeyear", acadeyear);
			request.setAttribute("departement", departement);
			request.setAttribute("ClassList", myClassEnrollment);
			
		}
		
		
		request.getRequestDispatcher("/modules/communication/classlist.jsp").forward(request,
				response);
		
	}else{
		
		welcome="Error occured session could not be established";
		session.setAttribute("welcome", welcome);
		session.removeAttribute("myLoggedUser");
		request.getRequestDispatcher("/index.jsp").forward(request,
				response);
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
