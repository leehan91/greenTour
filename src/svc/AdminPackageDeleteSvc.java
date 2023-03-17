package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPackageDeleteSvc {
	public int deletePackage(String picode) {
		int result = 0;
		Connection conn = getConnection();
		AdminPackageDeleteDao adminPackageDeleteDao = AdminPackageDeleteDao.getInstance();
		adminPackageDeleteDao.setConnection(conn);
		
		result = adminPackageDeleteDao.deletePackage(picode);
		if (result == 1)		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}
}
