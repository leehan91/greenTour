package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class IndexSvc {
	public ArrayList<PackageInfo> getPackageOut(){
		ArrayList<PackageInfo> piList = new ArrayList<PackageInfo>();
		Connection conn = getConnection();
		IndexDao packageOutDao = IndexDao.getInstance();
		packageOutDao.setConnection(conn);
		
		piList = packageOutDao.getPackageOut();
		close(conn);
		
		return piList;
	}
	public ArrayList<PackageInfo> getPackageOut2(){
		ArrayList<PackageInfo> piList2 = new ArrayList<PackageInfo>();
		Connection conn = getConnection();
		IndexDao packageOutDao = IndexDao.getInstance();
		packageOutDao.setConnection(conn);
		
		piList2 = packageOutDao.getPackageOut2();
		close(conn);
		
		return piList2;
	}
}
