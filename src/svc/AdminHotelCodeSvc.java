package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import com.google.gson.JsonObject;

import dao.AdminHotelProcDao;

public class AdminHotelCodeSvc {
	public JsonObject getHotelUniqueId(String ccid) {
		
		JsonObject hotelUniqueId = new JsonObject();
		
		Connection conn = getConnection();
		AdminHotelProcDao adminHotelProcDao = AdminHotelProcDao.getInstance();
		adminHotelProcDao.setConnection(conn);
		
		hotelUniqueId = adminHotelProcDao.getHotelUniqueId(ccid);
		close(conn);
		
		return hotelUniqueId;
	}
}
