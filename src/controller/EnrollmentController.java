package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.EnrollmentManager;

import domain.Enrollment;

/**
 * Servlet implementation class EnrollmentController
 */
public class EnrollmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollmentController() {
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
		
		Enrollment enrollment=new Enrollment();
		EnrollmentManager enrollmentMan=new EnrollmentManager();
		
		if(request.getParameter("regno")!=null && request.getParameter("classi")!=null){
			
			enrollment.setRegNO(request.getParameter("regno"));
			enrollment.setClassCode(request.getParameter("classi"));
			enrollment.setYearName(request.getParameter("yearname"));
			ArrayList<Enrollment> existEnrollment=new ArrayList<Enrollment>();
			
			existEnrollment=enrollmentMan.checkEnrollment(enrollment);
			if(existEnrollment.isEmpty()){
				
				success=enrollmentMan.addEnrollment(enrollment);
				
				
			}else{
				for (Iterator numberOfEnrollment = existEnrollment.iterator(); numberOfEnrollment
				.hasNext();) {
			enrollment = (Enrollment) numberOfEnrollment.next();
			
			success="Student "+enrollment.getRegNO()+" has currently enrolled in "+enrollment.getClassCode()+"";
			
		}
			}
			
		}else if(request.getParameter("EnrollmentChange")!=null){
			
			enrollment.setEnrollmentID(Integer.parseInt(request.getParameter("enrollmentid")));
			enrollment.setRegNO(request.getParameter("regno"));
			enrollment.setClassCode(request.getParameter("class"));
			enrollment.setYearName(request.getParameter("yearname"));
			
			success=enrollmentMan.updateEnrollment(enrollment);
			
		}else if(request.getParameter("UseDelete")!=null){
			
			enrollment.setEnrollmentID(Integer.parseInt(request.getParameter("UseDelete")));
			success=enrollmentMan.deleteEnrollment(enrollment);
			
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
