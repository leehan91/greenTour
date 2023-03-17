package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminTourUpSvc {
	public PackageTour getTour(String ptcode) {
	Connection conn = getConnection();
	AdminTourProcDao adminTourProcDao = AdminTourProcDao.getInstance();
	adminTourProcDao.setConnection(conn);
	
	PackageTour pt = adminTourProcDao.getTour(ptcode);
	
	close(conn);
	return pt;
	}
}
