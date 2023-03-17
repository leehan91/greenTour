package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminLoginDao {
	private static AdminLoginDao adminLoginDao;
	private Connection conn;
	private AdminLoginDao() { }
	
	public static AdminLoginDao getInstance() {
		
		if(adminLoginDao == null) adminLoginDao = new AdminLoginDao(); 
		return adminLoginDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public AdminInfo getLoginInfo(String uid, String pwd) {
		Statement stmt = null;
		ResultSet rs = null;
		AdminInfo adminInfo = null;
		
		try {
			String sql = "select * from t_admin_info where ai_id = '"+ uid +"' and ai_pw = '"+ pwd +"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				adminInfo = new AdminInfo();
				adminInfo.setAi_id(uid);
				adminInfo.setAi_pw(pwd);
				adminInfo.setAi_name("ai_name");
				adminInfo.setAi_use("ai_use");
				adminInfo.setAi_date("ai_date");
			}
			
		} catch(Exception e) {
			System.out.println("AdminLoginDao 클래스의 getLoginInfo() 메소드 오류발생");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return adminInfo;
	}
}
