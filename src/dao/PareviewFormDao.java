package dao;

import static db.JdbcUtil.*;	
import java.util.*;

import java.sql.*;
import vo.*;

public class PareviewFormDao {
	private static PareviewFormDao pareviewFormDao;
	private Connection conn;
	private PareviewFormDao() {}
	public static PareviewFormDao getInstance() {
		if (pareviewFormDao == null)	pareviewFormDao = new PareviewFormDao();
		return pareviewFormDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<OrderPaInfo> getPareviewForm(String miid) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderPaInfo> opList = new ArrayList<OrderPaInfo>();
		OrderPaInfo op = null;
		try {
			String sql = "select * from t_order_painfo where op_review = 'n' and mi_id='" + miid + "'";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				op = new OrderPaInfo();
				op.setOp_name(rs.getString("op_name"));
				op.setOp_code(rs.getString("op_code"));
				op.setMi_id(rs.getString("mi_id"));
				op.setOp_customer(rs.getString("op_customer"));
				opList.add(op);
			}
		} catch (Exception e) {
			System.out.println("PareviewFormDao 클래스의 getPareviewForm() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return opList;
	}
	
}
