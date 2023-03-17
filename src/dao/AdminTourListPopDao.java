package dao;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용하게 해줌
import java.util.*;
import java.sql.*;
import java.time.LocalDate;

import vo.*;


public class AdminTourListPopDao {
	private static AdminTourListPopDao adminTourListPopDao;
	private Connection conn;
	private AdminTourListPopDao() { }
		
	public static AdminTourListPopDao getInstance() {		
		if(adminTourListPopDao == null) adminTourListPopDao = new AdminTourListPopDao();
		
		return adminTourListPopDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<PackageTour> getTourList(String ccid){
		ArrayList<PackageTour> tourList = new ArrayList<PackageTour>();
		Statement stmt = null;
		ResultSet rs = null;
		PackageTour pt = null;
		
		try {
			String sql = "select * from t_package_tour where cc_id = '" + ccid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				pt = new PackageTour();
				pt.setCc_id(rs.getString("cc_id"));
				pt.setPt_code(rs.getString("pt_code"));
				pt.setPt_name(rs.getString("pt_name"));
				pt.setPt_addr(rs.getString("pt_addr"));
				pt.setPt_page(rs.getString("pt_page"));
				pt.setPt_summary(rs.getString("pt_summary"));
				pt.setPt_desc(rs.getString("pt_desc"));
				pt.setPt_image(rs.getString("pt_image"));
				pt.setPt_price(rs.getInt("pt_price"));
				tourList.add(pt);
			}
			
		}catch(Exception e) {
			System.out.println("MypackageMainDao 클래스의 getHotelList() 메소드(호텔정보가져오기) 에러 발생");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return tourList;
	}
}
