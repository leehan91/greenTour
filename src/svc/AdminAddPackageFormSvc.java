package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminAddPackageFormSvc {
	public ArrayList<CtgrCity> getCtgrCity(){
		ArrayList<CtgrCity> cityList = new ArrayList<CtgrCity>();
		
		Connection conn = getConnection();
		AdminAddPackageFormDao adminAddPackageFormDao = AdminAddPackageFormDao.getInstance();
		adminAddPackageFormDao.setConnection(conn);
		
		cityList = adminAddPackageFormDao.getCtgrCity();
		close(conn);
		
		return cityList;
	
	}
	
	public ArrayList<HotelInfo> getHotelList(){
		ArrayList<HotelInfo> hotelList = new ArrayList<HotelInfo>();
		
		Connection conn = getConnection();
		AdminAddPackageFormDao adminAddPackageFormDao = AdminAddPackageFormDao.getInstance();
		adminAddPackageFormDao.setConnection(conn);
		
		hotelList = adminAddPackageFormDao.getHotelList();
		close(conn);
		
		return hotelList;
	
	}
	
	public ArrayList<FlightRealPrice> getFrpList(){
		ArrayList<FlightRealPrice> frpList = new ArrayList<FlightRealPrice>();
		
		Connection conn = getConnection();
		AdminAddPackageFormDao adminAddPackageFormDao = AdminAddPackageFormDao.getInstance();
		adminAddPackageFormDao.setConnection(conn);
		
		frpList = adminAddPackageFormDao.getFrpList();
		close(conn);
		
		return frpList;
		
	}
}
