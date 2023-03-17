package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminAddPackagegGetPicodeSvc {
	public String getPicode(String ccid){
		String picode = "";
		
		Connection conn = getConnection();
		AdminAddPackagegGetPicodeDao adminAddPackagegGetPicodeDao = AdminAddPackagegGetPicodeDao.getInstance();
		adminAddPackagegGetPicodeDao.setConnection(conn);
		
		picode = adminAddPackagegGetPicodeDao.getPicode(ccid);
		close(conn);
		
		return picode;
	
	}
}
