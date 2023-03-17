package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageMainTourSvc {
	public ArrayList<PackageTour> getTourList(String ccid){
		ArrayList<PackageTour> tourList = new ArrayList<PackageTour>();
		
		Connection conn = getConnection();
		MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
		myPackageMainDao.setConnection(conn);
		
		tourList = myPackageMainDao.getTourList(ccid);
		close(conn);
		
		return tourList;
	}
}
