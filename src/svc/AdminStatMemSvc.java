package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminStatMemSvc {
	public StatInfo getMemStat() {
		StatInfo member = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		member = adminStatDao.getMemStat();
		close(conn);
		
		return member;
	}
	
	public StatInfo getMemAStat() {
		StatInfo memberA = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		memberA = adminStatDao.getMemAStat();
		close(conn);
		
		return memberA;
	}
	
	public StatInfo getMemBStat() {
		StatInfo memberB = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		memberB = adminStatDao.getMemBStat();
		close(conn);
		
		return memberB;
	}
	
	public StatInfo getMemDStat() {
		StatInfo memberD = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		memberD = adminStatDao.getMemDStat();
		close(conn);
		
		return memberD;
	}
	
	
	
	
}
