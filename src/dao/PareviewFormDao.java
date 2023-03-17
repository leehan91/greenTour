package dao;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import vo.*;

public class PareviewFormDao {
	private static PareviewFormDao pareviewFormDao;
	private Connection conn;
	private PareviewFormDao() {}
	public static PareviewFormDao getInstance() {
		if (pareviewFormDao == null)	pareviewFormDao = new PareviewFormDao();
		return pareviewFormDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<CsPareview> getPareviewForm(String miid) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CsPareview> formList = new ArrayList<CsPareview>();
		CsPareview cp = null;
		try {
			String sql = "select a.*, c.cc_name, b.op_name, b.op_code, b.op_code "
					+ "from t_cs_pareview a, t_order_painfo b, t_ctgr_city c "
					+ " where cp_isdel = 'n' and a.mi_id = '" + miid +"' and a.op_code = b.op_code "
					+ "and b.cc_id = c.cc_id";
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
				cp.setCp_date(rs.getString("cp_date"));
				cp.setCp_read(rs.getInt("cp_read"));
				cp.setOp_code(rs.getString("op_code"));
				formList.add(cp);
			}
				
			
		} catch (Exception e) {
			System.out.println("PareviewFormDao 클래스의 getPareviewForm() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return formList;
	}
}
