package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.PareviewFormDao;
import dao.PareviewDao;
import vo.*;

public class PareviewFormSvc {
	public ArrayList<OrderPaInfo> getPareviewForm(String miid) {
		ArrayList<OrderPaInfo> opList = new ArrayList<OrderPaInfo>();
		Connection conn = getConnection();
		PareviewFormDao pareviewFormDao = PareviewFormDao.getInstance();
		pareviewFormDao.setConnection(conn);
		
		opList = pareviewFormDao.getPareviewForm(miid);
		close(conn);
		
		return opList;
	}
}
