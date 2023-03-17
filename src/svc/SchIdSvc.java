package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class SchIdSvc {
	public static MemberInfo getSchId(String name, String regist) {
		Connection conn = getConnection();
		SchProcDao schProcDao = SchProcDao.getInstance();
		schProcDao.setConnection(conn);
		
		MemberInfo mi = schProcDao.getSchId(name, regist);
		close(conn);
		
		return mi;
	}
}
