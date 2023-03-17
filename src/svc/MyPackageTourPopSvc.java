package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageTourPopSvc {
	public PackageTour getTourInfo (String ptcode) {
	Connection conn = getConnection();
	PopDao popDao = PopDao.getInstance();
	popDao.setConnection(conn);
	
	PackageTour pt = new PackageTour();
	pt = popDao.getTourInfo(ptcode);
	
	close(conn);
	
	return pt;
	}
}
