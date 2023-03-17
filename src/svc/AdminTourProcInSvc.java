package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminTourProcInSvc {
	public int TourProcIn(PackageTour pt) {
		int result = 0;
		
		Connection conn = getConnection();
		AdminTourProcDao myPackageProcDao = AdminTourProcDao.getInstance();
		myPackageProcDao.setConnection(conn);
		
		result = myPackageProcDao.TourProcIn(pt);
		if (result == 1 )		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}

	public int TourProcup(PackageTour pt) {
		int result = 0;
		
		Connection conn = getConnection();
		AdminTourProcDao myPackageProcDao = AdminTourProcDao.getInstance();
		myPackageProcDao.setConnection(conn);
		
		result = myPackageProcDao.TourProcUp(pt);
		if (result == 1 )		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}
}
