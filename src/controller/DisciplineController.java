package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.DisciplineManager;
import domain.Discipline;

/**
 * Servlet implementation class DisciplineController
 */
public class DisciplineController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisciplineController() {
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
		Discipline discipline=new Discipline();
		DisciplineManager disciplineMan=new DisciplineManager();
		
		if(request.getParameter("enrollment")!=null  && request.getParameter("sessions")!=null){
			
			discipline.setEnrollmentID(Integer.parseInt(request.getParameter("enrollment")));
			//discipline.setYearName(request.getParameter("yearname"));
			discipline.setSession(request.getParameter("sessions"));
			discipline.setOffenseType(request.getParameter("offensetype"));
			discipline.setOffenseOccurence(request.getParameter("offenseoccurence"));
			discipline.setOffenseLocation(request.getParameter("offenselocation"));
			discipline.setDisciplinaryAction(request.getParameter("disciplinaryaction"));
			
			success=disciplineMan.addDiscipline(discipline);
			
		}else if(request.getParameter("DisciplineChange")!=null){
			
			discipline.setDisciplineID(Integer.parseInt(request.getParameter("disciplineid")));
			discipline.setSession(request.getParameter("sessions"));
			discipline.setOffenseType(request.getParameter("offensetype"));
			discipline.setOffenseOccurence(request.getParameter("offenseoccurence"));
			discipline.setOffenseLocation(request.getParameter("offenselocation"));
			discipline.setDisciplinaryAction(request.getParameter("disciplinaryaction"));
			
			success=disciplineMan.updateDiscipline(discipline);
			
		}else if(request.getParameter("UseDelete")!=null){
			
			discipline.setDisciplineID(Integer.parseInt(request.getParameter("UseDelete")));
			success=disciplineMan.deleteDiscipline(discipline);
			
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
