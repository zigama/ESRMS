package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.EnrollmentManager;

import domain.Enrollment;

/**
 * Servlet implementation class SearchEnrollment
 */
public class SearchEnrollment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchEnrollment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ArrayList<Enrollment> myEnrollment=new ArrayList<Enrollment>();
		Enrollment enrollment=new Enrollment();
		EnrollmentManager enrollmentMan=new EnrollmentManager();
		
		if(request.getParameter("year")!=null && request.getParameter("regno")!=null){
			response.setContentType("text/xml");
			//Build the response text
			String responseText = "";
			
			enrollment.setYearName(request.getParameter("year"));
			enrollment.setRegNO(request.getParameter("regno"));
			
			myEnrollment=enrollmentMan.searchEnrollmentByYear(enrollment);
			for (int i = 0; i < myEnrollment.size(); i++) {
				
				Enrollment temp=(Enrollment)myEnrollment.get(i);
				
				 responseText=temp.getEnrollmentID()+";"+temp.getRegNO()+";"+temp.getClassCode()+";"+temp.getYearName()+";"+temp.getDepartment()+";"+temp.getFullname()+"||"+responseText;
			}
			if(responseText.endsWith("||"))   //chop off the ending ||
	         {
	             responseText = responseText.substring(0, responseText.lastIndexOf("||"));
	         }
			PrintWriter out = response.getWriter();
	         out.println(responseText);
	        //Close the writer
	        out.close();

				
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
