package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class SchPwSvc {
	public static MemberInfo getSchPw(String uid, String name, String regist) {
		Connection conn = getConnection();
		SchProcDao schProcDao = SchProcDao.getInstance();
		schProcDao.setConnection(conn);
		
		MemberInfo mi = schProcDao.getSchPw(uid, name, regist);
		close(conn);
		
		return mi;
	}
}
