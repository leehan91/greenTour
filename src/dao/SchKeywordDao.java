package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class SchKeywordDao {
	private static SchKeywordDao schKeywordDao;
	private Connection conn;
	private SchKeywordDao() {}
	public static SchKeywordDao getInstance() {
		if (schKeywordDao == null)	schKeywordDao = new SchKeywordDao();
		return schKeywordDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<PackageInfo> getPackageOut(String keyword){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageInfo> piList = new ArrayList<PackageInfo>();
		PackageInfo pi = null;
		
		try {
			String sql = "select pi_country, pi_img1, pi_name, pi_price , pi_period, pi_code "
					+ "from t_package_info where pi_isview = 'y' and (pi_country ='" + keyword + "' or cc_id ='" + keyword+ 
					"' or pi_name like '%" + keyword + "%' or pi_keyword like '%" + keyword + "%')"
					+ " order by rand() limit 9";
			System.out.println("dao sql : " + sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pi = new PackageInfo();
				pi.setPi_country(rs.getString("pi_country"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_period(rs.getString("pi_period"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_code(rs.getString("pi_code"));
				pi.setPi_price(rs.getInt("pi_price"));
				piList.add(pi);
			}
		
			
		} catch (Exception e) {
			System.out.println("SchKeywordDao 클래스의 getPackageOut() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return piList;
	}
	public ArrayList<HotelInfo> getHotelOut(String keyword) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<HotelInfo> hoList = new ArrayList<HotelInfo>();
		HotelInfo hi = null;
		

		try {
			String sql = "select hi_name, hi_grade, hi_img1, hi_price from t_hotel_info "
					+ " where cc_id ='%" + keyword + "%' or hi_name like '%" + keyword + "%' "
					+ " or  hi_code like '%" + keyword + "%' or hi_grade like '%" + keyword + "%' "
					+ " order by hi_grade desc";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				hi = new HotelInfo();
				hi.setHi_name(rs.getString("hi_name"));
				hi.setHi_grade(rs.getString("hi_grade"));
				hi.setHi_img1(rs.getString("hi_img1"));
				hi.setHi_price(rs.getInt("hi_price"));
				hoList.add(hi);
			}
		
			
		} catch (Exception e) {
			System.out.println("SchKeywordDao 클래스의 getHotelOut() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return hoList;
	}
	public ArrayList<CsPareview> getPareviewOut(String keyword) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CsPareview> cpList = new ArrayList<CsPareview>();
		CsPareview cp = null;
		

		try {
			String sql = "select a.cp_idx, c.cc_name, b.op_name, a.cp_score, a.mi_id, a.cp_title, " + 
					" a.cp_date, a.cp_read, b.op_code from t_cs_pareview a, t_order_painfo b, t_ctgr_city c " + 
					" where cp_isdel = 'n' and c.cc_name = '" + keyword + "' and a.op_code = b.op_code " + 
					" and b.cc_id = c.cc_id limit 10 " ;

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				cp = new CsPareview();
				cp.setCp_idx(rs.getInt("cp_idx"));
				cp.setCc_name(rs.getString("cc_name"));
				cp.setOp_name(rs.getString("op_name"));
				cp.setCp_score(rs.getInt("cp_score"));
				cp.setMi_id(rs.getString("mi_id"));
				cp.setCp_title(rs.getString("cp_title"));
				cp.setCp_date(rs.getString("cp_date"));
				cp.setCp_read(rs.getInt("cp_read"));
				cp.setOp_code(rs.getString("op_code"));
				cpList.add(cp);
			}
		
			
		} catch (Exception e) {
			System.out.println("SchKeywordDao 클래스의 getPareviewOut() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return cpList;
	}
}
