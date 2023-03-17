package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import dao.AdminHotelProcDao;

public class AdminHotelUpSvc {
	public int getHotelUpdate(HttpServletRequest request) {
		Connection conn = getConnection();
		AdminHotelProcDao adminHotelProcDao = AdminHotelProcDao.getInstance();
		adminHotelProcDao.setConnection(conn);
		
		int result = adminHotelProcDao.getHotelUpdate(request);
		
		if (result == 1)		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}
}
