package svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PareviewListSvc {
	public int getPareviewListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		PareviewListDao pareviewListDao = PareviewListDao.getInstance();
		pareviewListDao.setConnection(conn);
		
		rcnt = pareviewListDao.getPareviewListCount(where);
		close(conn);
		
		return rcnt;
	}
	public ArrayList<CsPareview> getPareviewList(String where, int cpage, int psize, String miid){
		ArrayList<CsPareview> csPareview = new ArrayList<CsPareview>(); 
		Connection conn = getConnection();
		PareviewListDao pareviewListDao = PareviewListDao.getInstance();
		pareviewListDao.setConnection(conn);
		
		csPareview = pareviewListDao.getCsPareviewList(where, cpage, psize, miid);
		
		close(conn);
		
		return csPareview;
	}
}
