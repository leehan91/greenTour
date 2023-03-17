package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPackageHotelPopSvc {
	public HotelInfo getHotelInfo (String hicode) {
		Connection conn = getConnection();
		PopDao popDao = PopDao.getInstance();
		popDao.setConnection(conn);
		
		HotelInfo hi = new HotelInfo();
		hi = popDao.getHotelInfo(hicode);
		
		close(conn);
		
		return hi;		
		
	}
	
}
