package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPackageUpSvc {
	public PackageInfo getPackageInfo(String picode) {
		PackageInfo pi = null;
		Connection conn = getConnection();
		AdminPackageUpDao adminPackageUpDao = AdminPackageUpDao.getInstance();
		adminPackageUpDao.setConnection(conn);
		
		pi = adminPackageUpDao.getPackageInfo(picode);
		close(conn);
		
		return pi;
	}
	
	public ArrayList<FlightRealPrice> getFrpList(){
		ArrayList<FlightRealPrice> frpList = new ArrayList<FlightRealPrice>();
		
		Connection conn = getConnection();
		AdminAddPackageFormDao adminAddPackageFormDao = AdminAddPackageFormDao.getInstance();
		adminAddPackageFormDao.setConnection(conn);
		
		frpList = adminAddPackageFormDao.getFrpList();
		close(conn);
		
		return frpList;
		
	}
}
