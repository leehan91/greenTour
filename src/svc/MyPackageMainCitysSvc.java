package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageMainCitysSvc {
	
	public ArrayList<CtgrCity> getCityList(String nation){
		ArrayList<CtgrCity> cityList = new ArrayList<CtgrCity>();
		
		Connection conn = getConnection();
		MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
		myPackageMainDao.setConnection(conn);
		
		cityList = myPackageMainDao.getCityList(nation);
		close(conn);
		
		return cityList;
		
	}
}
