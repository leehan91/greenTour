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
		// ������ �Խñ��� ��ȸ���� ������Ű�� �޼ҵ�
			int result = 0;
			Statement stmt = null;
			
			try {
				String sql = "update t_cs_Pareivew set cp_read = cp_read + 1 where cp_idx = " + cpidx;
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				
			} catch (Exception e) {
				System.out.println("PareviewViewDao Ŭ������ readUpdate() �޼ҵ� ����");
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
				System.out.println("PareviewViewDao Ŭ������ getPareviewView() �޼ҵ� ����");
			} finally {
				close(rs);		close(stmt);
			}
			
			return cp;
		}
}
