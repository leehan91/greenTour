package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminStatCitySvc {
	public StatInfo getCcpaAmount(String cc, int y, int m) {
		StatInfo si = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		si = adminStatDao.getCcpaAmount(cc, y, m);
		close(conn);
		
		return si;
	}
	
	public StatInfo getCcmpAmount(String cc, int y, int m) {
		StatInfo si = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		si = adminStatDao.getCcmpAmount(cc, y, m);
		close(conn);
		
		return si;
	}
}
