package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PackageDetailSvc {
	public PackageInfo getDetailInfo(String picode) {
		PackageInfo pi = null;
		Connection conn = getConnection();
		PackageProcDao packageProcDao = PackageProcDao.getInstance();
		packageProcDao.setConnection(conn);
		
		pi = packageProcDao.getDetailInfo(picode);
		close(conn);
		
		return pi;
	}
	
	public FlightInfo getFlightInfo(String picode, String fideparture, String fientry, String frname) {
		FlightInfo fi = null;
		Connection conn = getConnection();
		PackageProcDao packageProcDao = PackageProcDao.getInstance();
		packageProcDao.setConnection(conn);
		
		fi = packageProcDao.getFlightInfo(picode, fideparture, fientry, frname);
		close(conn);
		
		return fi;
	}
}
