package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminTourListPopSvc {
	public ArrayList<PackageTour> getTourList(String ccid){
		ArrayList<PackageTour> tourList = new ArrayList<PackageTour>();
		
		Connection conn = getConnection();
		AdminTourListPopDao adminTourListPopDao = AdminTourListPopDao.getInstance();
		adminTourListPopDao.setConnection(conn);
		
		tourList = adminTourListPopDao.getTourList(ccid);
		close(conn);
		
		return tourList;
	}
}
