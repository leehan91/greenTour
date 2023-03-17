package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminPackageDeleteDao {
	private static AdminPackageDeleteDao adminPackageDeleteDao;
	private Connection conn;
	private AdminPackageDeleteDao() {}
	
	public static AdminPackageDeleteDao getInstance() {
		
		if (adminPackageDeleteDao == null)	adminPackageDeleteDao = new AdminPackageDeleteDao();
		
		return adminPackageDeleteDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int deletePackage(String picode) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_package_info set pi_isview = 'n' where pi_code = '"+ picode +"'";
			stmt = conn.createStatement();
			System.out.println("��������" + sql);
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
	           System.out.println("AdminPackageDeleteDao Ŭ������ deletePackage() �޼ҵ� ����");
	    } finally {
	    	close(stmt);  
	    }
		
		return result;
	}
}
