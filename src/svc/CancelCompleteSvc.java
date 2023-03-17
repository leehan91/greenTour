package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CancelCompleteSvc {
	public int insertPacancel(String ctgr, String content, String code) {
		ArrayList<MemberPaCancel> pacancelList = new ArrayList<MemberPaCancel>();
		Connection conn = getConnection();
		CancelProcDao cancelProcDao = CancelProcDao.getInstance();
		cancelProcDao.setConnection(conn);
		
		int result = cancelProcDao.insertPacancel(ctgr, content, code);
		if(result == 2) 	commit(conn);	// ��ҿ�û �Խ��� �μ�Ʈ, ��Ű�� �ֹ����� �ֹ����� ������Ʈ �� �Ǹ� 2�� ����. 
		else				rollback(conn);
		
		
		close(conn);
		
		return result;
	}
}
