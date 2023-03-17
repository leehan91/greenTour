package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminStatListSvc {
	public ArrayList<StatInfo> getPaList(int y, int m) {
		// 날짜와 코드를 저장할 ArrayList
		ArrayList<StatInfo> dateList = new ArrayList<StatInfo>();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		dateList = adminStatDao.getPaList(y, m);
		close(conn);
		
		return dateList;
	}
	
	public ArrayList<StatInfo> getMpList(int y, int m) {
		ArrayList<StatInfo> dateList = new ArrayList<StatInfo>();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		dateList = adminStatDao.getMpList(y, m);
		close(conn);
		
		return dateList;
	}
	
	
	
}
