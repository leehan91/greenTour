package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class SchIdProcDao {
	private static SchIdProcDao schIdProcDao;
	private Connection conn;
	private SchIdProcDao() { }
	public static SchIdProcDao getInstance() {
		if(schIdProcDao == null) schIdProcDao = new SchIdProcDao();
		return schIdProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public MemberInfo getSchId(String name, String regist) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo loginInfo = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "select count(*) from t_member_info where mi_name = '"+ name +"' and mi_regist = '"+ regist +"'";
			rs = stmt.executeQuery(sql);
			rs.next();				// count() 
			result = rs.getInt(1);
			
			
		}catch(Exception e) {
			System.out.println("SchIdProcDao 클래스에서 getSchId() 메소드 에러 발생");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return loginInfo;
	}
}