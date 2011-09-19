package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.SMSManager;
import manager.StudentInfoManager;
import manager.UserManager;
import domain.SMS;
import domain.Student;
import domain.User;

/**
 * Servlet implementation class StudentInfoController
 */
public class StudentInfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentInfoController() {
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
		User user = new User();
		UserManager userMan = new UserManager();
		
		Student studentInfo=new Student();
		StudentInfoManager studentInfoMan=new StudentInfoManager();
		
		SMS sms=new SMS();
		SMSManager smsMan=new SMSManager();
		
		
		if(request.getParameter("regno")!=null){
			
			studentInfo.setStudentFirstName(request.getParameter("firstname"));
			studentInfo.setStudentLastName(request.getParameter("lastname"));
			studentInfo.setStudentRegNO(request.getParameter("regno"));
			studentInfo.setFatherName(request.getParameter("fathername"));
			studentInfo.setMotherName(request.getParameter("mothername"));
			studentInfo.setStudentSex(request.getParameter("sex"));
			studentInfo.setStudentBirthdate(request.getParameter("birthdate"));
			studentInfo.setStudentCitizenship(request.getParameter("citizenship"));
			studentInfo.setStudentDistrict(request.getParameter("district"));
			studentInfo.setStudentSector(request.getParameter("sector"));
			studentInfo.setStudentCellule(request.getParameter("cellule"));
			studentInfo.setStudentVillage(request.getParameter("village"));
			studentInfo.setGuardianName(request.getParameter("guardianname"));
			studentInfo.setStudentGuardianID(request.getParameter("guardiannatid"));
			studentInfo.setGuardianPhoneNO(request.getParameter("guardianphone"));
			studentInfo.setGuardianRelationship(request.getParameter("guardianrel"));
			studentInfo.setStudentUserName(request.getParameter("username"));
			
			success=studentInfoMan.addStudentInfos(studentInfo);
			
			user.setUserName(request.getParameter("username"));
			user.setPassword(request.getParameter("new_pass"));
			user.setFullName(request.getParameter("firstname")+" "+request.getParameter("lastname"));
			user.setEmail("");
			user.setRole("7");
			user.setPhoneNumber(request.getParameter("guardianphone"));
			
			success=success+" and "+userMan.addUser(user);	
			
			sms.setSmsSender("+250788660270");
			sms.setSmsReceiver(request.getParameter("guardianphone"));
			sms.setSmsMessage("The username: "+request.getParameter("username")+" and password: "+request.getParameter("new_pass")+" should be used, and can be changed after you log in to access information of "+user.getFullName());
			sms.setSmsStatus("send");
			
			success=success+" and "+smsMan.addSMS(sms);
			
			
		}else if(request.getParameter("StudentChange")!=null){
			
			studentInfo.setStudentFirstName(request.getParameter("firstname"));
			studentInfo.setStudentLastName(request.getParameter("lastname"));
			studentInfo.setStudentRegNO(request.getParameter("regno_yenyewe"));
			studentInfo.setFatherName(request.getParameter("fathername"));
			studentInfo.setMotherName(request.getParameter("mothername"));
			studentInfo.setStudentSex(request.getParameter("sex"));
			studentInfo.setStudentBirthdate(request.getParameter("birthdate"));
			studentInfo.setStudentCitizenship(request.getParameter("citizenship"));
			studentInfo.setStudentDistrict(request.getParameter("district"));
			studentInfo.setStudentSector(request.getParameter("sector"));
			studentInfo.setStudentCellule(request.getParameter("cellule"));
			studentInfo.setStudentVillage(request.getParameter("village"));
			studentInfo.setGuardianName(request.getParameter("guardianname"));
			studentInfo.setStudentGuardianID(request.getParameter("guardiannatid"));
			studentInfo.setGuardianPhoneNO(request.getParameter("guardianphone"));
			studentInfo.setGuardianRelationship(request.getParameter("guardianrel"));
			studentInfo.setStudentUserName(request.getParameter("username"));
			
			success=studentInfoMan.updateStudentInfos(studentInfo);
			
			if(request.getParameter("new_pass")!=null && request.getParameter("verify_pass")!=null){
				
				user.setUserName(request.getParameter("username"));
				user.setPassword(request.getParameter("new_pass"));
				user.setFullName(request.getParameter("firstname")+" "+request.getParameter("lastname"));
				user.setEmail("");
				user.setRole("7");
				user.setPhoneNumber(request.getParameter("guardianphone"));
				success=success+" and "+userMan.updateUser(user);
				if(!(user.getPassword().equalsIgnoreCase(""))){
				sms.setSmsSender("+250788660270");
				sms.setSmsReceiver(request.getParameter("guardianphone"));
				sms.setSmsMessage("The username: "+request.getParameter("username")+" and password: "+request.getParameter("new_pass")+" should be used, and can be changed after you log in to access information of "+user.getFullName());
				sms.setSmsStatus("send");
				
				success=success+" and "+smsMan.addSMS(sms);
				}
			}
			
			
		}else if(request.getParameter("UseDelete")!=null){
			
			studentInfo.setStudentRegNO(request.getParameter("UseDelete"));
			success=studentInfoMan.deleteStudentInfos(studentInfo);
			
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
