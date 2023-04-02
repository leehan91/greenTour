package dao;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import vo.CsPareview;

public class AdminPareviewDao {
	private static AdminPareviewDao adminPareviewDao;
	private Connection conn;
	private AdminPareviewDao() {}
	
	public static AdminPareviewDao getInstance() {
		
		if (adminPareviewDao == null)	adminPareviewDao = new AdminPareviewDao();
		
		return adminPareviewDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int getPareviewCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_cs_pareview";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) rcnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("AdminPareviewDao클래스의 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
				
		return rcnt;
	}

	public ArrayList<CsPareview> getPareviewList(int cpage, int psize) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CsPareview> csPareview = new ArrayList<CsPareview>();
		CsPareview cp = null;
		try {			
			String sql = "select cp_idx, cp_title, mi_id, if (curdate() = date(cp_date), mid(cp_date, 12, 5), " + 
					" replace(mid(cp_date, 3, 8), '-', '.')) wdate, cp_isdel from t_cs_pareview " + 
					" order by cp_idx desc limit " + ((cpage -1 ) * psize) + ", " + psize;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				cp = new CsPareview();
				cp.setCp_idx(rs.getInt("cp_idx"));
				cp.setCp_title(rs.getString("cp_title"));
				cp.setMi_id(rs.getString("mi_id"));
				cp.setCp_date(rs.getString("wdate"));
				cp.setCp_isdel(rs.getString("cp_isdel"));
				csPareview.add(cp);
			}
			
		} catch(Exception e) {
			System.out.println("AdminPareviewDao 클래스 getPareviewList() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs); close(stmt);
		}
		return csPareview;
	}
}
