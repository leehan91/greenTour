package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MileageSvc {
	public int getOrderListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		MileageProcDao mileageProcDao = MileageProcDao.getInstance();
		mileageProcDao.setConnection(conn);
		
		rcnt = mileageProcDao.getOrderListCount(where);
		close(conn);
		
		return rcnt;
	}
	
	public ArrayList<OrderPaInfo> getOrderList(String where, int cpage, int psize) {
		ArrayList<OrderPaInfo> orderList = new ArrayList<OrderPaInfo>();
		Connection conn = getConnection();
		MileageProcDao mileageProcDao = MileageProcDao.getInstance();
		mileageProcDao.setConnection(conn);
		
		orderList = mileageProcDao.getOrderList(where, cpage, psize);
		close(conn);
		
		return orderList;
	}
	
	public MemberInfo getMemberMileage(String miid) {
		MemberInfo mi = new MemberInfo();
		Connection conn = getConnection();
		MileageProcDao mileageProcDao = MileageProcDao.getInstance();
		mileageProcDao.setConnection(conn);
		
		mi = mileageProcDao.getMemberMileage(miid);
		close(conn);
		
		return mi;
	}
}
