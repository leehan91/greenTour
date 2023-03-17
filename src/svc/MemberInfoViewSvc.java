package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberInfoViewSvc {
	public MemberInfo getMemberInfo(String miid) {
		MemberInfo mi = null;
		Connection conn = getConnection();
		AdminMemberListDao adminMemberListDao= AdminMemberListDao.getInstance();
		adminMemberListDao.setConnection(conn);
		
		mi = adminMemberListDao.getMemberInfo(miid);
		close(conn);
		
		return mi;
	}
}
