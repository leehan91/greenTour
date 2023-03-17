package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class PackageReservDao {
	// 패키지  관련된 쿼리 작업(폼, 예약 등) 들을 처리하는 클래스
	private static PackageReservDao packageReservDao;
	private Connection conn;
	private PackageReservDao() {}
	
	public static PackageReservDao getInstance() {
		
		if (packageReservDao == null)	packageReservDao = new PackageReservDao();
		
		return packageReservDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public PackageInfo getViewList(String piCode, String departure) {
	// 상품 예약 페이지에서 출력할 값을 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		PackageInfo pi = null;
		String sql = "select a.pi_code, a.pi_name, a.pi_period, a.pi_adult, a.pi_child, a.cc_id, b.fi_code, b.fi_origin, b.fi_departure "
				+ "from t_package_info a, t_flight_info b "
				+ "where a.cc_id = b.cc_id and b.fi_departure = '" + departure + "' and a.pi_code ='" + piCode + "' limit 1";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pi = new PackageInfo();
				FlightInfo fi = new FlightInfo();
				pi.setPi_code(rs.getString("pi_code"));
				pi.setCc_id(rs.getString("cc_id"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_period(rs.getString("pi_period"));
				pi.setPi_adult(rs.getInt("pi_adult"));
				pi.setPi_child(rs.getInt("pi_child"));
				pi.setFi_code(rs.getString("fi_code"));
				pi.setFi_departure(rs.getString("fi_departure"));
			}
			
		} catch (Exception e) {
			System.out.println("PackageProcDao 클래스의 getViewList() 메소드 오류 (패키지 정보 가져오기)");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return pi;
	}

	public String packgeOpcodeNew() {
		// 새로운 주문번호를 생성하여 리턴하는 메소드
			Statement stmt = null;
			ResultSet rs = null;
			String op_code = null;
			try {
				stmt = conn.createStatement();
				LocalDate today = LocalDate.now();		// yyyy-mm-dd
				String td = (today + "").substring(2).replace("-", "");		// yymmddd
				
				String op = "OP";
				
				String sql = "select right(op_code, 3) seq from t_order_painfo where mid(op_code, 3, 6) = '" + td 
						+ "' order by op_time desc limit 0, 1";
//				System.out.println("sql : " + sql);
				// 같은 날 입력된 주문번호들 중 가장 최근 것을 가져오는 쿼리
				rs = stmt.executeQuery(sql);
				if(rs.next()) { 
				    System.out.println("seq : " + rs.getString("seq"));
		            int num = Integer.parseInt(rs.getString("seq")) + 1;
		            String number = "";
		            if(num < 10) number = "00"+ num;
		            else if (num >= 10 && num < 100 ) number = "0" + num;
		            else if (num >= 100) number = "" + num;
		            
		            op_code = "OP" + td + number;
		         }else { //마이패키지 코드가 없었다면
		        	 op_code = "OP" + td + "001";
		         }
				
			} catch (Exception e) {
				System.out.println("PaInfoProcDao 클래스의 getOrderOpCode() 메소드 오류 (예약코드 생성)");
				e.printStackTrace();
			} finally {
				close(rs);		close(stmt);
			}
			
			return op_code;
		}
	

	public String PaOrderInsert(String miid, OrderPaInfo op) {
		// 예약(결제)내역 PaOrderInfo에 담기
		Statement stmt = null;
		String result = op.getOp_code() + ", ";
		String sql = "insert t_order_painfo (op_code, pi_code, mi_id, fi_code, op_name, op_leave, op_period, op_spoint, " +
				"cc_id, op_customer, op_phone, op_email, op_payment, op_pay, op_adult, op_child, op_status)" +
				"values ('" + op.getOp_code() + "', '" + op.getPi_code() + "', '" + miid + "', '" + op.getFi_code() + "', '" + op.getOp_name()  + "', '" + 
				op.getOp_leave()  + "', '" + op.getOp_period()  + "', '" + op.getOp_spoint()  + "', '" + op.getCc_id() + "', '" + op.getOp_customer()  + "', '" + 
				op.getOp_phone()  + "', '" + op.getOp_email()  + "', '" + op.getOp_payment()  + "', '" + op.getOp_pay()  + "', '" + op.getOp_adult()  + "', '" + 
				op.getOp_child()  + "', 'b')";
//		System.out.println("sql : " + sql);
		int rcount = 0, target = 0;
		// rcount : 실제 쿼리 실행결과로 적용되는 레코드 개수를 누적 저장할 변수
		// target : insert, update, delete 등의 쿼리 실행 횟수로 적용되어야 할 레코드의 총 개수를 저장할 변수
		int sale = op.getOp_adult() + op.getOp_child();
		try {
			stmt = conn.createStatement();
			rcount = stmt.executeUpdate(sql);	target++;
//		System.out.println("rcount: " + rcount+ " target : " + target);
			if(rcount == 1) {		
				sql = "update t_package_info set pi_stock = pi_stock - " + sale + ", pi_sale = pi_sale + " + sale + 
						" where pi_code = '" + op.getPi_code() + "'";
//		System.out.println(" PackageProcDao 클래스의 PaOrderInsert() rcount == 1 sql : " + sql);
				rcount += stmt.executeUpdate(sql) ; target++;
		System.out.println("rcount: " + rcount+ " target : " + target);
				if(rcount == 2) {
					sql = "update t_hotel_info a, t_package_info b, t_order_painfo c set " + 
							"a.hi_stock = a.hi_stock -1, a.hi_sale = a.hi_sale + 1 " +
							"where b.hi_code = a.hi_code and c.pi_code = '" + op.getPi_code() + "' ";
//		System.out.println("PackageProcDao 클래스의 PaOrderInsert() rcount == 2 sql : " + sql);
		System.out.println("rcount: " + rcount+ " target : " + target);
					//if(rcount ==3) {
					//	sql = "insert t_admin_stat(cc_id, as_kind, as_amount, as_money) values '"
					//			+ op.getCc_id() + "', 'p', '" + (op.getOp_adult() + op.getOp_child()) + "', '" + op.getOp_pay() + "' ";
					//	System.out.println("PackageProcDao 클래스의 PaOrderInsert() rcount == 3 sql : " + sql);
					//}
				}
			}
			System.out.println("t_order_painfo insert success");
		} catch (Exception e) {
			System.out.println("PackageProcDao 클래스의 PaOrderInsert() 메소드 오류 (결제 후 예약 -t_order_painfo에 값 담기-)");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result + rcount + ", " + target;
	}
	
	
	public OrderPaInfo getOrderInfo(String miid, String opCode) {
		// 받아온 회원 아이디와 예약코드에 해당하는 정보들을 OrderPaInfo형 인스턴스에 담아 리턴하는 메소드
			Statement stmt = null;
			ResultSet rs = null;
			OrderPaInfo op = null;
			
			try {
				stmt = conn.createStatement();
				String sql = "select * from t_order_painfo where op_code = '" + opCode + "' and mi_id = '" + miid +"' ";
				rs = stmt.executeQuery(sql);
				
				// 예약코드, 상품명, 출발일자, 출발지, 도착지, 인원, 여행기간, 예약자, 연락처, 이메일, 결제수단, 금액, 결제일
				if (rs.next()) {
					op = new OrderPaInfo();
					op.setOp_code(opCode);
					op.setOp_name(rs.getString("op_name"));
					op.setOp_leave(rs.getString("op_leave"));
					op.setOp_spoint(rs.getString("op_spoint"));
					op.setCc_id(rs.getString("cc_id"));
					op.setOp_customer(rs.getString("op_customer"));
					op.setOp_period(rs.getString("op_period"));
					op.setOp_phone(rs.getString("op_phone"));
					op.setOp_email(rs.getString("op_email"));
					op.setOp_payment(rs.getString("op_payment"));
					op.setOp_pay(rs.getInt("op_pay"));
					op.setOp_adult(rs.getInt("op_adult"));
					op.setOp_child(rs.getInt("op_child"));
					op.setOp_time(rs.getString("op_time"));			
				}
				
			} catch (Exception e) {
				System.out.println("PackageProcDao 클래스의 getOrderInfo() 메소드 오류 (주문정보 불러오기)");
				e.printStackTrace();
			} finally {
				close(rs);		close(stmt);
			}
//			System.out.println("PackageProcDao 클래스의 getOrderInfo() method successs");
			return op;
		}
	
	
}

