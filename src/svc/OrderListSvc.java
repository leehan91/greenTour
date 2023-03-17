package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrderListSvc {
	public int getOrderListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		rcnt = orderProcDao.getOrderListCount(where);
		close(conn);
		
		return rcnt;
	}
	
	public ArrayList<OrderPaInfo> getOrderList(String where, int cpage, int psize) {
		ArrayList<OrderPaInfo> orderList = new ArrayList<OrderPaInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		orderList = orderProcDao.getOrderList(where, cpage, psize);
		close(conn);
		
		return orderList;
	}
	
	public ArrayList<OrderMpInfo> getMyOrderList(String where, int cpage, int psize) {
		ArrayList<OrderMpInfo> myorderList = new ArrayList<OrderMpInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		myorderList = orderProcDao.getMyOrderList(where, cpage, psize);
		close(conn);
		
		return myorderList;
	}
	
	public ArrayList<FlightInfo> getFlightList() {
		ArrayList<FlightInfo> flightList = new ArrayList<FlightInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		flightList = orderProcDao.getFlightList();
		close(conn);
		
		return flightList;
	}
}
