package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PareviewProcInSvc {
	public int PareviewInsert(CsPareview cpl) {
		int result = 0;
		Connection conn = getConnection();
		PareviewProcInDao pareviewProcInDao = PareviewProcInDao.getInstance();
		pareviewProcInDao.setConnection(conn);
		
		result = pareviewProcInDao.PareviewInsert(cpl);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		// 사용한 쿼리가 insert, update, delete일 경우 반드시 트랜잭션을 완료해야 함
		close(conn);
		
		return result;
	}
}
