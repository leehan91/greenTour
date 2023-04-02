package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPareviewListSvc {

	public int getPareviewCount() {
		int rcnt = 0;
		Connection conn = getConnection();
		
		AdminPareviewDao apd = AdminPareviewDao.getInstance();
		apd.setConnection(conn);
		
		rcnt = apd.getPareviewCount();
		close(conn);
		
		
		return rcnt;
	}

	public ArrayList<CsPareview> getPareviewList(int cpage, int psize) {
		ArrayList<CsPareview> cpList = new ArrayList<CsPareview>();
		Connection conn = getConnection();
		
		AdminPareviewDao apd = AdminPareviewDao.getInstance();
		apd.setConnection(conn);
		
		cpList = apd.getPareviewList(cpage, psize);
		close(conn);
		
		
		return cpList;
	}

}
