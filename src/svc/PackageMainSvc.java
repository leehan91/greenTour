package svc;

import static db.JdbcUtil.*;
import java.util.*;

import com.google.gson.JsonArray;

import java.sql.*;
import dao.*;
import vo.*;

public class PackageMainSvc {
	public ArrayList<PackageInfo> getPackageSuggest(String ccid) {
		ArrayList<PackageInfo> pi = new ArrayList<PackageInfo>();
		Connection conn = getConnection();
		PackageProcDao packgeProcDao = PackageProcDao.getInstance();
		packgeProcDao.setConnection(conn);
		
		pi = packgeProcDao.getPackageSuggest(ccid);
		close(conn);
		
		return pi;
	}

	public ArrayList<PackageInfo> getPackageSlide(String ccid) {
		ArrayList<PackageInfo> pi2 = new ArrayList<PackageInfo>();
		Connection conn = getConnection();
		PackageProcDao packgeProcDao = PackageProcDao.getInstance();
		packgeProcDao.setConnection(conn);
		
		pi2 = packgeProcDao.getPackageSlide(ccid);
		close(conn);
		
		return pi2;
	}
	
	
	/*
	 * public ArrayList<PackageDate> getPackageMainList(String ccid) {
	 * ArrayList<PackageDate> pdList = new ArrayList<PackageDate>(); Connection conn
	 * = getConnection(); PackageProcDao packageProcDao =
	 * PackageProcDao.getInstance(); packageProcDao.setConnection(conn);
	 * 
	 * pdList = packageProcDao.getPackageMainList(ccid); close(conn);
	 * 
	 * return pdList; }
	 */
	
}
