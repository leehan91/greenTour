package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminCallDao {
	private static AdminCallDao adminCallDao;
	private Connection conn;
	private AdminCallDao() {}
	
	public static AdminCallDao getInstance() {
		
		if (adminCallDao == null)	adminCallDao = new AdminCallDao();
		
		return adminCallDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<OrderPaInfo> getOrderPaList(String miid){
		ArrayList<OrderPaInfo> opList = new ArrayList<OrderPaInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		OrderPaInfo op = null;
		
		try {
			String sql = "select a.op_code, a.op_name, a.op_leave, b.fi_entry, a.op_status, a.op_time "
					+ "from t_order_painfo a, t_flight_info b, t_package_info c "
					+ "where a.fi_code = b.fi_code and a.pi_code = c.pi_code and a.mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
					
			while (rs.next()) {
				op = new OrderPaInfo();
				op.setOp_code(rs.getString("op_code"));
				op.setOp_name(rs.getString("op_name"));
				op.setOp_leave(rs.getString("op_leave"));
				op.setFi_entry(rs.getString("fi_entry"));
				op.setOp_status(rs.getString("op_status"));
				op.setOp_time(rs.getString("op_time"));
				opList.add(op);
			}
			
		}catch (Exception e) {
			System.out.println("AdminCallDao 클래스의 getOrderPaInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		
		
		return opList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
