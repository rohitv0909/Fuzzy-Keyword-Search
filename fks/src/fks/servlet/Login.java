package fks.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fks.servlet.AES;
import fks.dbtasks.CrudOperation;
/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection cn;
    private PreparedStatement pslogin;
    private ResultSet rslogin;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String id=request.getParameter("txtuserid").trim();
		String pass=request.getParameter("txtuserpass");
		cn=CrudOperation.createConnection();
		String strsql="select * from logininfo where userid=?";
		try
		{
			pslogin=cn.prepareStatement(strsql);
			pslogin.setString(1, id);
			rslogin=pslogin.executeQuery();
			if(rslogin.next())
			{
				String enpass=rslogin.getString("userpass");
				final String secretKey = "ssshhhhhhhhhhh!!!!";
		        String depass = AES.decrypt(enpass, secretKey);
		        if(depass.equals(pass))
		        {
		        	HttpSession hs=request.getSession(); //create new session
		        	String utype=rslogin.getString("role");
		        	String umail=rslogin.getString("email");
		        	hs.setAttribute("userid", id);
		        	hs.setAttribute("userpass", utype);
		        	hs.setAttribute("usermail", umail);
		        	if(utype.equalsIgnoreCase("dataowner"))
		        	{
		        		String key=rslogin.getString("key");
		        		hs.setAttribute("userkey", key);
		        		response.sendRedirect("/fks/dataowner_home.jsp");
		        	}
		        	else if(utype.equalsIgnoreCase("user"))
		        		response.sendRedirect("/fks/user_home.jsp");
		        	else if(utype.equalsIgnoreCase("cloudadmin"))
		        		response.sendRedirect("/fks/cloud_home.jsp");
		        }
		        else
		        {
		        	request.setAttribute("msg", "Invalid Password");
					RequestDispatcher rd=request.getRequestDispatcher("/login.jsp");
					rd.forward(request, response);
		        }
			}
			else
			{
				request.setAttribute("msg", "Invalid UserID or Password");
				RequestDispatcher rd=request.getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
			}
		}
		catch(SQLException se)
		{
			System.out.println(se);
		}
		
		
	}

}
/*<display-name>FileUploadServletExample</display-name>
<servlet>
  <display-name>FileUpload</display-name>
  <servlet-name>FileUpload</servlet-name>
  <servlet-class>fks.servlet.FileUpload</servlet-class>
</servlet>
<servlet-mapping>
  <servlet-name>FileUpload</servlet-name>
  <url-pattern>/uploadFile</url-pattern>
</servlet-mapping>*/

