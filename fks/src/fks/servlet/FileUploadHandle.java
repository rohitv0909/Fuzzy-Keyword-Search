package fks.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import fks.servlet.AES;
import fks.dbtasks.CrudOperation;
import java.sql.*;
/**
 * Servlet implementation class FileUploadHandle
 */
@WebServlet("/FileUploadHandle")
public class FileUploadHandle extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con;
	private PreparedStatement ps;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadHandle() {
        super();
        // TODO Auto-generated constructor stub
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String file_name = null;
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
        if (!isMultipartContent) {
            return;
        }
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            List < FileItem > fields = upload.parseRequest(request);
            Iterator < FileItem > it = fields.iterator();
            if (!it.hasNext()) {
                return;
            }
            while (it.hasNext()) {
                FileItem fileItem = it.next();
                boolean isFormField = fileItem.isFormField();
                if (isFormField) {
                    if (file_name == null) {
                        if (fileItem.getFieldName().equals("txtfilename")) {
                        	file_name = fileItem.getString();
                        }
                    }
                } else {
                    if (fileItem.getSize() > 0) {
                    	HttpSession hs = request.getSession(false);
                		String uid = (String) hs.getAttribute("userid");
                		String key = (String) hs.getAttribute("userkey");
                    	String query="insert into document values(?,?,?,?)";

						try {
							String enfname = AES.encrypt(fileItem.getName(), key) ;
							//System.out.println(enfname);
							String enfpath = AES.encrypt("E:\\upload\\"+fileItem.getName(), key) ;
							//System.out.println(enfpath);
							con = CrudOperation.createConnection();
							ps = con.prepareStatement(query);
							ps.setString(1,uid);
							ps.setString(2,enfname);
							ps.setString(3,enfpath);
							ps.setString(4,key);
							//System.out.println(ps);
							fileItem.write(new File("E:\\upload\\" + fileItem.getName()));
							File inputFile = new File("E:\\upload\\" + fileItem.getName());
							File encryptedFile = new File("E:\\upload\\" + enfname);							
							
							try 
							{
								CryptoUtils.encrypt(key, inputFile, encryptedFile);
								inputFile.delete();
							}
							catch (CryptoException ex) {
								System.out.println(ex.getMessage());
								ex.printStackTrace();
							}
							
							int rw = ps.executeUpdate();
							if (rw > 0) 
							{
								System.out.println("Document(s) successfully uploaded.");
							}
							
						} catch (SQLException se) {

							System.out.println(se);
						}
                    	
                         
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.println("<script type='text/javascript'>");
            out.println("window.location.href='docupload.jsp?filename="+file_name+"'");
            out.println("</script>");
            out.close();
        }
	}

}
