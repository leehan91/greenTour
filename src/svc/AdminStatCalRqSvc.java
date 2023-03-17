package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminStatCalRqSvc {
	public StatInfo getRq(int y, int m) {
		StatInfo rq = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		rq = adminStatDao.getRq(y, m);
		close(conn);
		
		return rq;
	}
	
	public StatInfo getRqYes(int y, int m) {
		StatInfo rqYes = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		rqYes = adminStatDao.getRqYes(y, m);
		close(conn);
		
		return rqYes;
	}
	
	public StatInfo getRqNo(int y, int m) {
		StatInfo rqNo = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		rqNo = adminStatDao.getRqNo(y, m);
		close(conn);
		
		return rqNo;
	}
	
}