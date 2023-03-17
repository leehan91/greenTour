package dao;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import vo.*;

public class PopDao {
	private static PopDao popDao;
	private Connection conn;
	private PopDao() { }
		
	public static PopDao getInstance() {		
		if(popDao == null) popDao = new PopDao();
		
		return popDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public HotelInfo getHotelInfo(String hicode) {
		Statement stmt = null;
		ResultSet rs = null;
		HotelInfo hi = null;
		
		try {
			String sql = "select * from t_hotel_info where hi_code = '" + hicode + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		
			while(rs.next()) {
				hi = new HotelInfo();
				hi.setHi_name(rs.getString("hi_name"));
				hi.setHi_addr(rs.getString("hi_addr"));
				hi.setHi_tel(rs.getString("hi_tel"));
				hi.setHi_desc(rs.getString("hi_desc"));
				hi.setHi_notice(rs.getString("hi_notice"));
				hi.setHi_img1(rs.getString("hi_img1"));
				hi.setHi_img2(rs.getString("hi_img2"));
				hi.setHi_img3(rs.getString("hi_img3"));
				hi.setHi_img4(rs.getString("hi_img4"));
				hi.setHi_img5(rs.getString("hi_img5"));
				hi.setHi_grade(rs.getString("hi_grade"));
				hi.setHi_standard(rs.getInt("hi_standard"));
				
			}
		}catch(Exception e) {
			System.out.println("PopDao 클래스의 getHotelInfo() 메소드(호텔정보가져오기) 에러 발생");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		
		return hi;
	}
	
	public PackageTour getTourInfo (String ptcode) {
		Statement stmt = null;
		ResultSet rs = null;
		PackageTour pt = null;
		
		try {
			String sql ="select * from t_package_tour where pt_code = '" + ptcode + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {			
				pt = new PackageTour();
				pt.setPt_code(rs.getString("pt_code"));
				pt.setCc_id(rs.getString("cc_id"));
				pt.setPt_name(rs.getString("pt_name"));
				pt.setPt_addr(rs.getString("pt_addr"));
				pt.setPt_page(rs.getString("pt_page"));
				pt.setPt_summary(rs.getString("pt_summary"));
				pt.setPt_desc(rs.getString("pt_desc"));
				pt.setPt_image(rs.getString("pt_image"));
				pt.setPt_price(rs.getInt("pt_price"));				
			}
			//System.out.println("popdao 확인 :" + pt.getPt_name());
		}catch(Exception e) {
			System.out.println("PopDao 클래스의 getTourInfo() 메소드(관광상품정보가져오기) 에러 발생");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		
		return pt;
	}
	
}
