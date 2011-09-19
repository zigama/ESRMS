package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.SectorManager;

import domain.Sector;

/**
 * Servlet implementation class SearchSector
 */
public class SearchSector extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchSector() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Sector sector=new Sector();
		SectorManager sectorMan=new SectorManager();
		
		if(request.getParameter("distid")!=null){
			
			response.setContentType("text/xml");
			String optionSelected = request.getParameter("selcountry");        
			ArrayList<Sector> mySectors=new ArrayList<Sector>();
			
			int distid=Integer.parseInt(request.getParameter("distid")) ;
			
			//Build the response text
			String responseText = "";
			 
			 mySectors=sectorMan.selectSectors(distid);
			 for(int i=0;i<mySectors.size();i++)
	         {
	            Sector temp = (Sector)mySectors.get(i);
	            
	                    responseText = temp.getSectorName()+";"+temp.getSectorID()+"||"+responseText; 
	            
	         }
	         if(responseText.endsWith("||"))   //chop off the ending ||
	         {
	             responseText = responseText.substring(0, responseText.lastIndexOf("||"));
	         }

	         PrintWriter out = response.getWriter();
	         out.println("Select Sector ||"+responseText);
	        //Close the writer
	        out.close();

	         
			 //request.getRequestDispatcher("/modules/personinfo/searchsector.jsp").forward(request,response);
			 
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
