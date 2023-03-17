package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminMemberListSvc {
	public int getMemberListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		AdminMemberListDao adminMemberListDao = AdminMemberListDao.getInstance();
		adminMemberListDao.setConnection(conn);
		
		rcnt = adminMemberListDao.getMemberListCount(where);
		close(conn);
		
		return rcnt;
	}
	
	public ArrayList<MemberInfo> getMemberList(String where, int cpage, int psize) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		Connection conn = getConnection();
		AdminMemberListDao adminMemberListDao = AdminMemberListDao.getInstance();
		adminMemberListDao.setConnection(conn);
		
		memberList = adminMemberListDao.getMemberList(where, cpage, psize);
		close(conn);
		
		return memberList;
	}
}
