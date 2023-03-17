package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class IndexDao {
	private static IndexDao packageOutDao;
	private Connection conn;
	private IndexDao() {}
	public static IndexDao getInstance() {
		if (packageOutDao == null)	packageOutDao = new IndexDao();
		return packageOutDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<PackageInfo> getPackageOut(){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageInfo> piList = new ArrayList<PackageInfo>();
		PackageInfo pi = null;
		
		try {
			String sql = "select a.pi_code, a.pi_price, a.pi_dc, a.pi_img2, b.cc_name "
				+ " from t_package_info a, t_ctgr_city b "
				+ " where pi_isview='y' and a.cc_id = b.cc_id and a.pi_dc > 0 "
				+ " order by rand() limit 3";
			// System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pi = new PackageInfo();
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_code(rs.getString("pi_code"));
				pi.setPi_price(rs.getInt("pi_price"));
				pi.setCc_name(rs.getString("cc_name"));
				pi.setPi_img2(rs.getString("pi_img2"));
				piList.add(pi);
			}
		
			
		} catch (Exception e) {
			System.out.println("PackageOutDao 클래스의 getPackageOut() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		return piList;
	}
	public ArrayList<PackageInfo> getPackageOut2(){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageInfo> piList2 = new ArrayList<PackageInfo>();
		PackageInfo pi2 = null;
		
		try {
			String sql = "select a.pi_code, a.pi_price, a.pi_img2, b.cc_name, a.pi_stock "
					+ " from t_package_info a, t_ctgr_city b "
					+ " where pi_isview='y' and a.cc_id = b.cc_id and a.pi_dc = 0 and a.pi_stock > 50 "
					+ " order by rand() limit 6";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pi2 = new PackageInfo();
				pi2.setCc_name(rs.getString("b.cc_name"));
				pi2.setPi_code(rs.getString("pi_code"));
				pi2.setPi_img2(rs.getString("pi_img2"));
				pi2.setPi_price(rs.getInt("pi_price"));
				pi2.setPi_stock(rs.getInt("pi_stock"));
				piList2.add(pi2);
			}
		
			
		} catch (Exception e) {
			System.out.println("PackageOutDao 클래스의 getPackageOut2() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		return piList2;
	}
}
