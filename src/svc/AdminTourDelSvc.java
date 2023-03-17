package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminTourDelSvc {
	public int tourDelete(String where) {
		int result = 0;
		Connection conn = getConnection();
		AdminTourProcDao adminTourProcDao = AdminTourProcDao.getInstance();
		adminTourProcDao.setConnection(conn);
		
		
		result = adminTourProcDao.tourDelete(where);
		
		if (result >= 1)		commit(conn);
		// ���� ���� ��ǰ�� ������ ���� �����Ƿ�
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
