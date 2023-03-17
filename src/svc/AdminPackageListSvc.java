package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPackageListSvc {
	public ArrayList<PackageInfo> getPackageList(String where, int cpage, int psize) {
		ArrayList<PackageInfo> packageList = null;
		Connection conn = getConnection();
		AdminPackageListDao adminPackageListDao = AdminPackageListDao.getInstance();
		adminPackageListDao.setConnection(conn);
		
		packageList = adminPackageListDao.getPackageList(where, cpage, psize);
		close(conn);
		
		return packageList;
	}
	
	public int getPackageListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		AdminPackageListDao adminPackageListDao = AdminPackageListDao.getInstance();
		adminPackageListDao.setConnection(conn);
		
		rcnt = adminPackageListDao.getPackageListCount(where);
		close(conn);
		
		return rcnt;
	}
}
