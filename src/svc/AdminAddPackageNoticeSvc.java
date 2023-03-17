package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminAddPackageNoticeSvc {
	public String insertPackageNotice(PackageNotice pn) {
		
		String result = "";
		Connection conn = getConnection();
		AdminAddPackageNoticeDao adminAddPackageNoticeDao = AdminAddPackageNoticeDao.getInstance();
		adminAddPackageNoticeDao.setConnection(conn);
		
		result = adminAddPackageNoticeDao.insertPackageNotice(pn);
		String[] arr = result.split("/");
		String chk = arr[1];
		System.out.println("arr[1] : " + arr[1]);
		
		if(Integer.parseInt(chk) == 1) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}
}
