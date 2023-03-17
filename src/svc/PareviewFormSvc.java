package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.PareviewFormDao;
import dao.PareviewListDao;
import vo.CsPareview;

public class PareviewFormSvc {
	public ArrayList<CsPareview> getPareviewForm(String miid) {
		ArrayList<CsPareview> formList = new ArrayList<CsPareview>();
		Connection conn = getConnection();
		PareviewFormDao pareviewFormDao = PareviewFormDao.getInstance();
		pareviewFormDao.setConnection(conn);
		
		formList = pareviewFormDao.getPareviewForm(miid);
		close(conn);
		
		return formList;
	}
}
