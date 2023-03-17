package svc;

import static db.JdbcUtil.*;
import java.util.*;

import com.google.gson.JsonArray;

import java.sql.*;
import dao.*;
import vo.*;

public class PackageListSvc {
	public ArrayList<PackageDate> getPackageListCount(String picode) {
		ArrayList<PackageDate> pdList = new ArrayList<PackageDate>();
		Connection conn = getConnection();
		PackageProcDao packageProcDao = PackageProcDao.getInstance();
		packageProcDao.setConnection(conn);
		
		pdList = packageProcDao.getPackageListCount(picode);
		close(conn);
		
		return pdList;
	}

	public JsonArray getPackageDateList(String picode, String fiDeparture) {
		
		JsonArray packageList = new JsonArray();
		
		Connection conn = getConnection();
		PackageProcDao packgeProcDao = PackageProcDao.getInstance();
		packgeProcDao.setConnection(conn);
		
		packageList = packgeProcDao.getPackageDateList(picode, fiDeparture);
		close(conn);
		
		return packageList;
	}
}
