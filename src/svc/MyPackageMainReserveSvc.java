package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageMainReserveSvc {
	public String getMmCode(String city3) {
	
	String mmcode = "";
	Connection conn = getConnection();
	MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
	myPackageMainDao.setConnection(conn);
	
	mmcode = myPackageMainDao.getMmCode(city3);
	close(conn);
	
	return mmcode;
	}
}
