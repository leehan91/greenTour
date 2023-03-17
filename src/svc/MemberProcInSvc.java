package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberProcInSvc {
	public int memberProcIn(MemberInfo memberInfo) {
		int result = 0;
		Connection conn = getConnection();
		MemberProcInDao memberProcInDao = MemberProcInDao.getInstance();
		memberProcInDao.setConnection(conn);
		
		result = memberProcInDao.memberProcIn(memberInfo);
		if (result == 2)	commit(conn);
		else				rollback(conn);
		// 사용한 쿼리가 insert, update, delete 일 경우 반드시 트랜젝션을 완료해야 함
		close(conn);
		
		return result;
	}
}
