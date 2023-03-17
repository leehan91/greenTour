package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageEndSvc {
	public OrderMpInfo getOmInfo(String omcode) {
		
		
		Connection conn = getConnection();
		MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
		myPackageMainDao.setConnection(conn);
		
		OrderMpInfo orderMpInfo = myPackageMainDao.getOmInfo(omcode);
		
		close(conn);
		
		return orderMpInfo;
	}
}
