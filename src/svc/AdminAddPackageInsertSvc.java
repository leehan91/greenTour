package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminAddPackageInsertSvc {
	public int insertPackage(PackageInfo pi){
		int result = 0;
		Connection conn = getConnection();
		AdminAddPackageFormDao adminAddPackageFormDao = AdminAddPackageFormDao.getInstance();
		adminAddPackageFormDao.setConnection(conn);
		
		result = adminAddPackageFormDao.insertPackage(pi);
		if(result==1) commit(conn);
		else		  rollback(conn);
		close(conn);
		
		return result;
	
	}
	
	
	public int excuteProcedure(PackageInfo pi, String adminId) {
		int result = 0;
		Connection conn = getConnection();
		AdminAddPackageFormDao adminAddPackageFormDao = AdminAddPackageFormDao.getInstance();
		adminAddPackageFormDao.setConnection(conn);
		
		result = adminAddPackageFormDao.excuteProcedure(pi, adminId);
		commit(conn);
		
		close(conn);
		
		
		return result;
	}

}
