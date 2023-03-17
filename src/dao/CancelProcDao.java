package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class CancelProcDao {
	private static CancelProcDao cancelProcDao;
	private Connection conn;
	private CancelProcDao() {}
	
	public static CancelProcDao getInstance() {
		
		if (cancelProcDao == null)	cancelProcDao = new CancelProcDao();
		
		return cancelProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int insertPacancel(String ctgr, String content, String code) {
		Statement stmt = null;
		int result = 0;
		
		
		try {
			stmt = conn.createStatement();
			String sql = "insert into t_member_pa_cancel (op_code, mpc_reason, mpc_rsndetail, mpc_status) " + 
					" values ('"+ code +"', '"+ ctgr +"', '"+ content +"', 'b')";
			result = stmt.executeUpdate(sql);
			
			sql = "update t_order_painfo set op_status = 'c' where op_code ='" + code + "'";
			result += stmt.executeUpdate(sql);

			
		} catch (Exception e) {
			System.out.println("CancelProcDao 클래스의 getStatus() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
}
