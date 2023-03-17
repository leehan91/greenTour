package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PaOrderEndSvc {
	public OrderPaInfo getOrderInfo(String miid, String opCode) {
		OrderPaInfo op = null;
		Connection conn = getConnection();
		PackageReservDao packageReservDao = PackageReservDao.getInstance();
		packageReservDao.setConnection(conn);
		
		op = packageReservDao.getOrderInfo(miid, opCode);
		close(conn);
		
		return op;
	}		
}
