package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminStatCalPaySvc {
	public StatInfo getPaStat(int y, int m) {
		StatInfo stat = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		stat = adminStatDao.getPaStat(y, m);
		close(conn);
		
		return stat;
	}
	
	public StatInfo getMpStat(int y, int m) {
		StatInfo stat = new StatInfo();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		stat = adminStatDao.getMpStat(y, m);
		close(conn);
		
		return stat;
	}
	
	public ArrayList<StatInfo> getPalistStat(int y, int sm, int em) {
		ArrayList<StatInfo> stat = new ArrayList<StatInfo>();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		stat = adminStatDao.getPaListStat(y, sm, em);
		close(conn);
		
		return stat;
	}	

	public ArrayList<StatInfo> getMplistStat(int y, int sm, int em) {
		ArrayList<StatInfo> stat = new ArrayList<StatInfo>();
		Connection conn = getConnection();
		AdminStatDao adminStatDao = AdminStatDao.getInstance();
		adminStatDao.setConnection(conn);
		
		stat = adminStatDao.getPaListStat(y, sm, em);
		close(conn);
		
		return stat;
	}		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
