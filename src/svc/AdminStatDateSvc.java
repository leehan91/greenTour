package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminStatDateSvc {
	public ArrayList<StatInfo> getpaList(int y, int m) {
		ArrayList<StatInfo> dateList = new ArrayList<StatInfo>();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		dateList = adminStatDao.getpaList(y, m);
		close(conn);
		
		return dateList;
	}
	
	public ArrayList<StatInfo> getmpList(int y, int m) {
		ArrayList<StatInfo> dateList = new ArrayList<StatInfo>();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		dateList = adminStatDao.getmpList(y, m);
		close(conn);
		
		return dateList;
	}
	
	
	
}
