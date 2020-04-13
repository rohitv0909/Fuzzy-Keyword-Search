package fks.dbtasks;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;
public class CrudOperation 
{
	private static Connection cn;
	private static PreparedStatement ps;
	private static ResultSet rs;
	
	public static ResultSet fetchData(String sql,int id)
	{
		cn=createConnection();
		try
		{
			ps=cn.prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
		}
		catch(SQLException se)
		{
			System.out.println(se);
		}
		return rs;
	}
	
	public static ResultSet fetchData(String sql,String id)
	{
		cn=createConnection();
		try
		{
			ps=cn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
		}
		catch(SQLException se)
		{
			System.out.println(se);
		}
		return rs;
	}
	
	public static ResultSet fetchData(String sql)
	{
		cn=createConnection();
		try
		{
			ps=cn.prepareStatement(sql);
			rs=ps.executeQuery();
		}
		catch(SQLException se)
		{
			System.out.println(se);
		}
		return rs;
	}
	
	public static Connection createConnection()
	{
		ResourceBundle rb=ResourceBundle.getBundle("fks/dbinfo/database");
		String dbid=rb.getString("app.dbuserid");
		String dbpass=rb.getString("app.dbuserpass");
		String url=rb.getString("app.url");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");//factory method used to create obj of a class
			cn=DriverManager.getConnection(url,dbid,dbpass);
		}									//subprotocol ipaddress of machine port no
											//connection url or connection string
		catch(SQLException|ClassNotFoundException cse)
		{
			System.out.println(cse);
		}
		return cn;	
	}
}
