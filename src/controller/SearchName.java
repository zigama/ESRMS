package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.StudentInfoManager;
import domain.Sector;
import domain.Student;

/**
 * Servlet implementation class SearchName
 */
public class SearchName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchName() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Student> myStudent=new ArrayList<Student>();
		Student studentInfo=new Student();
		StudentInfoManager studentInfoMan = new StudentInfoManager();
		if(request.getParameter("regno")!=null){
			response.setContentType("text/xml");
			//Build the response text
			String responseText = "";
			studentInfo.setStudentRegNO(request.getParameter("regno"));
			myStudent=studentInfoMan.searchStudentInfos(studentInfo);
			
			for (int i = 0; i < myStudent.size(); i++) {
				
				 Student temp = (Student)myStudent.get(i);
		            
                 responseText = temp.getStudentLastName()+" "+temp.getStudentFirstName()+";"+temp.getStudentRegNO()+"||"+responseText; 
         System.out.println(responseText);
				
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
