package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageMainResultSvc {
	public String myPackageInsert(MyPackageMy mypackagemy, MemberInfo memberinfo, String payment) {
		Connection conn = getConnection();
		MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
		myPackageMainDao.setConnection(conn);
		String result = "";
		
		result = myPackageMainDao.myPackageInsert(mypackagemy, memberinfo, payment);
		
		String[] arr = result.split("/");
		int chk = Integer.parseInt(arr[0]);
		
		
		if(chk == 2) 	commit(conn);	// 마이패키지 인서트 , 마이패키지 오더인포 인서트 
		else			rollback(conn);
			
		close(conn);
		
		return result;	
	}
	
//	public OrderMpInfo getOmInfo(String mmcode) {
//		Connection conn = getConnection();
//		MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
//		myPackageMainDao.setConnection(conn);
//		OrderMpInfo om = null;
//		
//		om = myPackageMainDao.getOmInfo(mmcode);
//		
//		close(conn);
//		
//		return om;
//	}
}
