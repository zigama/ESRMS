package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.ClassroomManager;
import manager.StudentInfoManager;
import domain.Classroom;
import domain.Department;
import domain.Student;

/**
 * Servlet implementation class SearchDepartment
 */
public class SearchDepartment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchDepartment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Classroom> myClass=new ArrayList<Classroom>();
		Classroom classroom=new Classroom();
		ClassroomManager classroomMan = new ClassroomManager();
		if(request.getParameter("class")!=null){
			response.setContentType("text/xml");
			//Build the response text
			String responseText = "";
			myClass=classroomMan.selectClass(request.getParameter("class"));
			
			for (int i = 0; i < myClass.size(); i++) {
				
				 Classroom temp = (Classroom)myClass.get(i);
				 
		          
                 responseText = temp.getClassID()+";"+temp.getClassCode()+";"+temp.getDepartmentID()+";"+temp.getDepartmentName()+";"+temp.getDepartmentShortName()+";"+"||"+responseText; 
         
		         		
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
