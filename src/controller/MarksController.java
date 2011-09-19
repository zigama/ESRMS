package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.MarksManager;

import domain.Marks;

/**
 * Servlet implementation class MarksController
 */
public class MarksController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarksController() {
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
		Marks marks=new Marks();
		MarksManager marksMan=new MarksManager();
		
		if(request.getParameter("enrollment")!=null && request.getParameter("course")!=null && request.getParameter("sessions")!=null){
			
			marks.setEnrollmentID(Integer.parseInt(request.getParameter("enrollment")));
			marks.setYearName(request.getParameter("yearname"));
			marks.setCourse(request.getParameter("course"));
			marks.setSession(request.getParameter("sessions"));
			marks.setMarkQuiz(Float.parseFloat(request.getParameter("markquiz")));
			marks.setMarkExam(Float.parseFloat(request.getParameter("markexam")));
			marks.setMaxScore(Float.parseFloat(request.getParameter("maxscore")));
			
			ArrayList<Marks> existMarks=new ArrayList<Marks>();
			existMarks=marksMan.checkMarks(marks);
			if(existMarks.isEmpty()){
			success=marksMan.addMarks(marks);
			}else{
				for (Iterator iterator = existMarks.iterator(); iterator
						.hasNext();) {
					 marks = (Marks) iterator.next();
					 
					 success="Student marks for this course for this session period and academic year already exist, please update";
					
					
				}
			}
		}else if(request.getParameter("ScoreChange")!=null){
			
			marks.setMarkID(Integer.parseInt(request.getParameter("markid")));
			marks.setSession(request.getParameter("sessions"));
			marks.setCourse(request.getParameter("course"));
			marks.setMarkQuiz(Float.parseFloat(request.getParameter("markquiz")));
			marks.setMarkExam(Float.parseFloat(request.getParameter("markexam")));
			marks.setMaxScore(Float.parseFloat(request.getParameter("maxscore")));
			
			success=marksMan.updateMarks(marks);
			
		}else if(request.getParameter("UseDelete")!=null){
			
			marks.setMarkID(Integer.parseInt(request.getParameter("UseDelete")));
			success=marksMan.deleteMarks(marks);
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
