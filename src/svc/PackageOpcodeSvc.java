package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PackageOpcodeSvc {
	// �����ڵ� ���� PackageReservForPayCrtl
	public String packgeOpcodeNew() {
		String result = null;
		Connection conn = getConnection();
		PackageReservDao packageReservDao = PackageReservDao.getInstance();
		packageReservDao.setConnection(conn);
		
		result = packageReservDao.packgeOpcodeNew();
		close(conn);
		
		return result;
	}
}
