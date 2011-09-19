package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import manager.RoleManager;
import manager.UserManager;
import domain.Role;
import domain.User;

/**
 * Servlet implementation class UserController
 */
public class AccessController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccessController() {
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
		ArrayList<User> myUser=new ArrayList<User>();
		myUser=userMan.selectUsers(pagenum,pagerows);
		
		RoleManager roleMan=new RoleManager();
		ArrayList<Role> myRole=new ArrayList<Role>();
		myRole=roleMan.selectRoles();
		
			if(request.getParameter("username") != null) {
			
			user.setUserName(request.getParameter("username"));
			user.setPassword(request.getParameter("new_pass"));
			user.setFullName(request.getParameter("fullname"));
			user.setEmail(request.getParameter("email"));
			user.setRole(request.getParameter("role_id"));
			user.setPhoneNumber(request.getParameter("phonenumber"));
			
			success=userMan.addUser(user);	
					
		}else if(request.getParameter("UserChange") != null){
			
			user.setUserID(Integer.parseInt(request.getParameter("userid")));
			String commit[]=request.getParameterValues("commPass");
			if(commit!=null){
				user.setPassword(request.getParameter("new_pass"));
				for(int i=0;i<commit.length;i++){
					System.out.println(commit[i]);
				}
			}
		user.setFullName(request.getParameter("fullname"));
		user.setEmail(request.getParameter("email"));
		user.setRole(request.getParameter("role_id"));
		user.setPhoneNumber(request.getParameter("phonenumber"));
		success=userMan.updateUser(user);
		
			
		}else if(request.getParameter("UseDelete")!=null){
			
			user.setUserID(Integer.parseInt(request.getParameter("UseDelete")));
			success=userMan.deleteUser(user);
			
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
