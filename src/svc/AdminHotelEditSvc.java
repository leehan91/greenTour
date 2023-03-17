package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.AdminHotelProcDao;
import vo.HotelInfo;

public class AdminHotelEditSvc {
	public HotelInfo getHotelInfo(String hicode) {
		Connection conn = getConnection();
		AdminHotelProcDao adminHotelProcDao = AdminHotelProcDao.getInstance();
		adminHotelProcDao.setConnection(conn);
		
		HotelInfo hi = adminHotelProcDao.getHotelInfo(hicode);
		close(conn);
		
		return hi;
	}
}
