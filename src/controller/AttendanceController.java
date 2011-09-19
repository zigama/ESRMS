package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.AttendanceManager;
import domain.Attendance;
import domain.Marks;

/**
 * Servlet implementation class AttendanceController
 */
public class AttendanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AttendanceController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String success="";
		int pagenum=0,pagerows=0;
		Attendance attendance=new Attendance();
		AttendanceManager attendanceMan=new AttendanceManager();
if(request.getParameter("enrollment")!=null && request.getParameter("course")!=null && request.getParameter("sessions")!=null){
			
			attendance.setEnrollmentID(Integer.parseInt(request.getParameter("enrollment")));
			attendance.setYearName(request.getParameter("yearname"));
			attendance.setCourse(request.getParameter("course"));
			attendance.setSession(request.getParameter("sessions"));
			String execused[]=request.getParameterValues("execused");
			if(execused==null){
			attendance.setAbscences(Integer.parseInt(request.getParameter("abscence")));
			attendance.setExecusedAbscences(0);
			}else{
				attendance.setAbscences(0);
			attendance.setExecusedAbscences(Integer.parseInt(request.getParameter("abscence")));
			}
			attendance.setMaxAttendance(Integer.parseInt(request.getParameter("maxattendance")));
			
			ArrayList<Attendance> existAttendance=new ArrayList<Attendance>();
			existAttendance=attendanceMan.checkAttendance(attendance);
			if(existAttendance.isEmpty()){
			success=attendanceMan.addAttendance(attendance);
			}else{
				for (Iterator iterator = existAttendance.iterator(); iterator
						.hasNext();) {
					attendance = (Attendance) iterator.next();
					 
					 success="Student attendance for this course for this session period and academic year already exist, please update";
					
					
				}
			}
		}else if(request.getParameter("AttendanceChange")!=null){
			
			attendance.setAttendanceID(Integer.parseInt(request.getParameter("attendanceid")));
			attendance.setSession(request.getParameter("sessions"));
			attendance.setCourse(request.getParameter("course"));
			
			attendance.setAbscences(Integer.parseInt(request.getParameter("abscence")));
			
			attendance.setExecusedAbscences(Integer.parseInt(request.getParameter("execusedabscence")));
			
			attendance.setMaxAttendance(Integer.parseInt(request.getParameter("maxattendance")));
			
			success=attendanceMan.updateAttendance(attendance);
			
		}else if(request.getParameter("UseDelete")!=null){
			
			attendance.setAttendanceID(Integer.parseInt(request.getParameter("UseDelete")));
			success=attendanceMan.deleteAttendance(attendance);
		}
		
		request.setAttribute("success", success);
		request.getRequestDispatcher("/index.htm").forward(request,
				response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
