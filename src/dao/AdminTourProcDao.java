package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminTourProcDao {
	private static AdminTourProcDao adminTourProcDao;
	private Connection conn;
	private AdminTourProcDao() {}
	public static AdminTourProcDao getInstance() {
		if (adminTourProcDao == null)	adminTourProcDao = new AdminTourProcDao();
		return adminTourProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getPareviewListCount(String where) {
		Statement stmt = null;
		ResultSet rs = null;
		int rcnt = 0;
		try {			
			String sql = "select count(*) from t_package_tour " + where; 
			// System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) rcnt = rs.getInt(1);
			} catch(Exception e) {
				System.out.println("AdminTourProcDao 클래스의 getPareviewListCount() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs); close(stmt);
		}
		return rcnt;
	}
	public ArrayList<PackageTour> getTourList(String where, int cpage, int psize) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageTour> ptList = new ArrayList<PackageTour>();
		PackageTour pt = null;
		
		try {
			String sql = "select cc_id, pt_name, pt_addr, pt_date, pt_code from t_package_tour "
					+ where + " and pt_isdel = 'n' order by cc_id limit " + ((cpage -1 ) * psize) + ", " + psize;
			// System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pt = new PackageTour();
				pt.setCc_id(rs.getString("cc_id"));
				pt.setPt_name(rs.getString("pt_name"));
				pt.setPt_code(rs.getString("pt_code"));
				pt.setPt_addr(rs.getString("pt_addr"));
				pt.setPt_date(rs.getString("pt_date"));
				ptList.add(pt);
			}
		
			
		} catch (Exception e) {
			System.out.println("AdminTourProcDao 클래스의 getTourList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		return ptList;
	}
	public int TourProcIn(PackageTour pt) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "insert into t_package_tour (pt_code, cc_id, pt_name, pt_addr, "
					+ " pt_page, pt_summary, pt_desc, pt_image, pt_price ) values " + 
					"('" + pt.getPt_code() + "', '" + pt.getCc_id() + "', '" + pt.getPt_name() + 
					"', '" + pt.getPt_addr() + "', '" + pt.getPt_page() + "', '" + pt.getPt_summary() + 
					"', '" + pt.getPt_desc() + "', '" + pt.getPt_image() + "', " + pt.getPt_price() + " )";
			// System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
				
		} catch (Exception e) {
			System.out.println("AdminTourProcDao 클래스의 insTourProc() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	public int tourDelete(String where) {
		// 지정한 댓글을 삭제하는 메소드
			Statement stmt = null;
			int result = 0;
			
			try {
				String sql = "update t_package_tour set pt_isdel='y' " + where ;
				// System.out.println("sql : " + sql );
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
			} catch (Exception e) {
				System.out.println("AdminTourProcDao 클래스의 tourDelete() 메소드 오류");
				e.printStackTrace();
			} finally {
				close(stmt);
			}
			
			return result;
	}
	public PackageTour getTour(String ptcode) {
		Statement stmt = null;
		ResultSet rs = null;
		PackageTour pt = null;
		try {
			String sql = "select * from t_package_tour where pt_price >= 0 and pt_code = '" + ptcode + "'";
			// System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				pt = new PackageTour();
				pt.setPt_code(rs.getString("pt_code"));
				pt.setCc_id(rs.getString("cc_id"));
				pt.setPt_name(rs.getString("pt_name"));
				pt.setPt_addr(rs.getString("pt_addr"));
				pt.setPt_page(rs.getString("pt_page"));
				pt.setPt_summary(rs.getString("pt_summary"));
				pt.setPt_desc(rs.getString("pt_desc"));
				pt.setPt_image(rs.getString("pt_image"));
				pt.setPt_date(rs.getString("pt_date"));
				pt.setPt_isdel(rs.getString("pt_isdel"));
				pt.setPt_price(rs.getInt("pt_price"));
			}
		} catch (Exception e) {
			System.out.println("AdminTourProcDao 클래스의 getTour() 메소드 오류");
		} finally {
			close(rs);		close(stmt);
		}
		return pt;
	}
	public int TourProcUp(PackageTour pt) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_package_tour set cc_id = '" + pt.getCc_id() + 
					"', pt_name = '" +
					pt.getPt_name() + "', pt_addr = '" + pt.getPt_addr() + 
					"', pt_price = '" + pt.getPt_price() + "', pt_page = '" + 
					pt.getPt_page() + "', pt_image = '" + pt.getPt_image() + "', " + 
					"pt_summary = '" + pt.getPt_summary() + "', pt_desc='" + 
					pt.getPt_desc() + "' where pt_code = '" + pt.getPt_code() + "' ";
			// System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
					
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao의 TourProcUp() 메소드 오류");
		} finally {
			close(stmt);
		}
		return result;
	}
}
