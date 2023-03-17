package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class AdminTourListSvc {
	public int getPareviewListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		AdminTourProcDao myPackageProcDao = AdminTourProcDao.getInstance();
		myPackageProcDao.setConnection(conn);
		
		rcnt = myPackageProcDao.getPareviewListCount(where);
		close(conn);
		
		return rcnt;
	}
	public ArrayList<PackageTour> getTourList(String where, int cpage, int psize) {
		ArrayList<PackageTour> ptList = new ArrayList<PackageTour>();
		Connection conn = getConnection();
		AdminTourProcDao myPackageProcDao = AdminTourProcDao.getInstance();
		myPackageProcDao.setConnection(conn);
		
		ptList = myPackageProcDao.getTourList(where,cpage,psize);
		close(conn);
		
		return ptList;
	}
}
