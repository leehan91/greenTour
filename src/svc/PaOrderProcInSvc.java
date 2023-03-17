package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PaOrderProcInSvc {
	public String orderInsert(String miid, OrderPaInfo op) {
		String result = null;
		Connection conn = getConnection();
		PackageReservDao packageReservDao = PackageReservDao.getInstance();
		packageReservDao.setConnection(conn);
		
		result = packageReservDao.PaOrderInsert(miid, op);	
		String[] arr = result.split(",");
		if (arr[1].equals(arr[2]))		commit(conn);
		// 실제 적용된 레코드 개수와 적용되어야 할 레코드 개수가 같으면
		else							rollback(conn);
		close(conn);
		close(conn);
		
		return result;
	}

}
