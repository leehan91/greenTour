package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PareviewProcInDao {
	private static PareviewProcInDao pareviewProcInDao;
	private Connection conn;
	private PareviewProcInDao() {}
	
	public static PareviewProcInDao getInstance() {
		if (pareviewProcInDao == null)	pareviewProcInDao = new PareviewProcInDao();
		
		return pareviewProcInDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int PareviewInsert(CsPareview cp) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		try {			
			String sql = "insert into t_cs_pareview(mi_id, mi_name, op_code, cp_name, cp_title,"
					+ " cp_content, cp_score) values('" + cp.getMi_id() + "', '" + cp.getMi_name() + 
					"', '" + cp.getOp_code() + "', '" + cp.getCp_name() + "', '" + cp.getCp_title() +
					"', '" + cp.getCp_content() + "', '" + cp.getCp_score() + "');"; 
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			
		} catch(Exception e) {
			System.out.println("PareviewProcInDao Ŭ������ PareviewInsert() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs); close(stmt);
		}
		return result;
	}

	public int PareviewUpdate(CsPareview cp) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		try {			
			String sql = "update t_order_painfo set op_review = 'y' where mi_id = '" + 
		cp.getMi_id() + "' and op_code = '" + cp.getOp_code() + "'"; 
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			
		} catch(Exception e) {
			System.out.println("PareviewProcInDao Ŭ������ PareviewInsert() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs); close(stmt);
		}
		return result;
	}
	
}
