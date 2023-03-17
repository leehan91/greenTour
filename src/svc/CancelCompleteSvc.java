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
		if(result == 2) 	commit(conn);	// 취소요청 게시판 인서트, 패키지 주문정보 주문상태 업데이트 다 되면 2를 리턴. 
		else				rollback(conn);
		
		
		close(conn);
		
		return result;
	}
}
