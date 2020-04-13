package fks.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Random;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import fks.dbtasks.CrudOperation;
import fks.servlet.EmailUtility;

import java.sql.*;
/**
 * Servlet implementation class PatientRegistration
 */
@WebServlet("/Reg")
public class Reg extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection cn;
	private PreparedStatement ps1;
	private String host;
	private String port;
	private String user;
	private String pass;

	public void init() {
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		port = context.getInitParameter("port");
		user = context.getInitParameter("user");
		pass = context.getInitParameter("pass");
	}
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Reg() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public static String getAlphaNumericString(int n) 
    { 
        byte[] array = new byte[256]; 
        new Random().nextBytes(array); 
  
        String randomString 
            = new String(array, Charset.forName("UTF-8")); 
  
        StringBuffer r = new StringBuffer(); 
  
        for (int k = 0; k < randomString.length(); k++) { 
  
            char ch = randomString.charAt(k); 
  
            if (((ch >= 'a' && ch <= 'z') 
                 || (ch >= 'A' && ch <= 'Z') 
                 || (ch >= '0' && ch <= '9')) 
                && (n > 0)) { 
  
                r.append(ch); 
                n--; 
            } 
        } 
        return r.toString(); 
    } 
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		request.getParameter("text/html");
		PrintWriter out=response.getWriter();
		String id=request.getParameter("txtuserid");
		String ps=request.getParameter("pass");
		String name=request.getParameter("txtusername");
		String mail=request.getParameter("txtmail");
		String role=request.getParameter("role");
		
		final String secretKey = "ssshhhhhhhhhhh!!!!";
		
		String enpass = AES.encrypt(ps, secretKey) ;
		String enname = AES.encrypt(name, secretKey) ;
		String enmail = AES.encrypt(mail, secretKey) ;
		String resultMessage = "";
		//System.out.println(id);
		//System.out.println(enpass);
		
		try {
			cn=CrudOperation.createConnection();
			cn.setAutoCommit(false);
			String login="insert into logininfo values(?,?,?,?,?,?)";
			ps1=cn.prepareStatement(login);
			ps1.setString(1,id);
			ps1.setString(2,enpass);
			ps1.setString(3,enname);
			ps1.setString(4,enmail);
			ps1.setString(5,role);
			if(role.equalsIgnoreCase("user"))
				ps1.setString(6,null);
			else
				ps1.setString(6,getAlphaNumericString(16));
			int rw = ps1.executeUpdate();
			if (rw > 0) 
	        {
	        	cn.commit();
	    		EmailUtility.sendEmail(host, port, user, pass, mail, "Welcome to our platform as a "+role,
	    				"Hi, "+name+"\nYour User ID: "+id+"\nYour password: "+ps);
	    		resultMessage = "Registration successful, you will receive an e-mail shortly.";
	        }
		}
		catch (SQLException se) 
		{
			System.out.println(se);
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
			resultMessage = "There were an error: " + ex.getMessage();
		}
		finally 
		{
			request.setAttribute("Message", resultMessage);
			getServletContext().getRequestDispatcher("/Result.jsp").forward(
					request, response);
		}
		
	}

}
