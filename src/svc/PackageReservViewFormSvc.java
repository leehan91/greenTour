package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PackageReservViewFormSvc {
	// 예약하기 폼에 해당 상품 값 불러오기 PackageReservTestCtrl
	public PackageInfo getViewList(String piCode, String departure) {
		PackageInfo pi = new PackageInfo();
		Connection conn = getConnection();
		PackageReservDao packageReservDao = PackageReservDao.getInstance();
		packageReservDao.setConnection(conn);
		
		pi = packageReservDao.getViewList(piCode, departure);
		close(conn);
		
		return pi;
	}
}


