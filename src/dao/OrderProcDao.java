package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class OrderProcDao {
	private static OrderProcDao orderProcDao;
	private Connection conn;
	private OrderProcDao() {}
	
	public static OrderProcDao getInstance() {
		
		if (orderProcDao == null)	orderProcDao = new OrderProcDao();
		
		return orderProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getOrderListCount(String where) {
			int rcnt = 0;
			Statement stmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "select count(*) from t_order_painfo " + where;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next())		rcnt = rs.getInt(1);
				
			} catch (Exception e) {
				System.out.println("OrderProcDao 클래스의 getOrderListCount() 메소드 오류");
				e.printStackTrace();
			} finally {
				close(rs);		close(stmt);
			}
			
			return rcnt;
		}
	// My 예약 정보를 불러오기 위한 sql 실행문
	public ArrayList<OrderPaInfo> getOrderList(String where, int cpage, int psize) {
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<OrderPaInfo> orderList = new ArrayList<OrderPaInfo>();
			OrderPaInfo op = null;		// orderList에 저장할 하나의 게시글 정보를 담을 인스턴스
			
			try {
				String sql = "select * from t_order_painfo " + where + " order by op_code desc limit " 
						+ ((cpage - 1) * psize) + ", " + psize;
				System.out.println(sql);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					op = new OrderPaInfo();
					op.setMi_id(rs.getString("mi_id"));
					op.setFi_code(rs.getString("fi_code"));
					op.setOp_time(rs.getString("op_time"));
					op.setOp_code(rs.getString("op_code"));
					op.setOp_name(rs.getString("op_name"));
					op.setOp_leave(rs.getString("op_leave"));
					op.setOp_period(rs.getString("op_period"));
					op.setOp_pay(rs.getInt("op_pay"));
					op.setOp_adult(rs.getInt("op_adult"));
					op.setOp_child(rs.getInt("op_child"));
					op.setOp_status(rs.getString("op_status"));
					orderList.add(op);
				}
				System.out.println(orderList.size());
			} catch (Exception e) {
				System.out.println("OrderProcDao 클래스의 getOrderList() 메소드 오류");
				e.printStackTrace();
			} finally {
				close(rs);		close(stmt);
			}
			
			return orderList;
		}
	
	public ArrayList<OrderMpInfo> getMyOrderList(String where, int cpage, int psize) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderMpInfo> myorderList = new ArrayList<OrderMpInfo>();
		OrderMpInfo om = null;
		
		try {
			String sql = "select * from t_order_mpinfo " + where + " order by om_code desc limit " 
					+ ((cpage - 1) * psize) + ", " + psize;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				om = new OrderMpInfo();
				om.setOm_code(rs.getString("om_code"));
				om.setOm_time(rs.getString("om_time"));
				om.setOm_name(rs.getString("om_name"));
				om.setOm_leave(rs.getString("om_leave"));
				om.setOm_arrive(rs.getString("om_arrive"));
				om.setOm_pay(rs.getInt("om_pay"));
				om.setOm_status(rs.getString("om_status"));
				myorderList.add(om);
			}
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getMyOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		
		return myorderList;
		
	}
	
	// My 예약 정보에서 항공 정보(출국일, 입국일)를 불러오기 위한 sql 실행문
	public ArrayList<FlightInfo> getFlightList() {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<FlightInfo> flightList = new ArrayList<FlightInfo>();
		FlightInfo fi = null;		// orderList에 저장할 하나의 게시글 정보를 담을 인스턴스
		
		try {
			String sql = "select a.* from t_flight_info a, t_order_painfo b " + 
					"where a.fi_code = b.fi_code";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				fi = new FlightInfo();
				fi.setFi_departure(rs.getString("fi_departure"));
				fi.setFi_entry(rs.getString("fi_entry"));
				flightList.add(fi);
			}
			System.out.println(flightList.size());
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getFlightList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return flightList;
	}
	// 예약 취소 폼에서 예약한 정보를 불러오기 위한 sql문
	public ArrayList<OrderPaInfo> getCancelOrderList(String where, String code) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderPaInfo> orderCancelList = new ArrayList<OrderPaInfo>();
		OrderPaInfo op = null;		// orderList에 저장할 하나의 게시글 정보를 담을 인스턴스
		
		try {
			String sql = "select * from t_order_painfo " + where + " and op_code = '"+ code +"'";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				op = new OrderPaInfo();
				op.setMi_id(rs.getString("mi_id"));
				op.setFi_code(rs.getString("fi_code"));
				op.setOp_time(rs.getString("op_time"));
				op.setOp_code(rs.getString("op_code"));
				op.setOp_name(rs.getString("op_name"));
				op.setOp_leave(rs.getString("op_leave"));
				op.setOp_period(rs.getString("op_period"));
				op.setOp_pay(rs.getInt("op_pay"));
				op.setOp_customer(rs.getString("op_customer"));
				op.setOp_adult(rs.getInt("op_adult"));
				op.setOp_child(rs.getInt("op_child"));
				op.setOp_status(rs.getString("op_status"));
				orderCancelList.add(op);
			}
			System.out.println(orderCancelList.size());
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getCancelOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return orderCancelList;
	}
	
	public ArrayList<OrderMpInfo> getMyCancelOrderList(String where, String code) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderMpInfo> orderMyCancelList = new ArrayList<OrderMpInfo>();
		OrderMpInfo om = null;		// orderList에 저장할 하나의 게시글 정보를 담을 인스턴스
		
		try {
			String sql = "select * from t_order_mpinfo " + where + " and om_code = '"+ code +"'";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				om = new OrderMpInfo();
				om.setMi_id(rs.getString("mi_id"));
				om.setOm_code(rs.getString("om_code"));
				om.setOm_time(rs.getString("om_time"));
				om.setOm_name(rs.getString("om_name"));
				om.setOm_customer(rs.getString("om_customer"));
				om.setOm_leave(rs.getString("om_leave"));
				om.setOm_arrive(rs.getString("om_arrive"));
				om.setOm_pay(rs.getInt("om_pay"));
				om.setOm_phone(rs.getString("om_phone"));
				om.setOm_status(rs.getString("om_status"));
				orderMyCancelList.add(om);
			}
			System.out.println(orderMyCancelList.size());
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getMyCancelOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return orderMyCancelList;
	}
}
