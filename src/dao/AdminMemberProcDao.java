package dao;

import java.sql.Connection;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;


public class AdminMemberProcDao {
	private static AdminMemberProcDao adminMemberProcDao;
	private Connection conn;
	private AdminMemberProcDao() {}
	
	public static AdminMemberProcDao getInstance() {
		
		if (adminMemberProcDao == null)	adminMemberProcDao = new AdminMemberProcDao();
		
		return adminMemberProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memReserveUP(String miid, String code) {
		System.out.println(code);
		Statement stmt = null;
		int result = 0;
		try {
			String sql = "update t_order_painfo set op_status = 'd' where mi_id = '" + miid + 
					"' and op_code = '" + code + "'";
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		}catch (Exception e) {
			System.out.println("AdminMemberProcDao 클래스의 memReserveUP() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	
		}
		return result;
	}
	public int memberUp(String miid, String memStatus) {
		Statement stmt = null;
		int result = 0;
		try {
			String sql = "update t_member_info set mi_status = '" + memStatus + 
					"' where mi_id = '" + miid + "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		}catch (Exception e) {
			System.out.println("AdminMemberProcDao 클래스의 memberUp() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	
		}
		return result;
	}
}
