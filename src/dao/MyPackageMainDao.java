package dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰ� ����
import java.util.*;
import java.sql.*;
import java.time.LocalDate;

import vo.*;

public class MyPackageMainDao {
	private static MyPackageMainDao myPackageMainDao;
	private Connection conn;
	private MyPackageMainDao() { }
		
	public static MyPackageMainDao getInstance() {		
		if(myPackageMainDao == null) myPackageMainDao = new MyPackageMainDao();
		
		return myPackageMainDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<CtgrCity> getCityList(String nation){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CtgrCity> cityList = new ArrayList<CtgrCity>();
		CtgrCity cc = null;
		
		try {
			String sql = "select * from t_ctgr_city where left(cc_id,3) = '" + nation + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				cc = new CtgrCity();
				cc.setCc_id(rs.getString("cc_id"));
				cc.setCc_name(rs.getString("cc_name"));
				cc.setCc_img1(rs.getString("cc_img1"));
				cityList.add(cc);
			}
			
		}catch(Exception e) {
			System.out.println("MyPackageMainDao Ŭ������ getCityList() �޼ҵ�(����������������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		
		
		return cityList;
	}
	
	public ArrayList<FlightInfo> getAirList(String city, String sdate, String edate){
		// ���� ����� , �������� �޾� �װ�����Ʈ �޾ƿ��� �޼ҵ� 
		ArrayList<FlightInfo> airList = new ArrayList<FlightInfo>(); // �װ����� ����Ʈ
		ArrayList<FlightRealPrice> flightRealPriceList = new ArrayList<FlightRealPrice>();
		FlightInfo fi = null;
		FlightRealPrice frp = null;
		Statement stmt = null;
		ResultSet rs = null;
		String ccid = "";
		String ccname = city;
		try {
			
			String sql = "select cc_id from t_ctgr_city where cc_name = '" + city + "'";
			//System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) ccid = rs.getString("cc_id");
	
			sql = "select * from t_flight_info where cc_id = '" + ccid + 
					"' and left(fi_departure,10) = '" + sdate +"' and left(fi_entry,10) = '" + edate + "'";
			//System.out.println(sql);
			Statement stmt2 = conn.createStatement();
			ResultSet rs2 = stmt2.executeQuery(sql);

			while(rs2.next()) {
				fi = new FlightInfo();
				fi.setFi_code(rs2.getString("fi_code"));
				fi.setCc_id(rs2.getString("cc_id"));
				fi.setCc_name(ccname);
				fi.setFi_origin(rs2.getString("fi_origin"));
				fi.setFi_departure(rs2.getString("fi_departure"));
				fi.setFi_cityarrive(rs2.getString("fi_cityarrive"));
				fi.setFi_cityleave(rs2.getString("fi_cityleave"));
				fi.setFi_entry(rs2.getString("fi_entry"));
				fi.setFi_passenger(rs2.getInt("fi_passenger"));
				
					// �ϳ��� �װ������� �������� 6���� ���� ArrayList<FlightRealPrice> flightRealPriceList �� rs2�� ����Ʈ��.  
					sql = "select * from t_flight_realprice where cc_id = '" + ccid + "'";
					//System.out.println(sql);
					Statement stmt3 = conn.createStatement();
					ResultSet rs3 = stmt3.executeQuery(sql);
					
					while(rs3.next()) {
						frp = new FlightRealPrice();
						frp.setFr_idx(rs3.getInt("fr_idx"));
						frp.setCc_id(rs3.getString("cc_id"));
						frp.setFr_name(rs3.getString("fr_name"));
						frp.setFr_adult(rs3.getInt("fr_adult"));
						frp.setFr_child(rs3.getInt("fr_child"));
						frp.setFr_grade(rs3.getString("fr_grade"));
						flightRealPriceList.add(frp);
						
					}
					
					
				fi.setFlightRealPriceList(flightRealPriceList);	// ���� 6�� �� ���� ArrayList�� set ���� 

				airList.add(fi);
			}
			// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!�� �ȵ� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//			sql = "select * form t_flight_realprice where cc_id = '" + ccid + "'";
//			rs = stmt.executeQuery(sql);
//			while(rs.next()) {
//				
//			}
			
			
		}catch(Exception e) {
			System.out.println("MypackageMainDao Ŭ������ getAirList() �޼ҵ�(�װ�������������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return airList;
	}
	
	public String getCcid(String city) {
		String ccid = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select cc_id from t_ctgr_city where cc_name = '" + city + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) ccid = rs.getString("cc_id");
			
			
		}catch(Exception e) {
			System.out.println("MypackageMainDao Ŭ������ getCcid() �޼ҵ�(ccid �޾ƿ���) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return ccid;
	}
	
	public ArrayList<HotelInfo> getHotelList(String ccid){
		ArrayList<HotelInfo> hotelList = new ArrayList<HotelInfo>();
		HotelInfo hi = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_hotel_info where hi_isdel = 'n' and cc_id = '" + ccid + "'";
			//System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				hi = new HotelInfo();
				hi.setHi_code(rs.getString("hi_code"));
				hi.setCc_id(rs.getString("cc_id"));
				hi.setHi_name(rs.getString("hi_name"));
				hi.setHi_grade(rs.getString("hi_grade"));
				hi.setHi_addr(rs.getString("hi_addr"));
				hi.setHi_tel(rs.getString("hi_tel"));
				hi.setHi_desc(rs.getString("hi_desc"));
				hi.setHi_notice(rs.getString("hi_notice"));
				hi.setHi_img1(rs.getString("hi_img1"));
				hi.setHi_img2(rs.getString("hi_img2"));
				hi.setHi_img3(rs.getString("hi_img3"));
				hi.setHi_img4(rs.getString("hi_img4"));
				hi.setHi_img5(rs.getString("hi_img5"));
				hi.setHi_date(rs.getString("hi_date"));
				hi.setAi_id(rs.getString("ai_id"));
				hi.setHi_price(rs.getInt("hi_price"));
				hi.setHi_score(rs.getInt("hi_score"));
				hi.setHi_standard(rs.getInt("hi_standard"));
				hi.setHi_deluxe(rs.getInt("hi_deluxe"));
				hi.setHi_suite(rs.getInt("hi_suite"));
				hi.setHi_stock(rs.getInt("hi_stock"));
				hi.setHi_sale(rs.getInt("hi_sale"));
				hotelList.add(hi);
			}
			
		}catch(Exception e) {
			System.out.println("MypackageMainDao Ŭ������ getHotelList() �޼ҵ�(ȣ��������������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return hotelList;
		
	}
	
	public ArrayList<PackageTour> getTourList(String ccid){
		ArrayList<PackageTour> tourList = new ArrayList<PackageTour>();
		Statement stmt = null;
		ResultSet rs = null;
		PackageTour pt = null;
		
		try {
			String sql = "select * from t_package_tour where pt_isdel = 'n' and cc_id = '" + ccid + "' ";
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
			System.out.println("MypackageMainDao Ŭ������ getHotelList() �޼ҵ�(ȣ��������������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return tourList;
	}
	
	public String getMmCode(String city3) {
		
		String mmcode = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select right(mm_code,3) seq from t_mypackage_my where mid(mm_code,6,3) = '" + 
					city3 + "' order by mm_date desc limit 0, 1";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {	//���� ������ ������Ű�� �ڵ尡 ������
				int num = Integer.parseInt(rs.getString("seq")) + 1;
				String number = "";
				if(num < 10) number = "00"+ num;
				else if (num >= 10 && num < 100 ) number = "0" + num;
				else if (num >= 100) number = "" + num;
				
				mmcode = "MYICN" + city3 + number;
			}else { //������Ű�� �ڵ尡 �����ٸ�
				mmcode = "MYICN" + city3 + "001";
			}
			
		}catch(Exception e) {
			System.out.println("MypackageMainDao Ŭ������ getHotelList() �޼ҵ�(ȣ��������������) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return mmcode;
	}
	
	
	public String myPackageInsert(MyPackageMy mm, MemberInfo mi, String payment) {
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;
		String sql = "";
		String result = "";
		int chk = 0;
		int num = 0;
		String snum = "";		String omcode = "";
		String omleave = "";	String omarrive = "";
		String omstatus = "";
		
		if(payment.equals("a") || payment.equals("b"))	omstatus = "b";
		else if (payment.equals("c")) 					omstatus = "a";
		
		try {
			sql = "INSERT INTO t_mypackage_my (mm_code, mi_id, mm_name, cc_id, fi_code, hi_code, fr_idx, mm_tour, mm_adult, mm_child, mm_price, mm_destination, mm_period, mm_hgrade, mm_agrade, mm_atotal, mm_htotal, mm_ttotal) VALUES ('" + 
					mm.getMm_code()+ "', '" + mm.getMi_id() + "', '" + mm.getMm_name() + "', '" + mm.getCc_id() + "', '" + mm.getFi_code() + "', '" + mm.getHi_code() + "', '" + mm.getFr_idx() + "', '" + mm.getMm_tour().trim() + "', '" + 
					mm.getMm_adult() + "', '" + mm.getMm_child() + "', '" + mm.getMm_price() + "', '" + mm.getMm_destination() + "', '" + mm.getMm_period() + "', '" + mm.getMm_hgrade() + "', '" + mm.getMm_agrade() + "', '" + mm.getMm_atotal() + 
					"', '" + mm.getMm_htotal() + "', '" + mm.getMm_ttotal() + "')";
			//System.out.println("t_mypackage_my �μ�Ʈ sql : " + sql);
			stmt = conn.createStatement();
			chk = stmt.executeUpdate(sql);
			
			if(chk == 1) {	// ������Ű�� �μ�Ʈ�� �����ϸ�, om �ڵ带 ����� �ڵ� ���� 
				LocalDate today = LocalDate.now();	// yyyy-mm-dd
				String td = (today + "").substring(2).replace("-", "");	// yymmdd
				sql ="select right(om_code, 3) seq from t_order_mpinfo where mid(om_code, 3, 6) = '" + td + "' order by om_time desc limit 0, 1";
				rs = stmt.executeQuery(sql);
				//System.out.println("omcode ���� sql : "+sql);
				if(rs.next()) {
					num = Integer.parseInt(rs.getString(1)) + 1;
					if(num < 10) {
						snum = "00" + num;
					}else if(num >= 10 && num < 100) {
						snum = "0" + num;
					}else if(num >= 100) {
						snum = num + "";
					}
					omcode = "MY" + td + snum;
				} else {// ���� ù ����
					omcode = "MY" + td + "001";
				}
				
				// omcode �� ���������� t_order_mpinfo �� �μ�Ʈ
				sql = "select fi_departure, fi_entry from t_flight_info where fi_code ='" + mm.getFi_code() + "'";
				rs = stmt.executeQuery(sql);
				if(rs.next()) {
					omleave = rs.getString("fi_departure");
					omarrive = rs.getString("fi_entry");
					
				}
				
				sql = "insert into t_order_mpinfo (om_code, mi_id, om_name, om_customer, om_phone, om_email, om_leave, om_arrive, cc_id,  om_payment, om_pay, om_adult, om_child, om_umile, om_smile, om_status, mm_code) values ('" + 
				omcode + "', '" + mi.getMi_id() + "', '" + mm.getMm_name() + "', '" + mi.getMi_name() + "', '" + mi.getMi_phone() + "', '" + mi.getMi_email() + "', '" + omleave + "', '" + omarrive + "', '" + mm.getCc_id() + "', '" + payment + "', '" + 
						mm.getMm_price() + "', '" + mm.getMm_adult() + "', '" + mm.getMm_child() + "', '" + 0 + "', '" + 0 + "', '" + omstatus + "', '" + mm.getMm_code() + "')";
				//System.out.println("t_order_mpinfo �μ�Ʈ�� : " + sql);
				
				stmt2 = conn.createStatement();
				chk += stmt2.executeUpdate(sql);				
			}
	
		}catch(Exception e) {
			System.out.println("MypackageMainDao Ŭ������ myPackageInsert() �޼ҵ�(������Ű�� �μ�Ʈ, ������Ű���������� �μ�Ʈ) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);  close(stmt2);
		}
		
		result = chk + "/" + omcode;
		
		return result;
	}
	
	public OrderMpInfo getOmInfo(String omcode) {
		Statement stmt = null;
		ResultSet rs = null;
		OrderMpInfo om = null;
		String sql = "select * from t_order_mpinfo where om_code ='" + omcode + "'";
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				om = new OrderMpInfo();
				om.setOm_code(rs.getString("om_code"));
				om.setMi_id(rs.getString("mi_id"));
				om.setOm_name(rs.getString("om_name"));
				om.setOm_leave(rs.getString("om_leave"));
				om.setOm_arrive(rs.getString("om_arrive"));
				om.setOm_spoint(rs.getString("om_spoint"));
				om.setCc_id(rs.getString("cc_id"));
				om.setOm_customer(rs.getString("om_customer"));
				om.setOm_phone(rs.getString("om_phone"));
				om.setOm_email(rs.getString("om_email"));
				om.setOm_payment(rs.getString("om_payment"));
				om.setOm_pay(rs.getInt("om_pay"));
				om.setOm_adult(rs.getInt("om_adult"));
				om.setOm_child(rs.getInt("om_child"));
				om.setOm_umile(rs.getInt("om_umile"));
				om.setOm_smile(rs.getInt("om_smile"));
				om.setOm_status(rs.getString("om_status"));
				om.setOm_time(rs.getString("om_time"));
				om.setMm_code(rs.getString("mm_code"));
				
			}
		}catch(Exception e) {
			System.out.println("MypackageMainDao Ŭ������ getOmcode() �޼ҵ�(���â�� ���� omcode ����) ���� �߻�");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt); 
		}
		
		return om;
	}
}
