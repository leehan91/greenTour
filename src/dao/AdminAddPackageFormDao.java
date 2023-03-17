package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminAddPackageFormDao {
	
	private static AdminAddPackageFormDao adminAddPackageFormDao;
	private Connection conn;
	private AdminAddPackageFormDao() { }
		
	public static AdminAddPackageFormDao getInstance() {		
		if(adminAddPackageFormDao == null) adminAddPackageFormDao = new AdminAddPackageFormDao();
		
		return adminAddPackageFormDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<CtgrCity> getCtgrCity(){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CtgrCity> cityList = new ArrayList<CtgrCity>();
		
		try {
			String sql = "select * from t_ctgr_city";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				CtgrCity city = new CtgrCity();
				city.setCc_id(rs.getString("cc_id"));
				city.setCc_name(rs.getString("cc_name"));
				cityList.add(city);
			}
			
		}catch(Exception e) {
			System.out.println("AdmainAddPackageFormDao Ŭ������ getHotelList() �޼ҵ�(����������������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		
		return cityList;
	}
	
	public ArrayList<HotelInfo> getHotelList(){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<HotelInfo> hotelList = new ArrayList<HotelInfo>();
		try {
			String sql = "select * from t_hotel_info where hi_isdel = 'n'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				HotelInfo hi = new HotelInfo();
				hi.setCc_id(rs.getString("cc_id"));
				hi.setHi_code(rs.getString("hi_code"));
				hi.setHi_name(rs.getString("hi_name"));
				hi.setHi_grade(rs.getString("hi_grade"));
				hi.setHi_standard(rs.getInt("hi_standard"));
				hotelList.add(hi);
			}
			
		}catch(Exception e) {
			System.out.println("AdmainAddPackageFormDao Ŭ������ getHotelList() �޼ҵ�(ȣ�ڴٰ�������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		
		return hotelList;
		
	}
	
	public ArrayList<FlightRealPrice> getFrpList(){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<FlightRealPrice> frpList = new ArrayList<FlightRealPrice>();
		
		try {
			String sql = "select * from t_flight_realprice";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				FlightRealPrice frp = new FlightRealPrice();
				frp.setFr_idx(rs.getInt("fr_idx"));
				frp.setCc_id(rs.getString("cc_id"));
				frp.setFr_name(rs.getString("fr_name"));
				frp.setFr_adult(rs.getInt("fr_adult"));
				frp.setFr_child(rs.getInt("fr_child"));
				frp.setFr_grade(rs.getString("fr_grade"));
				frpList.add(frp);
			}
				
		}catch(Exception e) {
			System.out.println("AdmainAddPackageFormDao Ŭ������ getFrpList() �޼ҵ�(�װ��������� ��������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		
		return frpList;
	}
	
	public int insertPackage(PackageInfo pi){
		Statement stmt = null;
		String sql = "";
		int result = 0;
		try {
			sql ="insert into t_package_info (pi_code, cc_id, pi_country, hi_code, pn_idx, pi_name, pi_period, " + 
					"pi_keyword, pi_img1, pi_img2, pi_img3, pi_img4, pi_img5, pi_desc, pi_special, pi_tour, " + 
					"pi_food, pi_stock, pi_price, pi_adult, pi_child, pi_suggest) values ('" +
					pi.getPi_code() + "', '" + pi.getCc_id() + "', '" + pi.getPi_country() + "', '" + pi.getHi_code() + "', '" + pi.getPn_idx() + "', '" + pi.getPi_name() + "', '" +
					pi.getPi_period() + "', '" + pi.getPi_keyword() + "', '" + pi.getPi_img1() + "', '" + pi.getPi_img2() + "', '" + pi.getPi_img3() + "', '" + pi.getPi_img4() + "', '" + pi.getPi_img5() + "', '" +
					pi.getPi_desc() + "', '" + pi.getPi_special() + "', '" + pi.getPi_tour() + "', '" + pi.getPi_food() + "', '" + pi.getPi_stock() + "', '" + pi.getPi_price() + "', '" + pi.getPi_adult() + "', '" +
					pi.getPi_child() + "', '" + pi.getPi_suggest() + "')";
			System.out.println("��Ű���μ�Ʈ spl : " + sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		}catch(Exception e) {
			System.out.println("AdmainAddPackageFormDao Ŭ������ insertPackage() �޼ҵ�(��Ű�� �μ�Ʈ) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(stmt);
		}
		return result;
		
	}
	
	public int excuteProcedure(PackageInfo pi, String adminId) {
		int result = 0;
		CallableStatement cstmt = null;
		String sql = "";
		String picode = pi.getPi_code();
		String ccid = pi.getCc_id();		
		String admin = adminId;		
		
		try {
			sql = "{call sp_package_date_insert(?, ?, ?)}";
			System.out.println("���ν���sql : "+sql);
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, picode);
			cstmt.setString(2, ccid);
			cstmt.setString(3, admin);
			result = cstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("AdmainAddPackageFormDao Ŭ������ insertPackage() �޼ҵ�(��Ű�� �μ�Ʈ) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(cstmt);	// CallableStatement��  Statement ��ӹ����� �̶� close()�� ���� �ȸ��� ��밡�� 
		}
		
		return result;
	}
}
