package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminHotelListSvc {
	public int getHotelListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		AdminHotelProcDao adminHotelProcDao = AdminHotelProcDao.getInstance();
		adminHotelProcDao.setConnection(conn);
		
		rcnt = adminHotelProcDao.getHotelListCount(where);
		close(conn);
		
		return rcnt;
	}
		
	public ArrayList<HotelInfo> getHotelList(String where, int cpage, int psize) {
		ArrayList<HotelInfo> hotelList = new ArrayList<HotelInfo>();
		Connection conn = getConnection();
		AdminHotelProcDao adminHotelProcDao = AdminHotelProcDao.getInstance();
		adminHotelProcDao.setConnection(conn);
		
		hotelList = adminHotelProcDao.getHotelList(where, cpage, psize);
		close(conn);
		
		return hotelList;
	}
}
