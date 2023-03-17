package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MileageProcDao {
	private static MileageProcDao mileageProcDao;
	private Connection conn;
	private MileageProcDao() {}
	
	public static MileageProcDao getInstance() {
		
		if (mileageProcDao == null)	mileageProcDao = new MileageProcDao();
		
		return mileageProcDao;
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
			System.out.println("MileageProcDao 클래스의 getOrderListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return rcnt;
	}
	
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
			System.out.println("MileageProcDao 클래스의 getOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return orderList;
	}
	
	public MemberInfo getMemberMileage(String miid) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo mi = null;
		
		try {
			String sql = "select * from t_member_info where mi_id = '"+ miid +"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				mi = new MemberInfo();
				mi.setMi_mileage(rs.getInt("mi_mileage"));
			}
			
		} catch (Exception e) {
			System.out.println("MileageProcDao 클래스의 getMemberMileage() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return mi;
	}
}
