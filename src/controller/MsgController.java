package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.SMSManager;

import domain.SMS;
import domain.User;

/**
 * Servlet implementation class MsgController
 */
public class MsgController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MsgController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String success="";
		
		SMS sms=new SMS();
		SMSManager smsMan=new SMSManager();
		ArrayList<SMS> myUser=new ArrayList<SMS>();
		
		if(request.getParameter("to") != null && request.getParameter("msg") != null ) {
			
			sms.setSmsSender("+250788660270");
			sms.setSmsReceiver(request.getParameter("to"));
			sms.setSmsMessage(request.getParameter("msg"));
			sms.setSmsStatus("send");
			
			success=smsMan.addSMS(sms);
			
		}else if(request.getParameter("Resend") != null  ) {
			
			sms.setSmsID(Integer.parseInt(request.getParameter("smsid")));
			sms.setSmsReceiver(request.getParameter("to"));
			sms.setSmsMessage(request.getParameter("msg"));
			sms.setSmsStatus("send");
			
			success=smsMan.updateSMS(sms);
			
			
		}else if(request.getParameter("smsDelete")!=null){
			
			sms.setSmsID(Integer.parseInt(request.getParameter("smsDelete")));
			success=smsMan.deleteSMS(sms);
			
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
