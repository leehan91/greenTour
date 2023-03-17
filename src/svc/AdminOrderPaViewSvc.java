package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminOrderPaViewSvc {
	public ArrayList<OrderPaInfo> getOrderPaList(String miid) {
		ArrayList<OrderPaInfo> opList = null;
		Connection conn = getConnection();
		AdminCallDao adminCallDao = AdminCallDao.getInstance();
		adminCallDao.setConnection(conn);
		
		opList = adminCallDao.getOrderPaList(miid);
		close(conn);
		
		return opList;
	}
}
