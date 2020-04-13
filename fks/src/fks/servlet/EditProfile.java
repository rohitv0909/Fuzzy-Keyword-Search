package fks.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fks.dbtasks.CrudOperation;
import fks.servlet.AES;
import java.sql.*;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection cn;
	private PreparedStatement ps;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		request.getParameter("text/html");
		HttpSession hs=request.getSession(false);
		String uid=(String)hs.getAttribute("userid");
		String upass=(String)hs.getAttribute("userpass");
		String role=(String)hs.getAttribute("role");
		String entpass=request.getParameter("pass");
		final String key="ssshhhhhhhhhhh!!!!";
		if(entpass.equals(upass))
		{
			String uname=request.getParameter("txtusername");
			String mail=request.getParameter("txtmail");
			try {
				cn=CrudOperation.createConnection();
				cn.setAutoCommit(false);
				String login="update logininfo set username=?, email=? where userid=?";
				ps=cn.prepareStatement(login);
				ps.setString(1,AES.encrypt(uname, key));
				ps.setString(2,AES.encrypt(mail, key));
				ps.setString(3,uid);
				int rw = ps.executeUpdate();
				if (rw > 0) 
		        {
		        	cn.commit();
		        	request.setAttribute("msg", "Profile updated successfully");
		        	if(role.equals("dataowner"))
		        	{
		        		RequestDispatcher rd=request.getRequestDispatcher("/doedit.jsp");
		        		rd.forward(request, response);
		        	}
		        	else
		        	{
		        		RequestDispatcher rd=request.getRequestDispatcher("/uedit.jsp");
		        		rd.forward(request, response);
		        	}
		        }
			}
			catch (SQLException se) 
			{
				System.out.println(se);
			}
		}
		else
		{
			request.setAttribute("msg", "Wrong Password");
			if(role.equals("dataowner"))
			{
				RequestDispatcher rd=request.getRequestDispatcher("/doedit.jsp");
				rd.forward(request, response);
			}
			else
			{
				RequestDispatcher rd=request.getRequestDispatcher("/uedit.jsp");
				rd.forward(request, response);
			}
		}
	}
}