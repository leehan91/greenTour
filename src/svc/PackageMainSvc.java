package svc;

import static db.JdbcUtil.*;
import java.util.*;

import com.google.gson.JsonArray;

import java.sql.*;
import dao.*;
import vo.*;

public class PackageMainSvc {
	public JsonArray getPackageMainCount(String ccid, String gbn) {
		
		JsonArray packageMain = new JsonArray();
		
		Connection conn = getConnection();
		PackageProcDao packgeProcDao = PackageProcDao.getInstance();
		packgeProcDao.setConnection(conn);
		
		packageMain = packgeProcDao.getPackageMainCount(ccid, gbn);
		close(conn);
		
		return packageMain;
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
