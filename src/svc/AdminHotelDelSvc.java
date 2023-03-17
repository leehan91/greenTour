package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.AdminHotelProcDao;

public class AdminHotelDelSvc {
	public int hotelDelete(String hicodeList) {
		int result = 0;
		Connection conn = getConnection();
		AdminHotelProcDao adminHotelProcDao = AdminHotelProcDao.getInstance();
		adminHotelProcDao.setConnection(conn);
		
		
		String[] arr = hicodeList.split("\\|");
		for(int i=0;i<arr.length;i++) {
			System.out.println("hicode: "+arr[i]);
			result += adminHotelProcDao.hotelDelete(arr[i]);
		}
		
		if (result > 0)		commit(conn);
		// 여러 개의 상품을 삭제할 수도 있으므로
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
