package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PareviewProcInSvc {
	public int PareviewInsert(CsPareview cp) {
		int result = 0;
		Connection conn = getConnection();
		PareviewProcInDao pareviewProcInDao = PareviewProcInDao.getInstance();
		pareviewProcInDao.setConnection(conn);
		
		result = pareviewProcInDao.PareviewInsert(cp);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		result = 0; 
		result = pareviewProcInDao.PareviewUpdate(cp);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		// ����� ������ insert, update, delete�� ��� �ݵ�� Ʈ������� �Ϸ��ؾ� ��
		close(conn);
		
		return result;
	}
}
