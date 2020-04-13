package fks.servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import fks.dbtasks.CrudOperation;
import java.sql.*;
/**
 * Servlet implementation class PatientReport
 */
@WebServlet("/Document")
@MultipartConfig
public class Document extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private Connection cn,con;
	  private PreparedStatement ps;
    
    public Document() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String disk="E:\\upload\\";
		String file_name=null;
		try 
		{
			PrintWriter out=response.getWriter();
			response.setContentType("text/html;charset=UTF-8");

			HttpSession hs = request.getSession(false);
			String uid = (String) hs.getAttribute("userid");
			boolean isMultiPartContent=ServletFileUpload.isMultipartContent(request);
			if(!isMultiPartContent)
			{
				return;
			}
			ServletFileUpload sf=new ServletFileUpload(new DiskFileItemFactory());
			FileItemFactory factory=new DiskFileItemFactory();
			ServletFileUpload upload=new ServletFileUpload(factory);
			
			List<FileItem> fields=upload.parseRequest(request);
			Iterator<FileItem> it=fields.iterator();
			if(!it.hasNext()) {
				return;
			}
			while(it.hasNext())
			{
				FileItem fileItem=it.next();
				boolean isFormField=fileItem.isFormField();
				if(isFormField)
				{
					if(file_name==null) {
						if(fileItem.getFieldName().equals("file_name")) {
							file_name=fileItem.getString();
						}
					}
				}
				else {
					if(fileItem.getSize()>0) {
						String query="insert into document values(?,?,?)";

						try {
							con = CrudOperation.createConnection();
							ps = con.prepareStatement(query);
							ps=cn.prepareStatement(query);
							ps.setString(1,uid);
							ps.setString(2,fileItem.getName());
							ps.setString(3,disk+fileItem.getName());
							System.out.println(ps);
							int rw = ps.executeUpdate();
							if (rw > 0) 
							{
								fileItem.write(new File(disk+fileItem.getName()));
								System.out.println("Document(s) successfully uploaded");
								response.sendRedirect("/fks/jsp/docupload.jsp");
							}
						} catch (SQLException se) {

							System.out.println(se);
						}
						
					}
				}
				
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
		/*request.getParameter("text/html");
		PrintWriter out=response.getWriter();
		String userid=request.getParameter("txtuserid");
		String fname=request.getParameter("txtfilename");
		
		response.setContentType("text/html;charset=UTF-8");
		ServletContext sc = getServletContext();
		String path = sc.getRealPath("/");

		System.out.println(path);

		HttpSession hs = request.getSession(false);
		String u_id = (String) hs.getAttribute("userkey");

		String newpath = path + u_id;
		File f1 = new File(newpath);
		if (!f1.exists()) {

			f1.mkdir();
		}

		System.out.println("directorycreated");

		
		 * String description = request.getParameter("txtdesc");
		 * System.out.println(description);
		 

		final Part filePart = request.getPart("txtrep");//filecontrol
		final String fileName = getFileName(filePart);

		String query="insert into document values(?,?,?)";

		try {
			con = CrudOperation.createConnection();
			ps = con.prepareStatement(query);
			ps=cn.prepareStatement(query);
			ps.setString(1,userid);
			ps.setString(2,fname);
			ps.setString(3,fileName);
			System.out.println(ps);
			int rw = ps.executeUpdate();
			if (rw > 0) {

				System.out.println("Document Uploaded");
				response.sendRedirect("/fks/jsp/docupload.jsp");
			}

		} catch (SQLException se) {

			System.out.println(se);
		}

		System.out.println(fileName);

		OutputStream out = null;
		InputStream filecontent = null;
		final PrintWriter writer = response.getWriter();

		try {
			out = new FileOutputStream(new File(newpath + File.separator + fileName));
			filecontent = filePart.getInputStream();

			int read = 0;
			final byte[] bytes = new byte[1024];

			while ((read = filecontent.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			// writer.println("New file " + fileName + " created at " + newpath);

		} catch (FileNotFoundException fne) {

			writer.println("<br/> ERROR: " + fne.getMessage());

		} finally {
			if (out != null) {
				out.close();
			}
			if (filecontent != null) {
				filecontent.close();
			}
			if (writer != null) {
				writer.close();
			}
		}
	}

	private String getFileName(final Part part) {

		final String partHeader = part.getHeader("content-disposition");

		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}*/

		
		
		
	}


