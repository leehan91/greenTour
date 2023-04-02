package dao;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import vo.*;

public class PareviewListDao {
		private static PareviewListDao pareviewListDao;
		private Connection conn;
		private PareviewListDao() {}
		
		public static PareviewListDao getInstance() {
			if (pareviewListDao == null)	pareviewListDao = new PareviewListDao();
			
			return pareviewListDao;
		}
		public void setConnection(Connection conn) {
			this.conn = conn;
		}
		public int getPareviewListCount(String where) {
			Statement stmt = null;
			ResultSet rs = null;
			int rcnt = 0;
			try {			
				String sql = "select count(*) from t_cs_pareview, t_order_painfo " + where; 
				// System.out.println(sql);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next()) rcnt = rs.getInt(1);
				} catch(Exception e) {
					System.out.println("PareviewListDao 클래스의 getPareviewListCount() 메소드 오류");
				e.printStackTrace();
			}finally {
				close(rs); close(stmt);
			}
			return rcnt;
		}
		
		public ArrayList<CsPareview> getCsPareviewList(String where, int cpage, int psize, String miid){
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<CsPareview> csPareview = new ArrayList<CsPareview>();
			CsPareview cp = null;
			try {			
				String sql = "select a.cp_idx, c.cc_name, b.op_name, a.cp_score, a.mi_id, a.cp_title, " + 
						"a.cp_read, b.op_code, if (curdate() = date(a.cp_date), mid(a.cp_date, 12, 5), "
            + " replace(mid(a.cp_date, 3, 8), '-', '.')) wdate from t_cs_pareview a, t_order_painfo b, t_ctgr_city c " + 
						where + "and a.mi_id = '" + miid + "' and a.op_code = b.op_code and b.cc_id = c.cc_id " + 
						" order by cp_idx desc limit " + ((cpage -1 ) * psize) + ", " + psize;
				System.out.println(sql);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					cp = new CsPareview();
					cp.setCp_idx(rs.getInt("cp_idx"));
					cp.setCc_name(rs.getString("cc_name"));
					cp.setOp_name(rs.getString("op_name"));
					cp.setOp_code(rs.getString("op_code"));
					cp.setCp_score(rs.getInt("cp_score"));
					cp.setMi_id(rs.getString("mi_id"));
					cp.setCp_title(rs.getString("cp_title"));
					cp.setCp_date(rs.getString("wdate"));
					cp.setCp_read(rs.getInt("cp_read"));
					cp.setOp_code(rs.getString("op_code"));
					csPareview.add(cp);
				}
				
			} catch(Exception e) {
				System.out.println("PareviewListDao 클래스 getPareviewList() 메소드 오류");
				e.printStackTrace();
			}finally {
				close(rs); close(stmt);
			}
			return csPareview;
		}
}


