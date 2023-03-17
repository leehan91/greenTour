package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageMainHotelSvc {
	public ArrayList<HotelInfo> getHotelList(String ccid){
		ArrayList<HotelInfo> hotelList = new ArrayList<HotelInfo>();
		
		Connection conn = getConnection();
		MyPackageMainDao myPackageMainDao = MyPackageMainDao.getInstance();
		myPackageMainDao.setConnection(conn);
		
		hotelList = myPackageMainDao.getHotelList(ccid);
		close(conn);
		
		return hotelList;
	
	}
}
