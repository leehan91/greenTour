package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminPackageListDao {
	private static AdminPackageListDao adminPackageListDao;
	private Connection conn;
	private AdminPackageListDao() {}
	
	public static AdminPackageListDao getInstance() {
		
		if (adminPackageListDao == null)	adminPackageListDao = new AdminPackageListDao();
		
		return adminPackageListDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getPackageListCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_package_info " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())		rcnt = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("AdminPackageListDao 클래스의 getPackageListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return rcnt;
	}
	
	// 하나의 패키지 정보를 담아오는 메소드
	public ArrayList<PackageInfo> getPackageList(String where, int cpage, int psize) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageInfo> packageList = new ArrayList<PackageInfo>();
		PackageInfo pi = null;
		
		try {
			String sql = "select * from t_package_info " + where + " order by pi_code desc limit " 
					+ ((cpage - 1) * psize) + ", " + psize ;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pi = new PackageInfo();
				pi.setPi_code(rs.getString("pi_code"));
				pi.setPi_period(rs.getString("pi_period"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_price(rs.getInt("pi_price"));
				packageList.add(pi);
			}
			
			
		} catch (Exception e) {
			System.out.println("AdminPackageListDao 클래스의 getPackageList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return packageList;
	}
	
	// 패키지 상제 정보를 불러오는 메소드
	public PackageInfo getPackageInfo(String where, String picode) {
		Statement stmt = null;
		ResultSet rs = null;
		PackageInfo pai = null;
		
		try {
			String sql = "select a.*, b.hi_name, c.cc_name " + 
						" from t_package_info a, t_hotel_info b, t_ctgr_city c " + 
						where + " and a.hi_code = b.hi_code and a.cc_id = c.cc_id and a.pi_code = '"+ picode +"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				pai = new PackageInfo();
				pai.setPi_code(rs.getString("a.pi_code"));
				pai.setCc_name(rs.getString("c.cc_name"));
				pai.setHi_name(rs.getString("b.hi_name"));
				pai.setPi_tour(rs.getString("a.pi_tour"));
				pai.setPi_food(rs.getString("a.pi_food"));
				pai.setPi_stock(rs.getInt("a.pi_stock"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminPackageListDao 클래스의 getPackageInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return pai;
	}
}
