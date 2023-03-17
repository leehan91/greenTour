package svc;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용하게 해줌
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminLoginSvc {
	public static AdminInfo getLoginInfo(String uid, String pwd) {
		Connection conn = getConnection();
		AdminLoginDao adminLoginDao = AdminLoginDao.getInstance();
		adminLoginDao.setConnection(conn);
		
		AdminInfo adminInfo = adminLoginDao.getLoginInfo(uid, pwd);
		close(conn);
		
		return adminInfo;
	}
}
