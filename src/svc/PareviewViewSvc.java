package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.*;
import vo.*;

public class PareviewViewSvc {
	public int readUpdate(int cpidx) {
		int result = 0;
		Connection conn = getConnection();
		PareviewViewDao pareviewViewDao = PareviewViewDao.getInstance();
		pareviewViewDao.setConnection(conn);
		
		result = pareviewViewDao.readUpdate(cpidx);
		if (result == 1)		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}
	
	public CsPareview getPareviewInfo(int cpidx) {
		CsPareview cp = null;
		Connection conn = getConnection();
		PareviewViewDao pareviewViewDao = PareviewViewDao.getInstance();
		pareviewViewDao.setConnection(conn);
		
		cp = pareviewViewDao.getPareviewView(cpidx);
		close(conn);
		
		return cp;
	}
}
