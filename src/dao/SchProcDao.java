package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class SchProcDao {
	private static SchProcDao schIdProcDao;
	private Connection conn;
	private SchProcDao() { }
	public static SchProcDao getInstance() {
		if(schIdProcDao == null) schIdProcDao = new SchProcDao();
		return schIdProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public MemberInfo getSchId(String name, String regist) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo mi = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select mi_id from t_member_info where mi_name = '"+ name +"' and mi_registration = '"+ regist +"'";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
			}
		}catch(Exception e) {
			System.out.println("SchIdProcDao 클래스에서 getSchId() 메소드 에러 발생");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return mi;
	}
	
	public MemberInfo getSchPw(String uid, String name, String regist) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo mi = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select mi_pw from t_member_info where mi_id = '"+ uid +"' and mi_name = '"+ name +"' and mi_registration = '"+ regist +"'";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				mi = new MemberInfo();
				mi.setMi_pw(rs.getString("mi_pw"));
			}
		}catch(Exception e) {
			System.out.println("SchIdProcDao 클래스에서 getSchPw() 메소드 에러 발생");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return mi;
	}
}
