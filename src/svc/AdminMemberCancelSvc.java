package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminMemberCancelSvc {
	public int memReserveUP(String miid, String code) {
		int result = 0;
		Connection conn = getConnection();
		AdminMemberProcDao adminMemberProcDao = AdminMemberProcDao.getInstance();
		adminMemberProcDao.setConnection(conn);
		
		result = adminMemberProcDao.memReserveUP(miid, code);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
