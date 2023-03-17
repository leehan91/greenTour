package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageMainAirSvc {

	public ArrayList<FlightInfo> getAirList(String city, String sdate, String edate){
		ArrayList<FlightInfo> airList = new ArrayList<FlightInfo>();
		
		Connection conn = getConnection();
		MyPackageMainDao mypackageMainDao = MyPackageMainDao.getInstance();
		mypackageMainDao.setConnection(conn);
		
		airList = mypackageMainDao.getAirList(city, sdate, edate);
		close(conn);
		
		return airList;
	
	}
	
	public String getCcid(String city) {
		String ccid = "";
		
		Connection conn = getConnection();
		MyPackageMainDao mypackageMainDao = MyPackageMainDao.getInstance();
		mypackageMainDao.setConnection(conn);
		
		ccid = mypackageMainDao.getCcid(city);
		close(conn);
		
		return ccid;
		
	}
}