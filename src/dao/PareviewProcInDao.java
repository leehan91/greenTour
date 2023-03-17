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
	public int PareviewInsert(CsPareview cpl) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		try {			
			String sql = "select a.cp_idx, c.cc_name, b.op_name, a.cp_score, a.mi_id, a.cp_title, " + 
					" a.cp_date, a.cp_read, b.op_code, b.op_code from t_cs_pareview a, t_order_painfo b, t_ctgr_city c " + 
					" where a.mi_id = '" + cpl.getMi_id() + "' and a.op_code = b.op_code and b.cc_id = c.cc_id " ;
			System.out.println(sql);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				while(rs.next()) {
					cpl = new CsPareview();
					cpl.setCp_idx(cpl.getCp_idx());
					cpl.setCc_name(rs.getString("cc_name"));
					cpl.setOp_name(rs.getString("op_name"));
					cpl.setOp_code(rs.getString("op_code"));
					cpl.setCp_score(rs.getInt("cp_score"));
					cpl.setMi_id(cpl.getMi_id());
					cpl.setCp_title(cpl.getCp_title());
					cpl.setCp_date(cpl.getCp_date());
					cpl.setCp_read(cpl.getCp_read());
					cpl.setOp_code(cpl.getOp_code());
					
					
				}
				
			
			sql = "insert into t_cs_pareview (cp_idx, mi_id, op_code, cp_name, cp_title, cp_content, cp_score, cp_read, cp_date, cp_isdel) " + 
					"values ('" + cpl.getCp_idx() + 1 + "', '" + cpl.getMi_id() + "', '" + cpl.getOp_code() + "', '" + cpl.getCp_name() + "', '" + 
					cpl.getCp_title() +"', '" + cpl.getCp_content() + "', '" + cpl.getCp_score() + "', '" + cpl.getCp_read() + "', '" + cpl.getCp_date() 
					+ "', '"+ cpl.getCp_isdel() + "') "; 
			System.out.println(sql);
			
			result = stmt.executeUpdate(sql);
			
			
		} catch(Exception e) {
			System.out.println("PareviewProcInDao 클래스의 PareviewInsert() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs); close(stmt);
		}
		return result;
	}
}
