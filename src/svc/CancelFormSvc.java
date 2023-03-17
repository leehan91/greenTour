package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CancelFormSvc {
	public ArrayList<OrderPaInfo> getCancelOrderList(String where, String code) {
		ArrayList<OrderPaInfo> orderCancelList = new ArrayList<OrderPaInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		orderCancelList = orderProcDao.getCancelOrderList(where, code);
		close(conn);
		
		return orderCancelList;
	}
	
	public ArrayList<OrderMpInfo> getMyCancelOrderList(String where, String code) {
		ArrayList<OrderMpInfo> orderMyCancelList = new ArrayList<OrderMpInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		orderMyCancelList = orderProcDao.getMyCancelOrderList(where, code);
		close(conn);
		
		return orderMyCancelList;
	}
}
