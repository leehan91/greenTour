package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPackageInfoSvc {
	public PackageInfo getPackageInfo(String where, String picode) {
		PackageInfo pai = null;
		Connection conn = getConnection();
		AdminPackageListDao adminPackageListDao = AdminPackageListDao.getInstance();
		adminPackageListDao.setConnection(conn);
		
		pai = adminPackageListDao.getPackageInfo(where, picode);
		close(conn);
		
		return pai;
	}
}
