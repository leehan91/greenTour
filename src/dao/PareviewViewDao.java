package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class PareviewViewDao {
	private static PareviewViewDao pareviewViewDao;
	private Connection conn;
	private PareviewViewDao() {}
	
	public static PareviewViewDao getInstance() {
		if (pareviewViewDao == null)	pareviewViewDao = new PareviewViewDao();
		
		return pareviewViewDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int readUpdate(int cpidx) {
		// 지정한 게시글의 조회수를 증가시키는 메소드
			int result = 0;
			Statement stmt = null;
			
			try {
				String sql = "update t_cs_Pareivew set cp_read = cp_read + 1 where cp_idx = " + cpidx;
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				
			} catch (Exception e) {
				System.out.println("PareviewViewDao 클래스의 readUpdate() 메소드 오류");
				e.printStackTrace();
			} finally {
				close(stmt);
			}
			
			return result;
		}
	public CsPareview getPareviewView(int cpidx) {
			Statement stmt = null;
			ResultSet rs = null;
			CsPareview cp = null;
			
			try {
				String sql = "select * from t_cs_notice where cn_isdel = 'n' and cp_idx = " + cpidx;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				if (rs.next()) {
					cp = new CsPareview();
					cp.setCp_idx(cpidx);
					cp.setMi_id(rs.getString("mi_id"));
					cp.setOp_code(rs.getString("op_code"));
					cp.setCp_name(rs.getString("cp_name"));
					cp.setCp_title(rs.getString("cp_title"));
					cp.setCp_content(rs.getString("cp_content"));
					cp.setCp_date(rs.getString("cp_date"));
					cp.setCp_isdel(rs.getString("cp_isdel"));
					cp.setCc_name(rs.getString("cc_name"));
					cp.setOp_name(rs.getString("op_name"));
					cp.setCp_read(rs.getInt("cp_read"));
					cp.setCp_score(rs.getFloat("cp_score"));
					
				}
				
			} catch (Exception e) {
				System.out.println("PareviewViewDao 클래스의 getPareviewView() 메소드 오류");
			} finally {
				close(rs);		close(stmt);
			}
			
			return cp;
		}
}
