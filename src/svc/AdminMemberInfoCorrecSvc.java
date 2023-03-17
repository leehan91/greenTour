package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminMemberInfoCorrecSvc {
	public int memberUp(String miid, String memStatus) {
		int result = 0;
		
		Connection conn = getConnection();
		AdminMemberProcDao adminMemberProcDao = AdminMemberProcDao.getInstance();
		adminMemberProcDao.setConnection(conn);
		
		result = adminMemberProcDao.memberUp(miid, memStatus);
		if(result==1) 		commit(conn);
		else		 		rollback(conn);

		close(conn);
		
		return result;
	}

}
