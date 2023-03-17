package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class SchKeywordSvc {
	public ArrayList<PackageInfo> getPackageOut(String keyword){
		ArrayList<PackageInfo> piList = new ArrayList<PackageInfo>();
		Connection conn = getConnection();
		SchKeywordDao schKeywordDao = SchKeywordDao.getInstance();
		schKeywordDao.setConnection(conn);
		
		piList = schKeywordDao.getPackageOut(keyword);
		close(conn);
		
		return piList;
	}

	public ArrayList<HotelInfo> getHotelOut(String keyword) {
		ArrayList<HotelInfo> hiList = new ArrayList<HotelInfo>();
		Connection conn = getConnection();
		SchKeywordDao schKeywordDao = SchKeywordDao.getInstance();
		schKeywordDao.setConnection(conn);
		if(keyword.equals("�Ϻ�"))	keyword = "JPN";
		else if(keyword.equals("�±�"))	keyword = "THA";
		else if(keyword.equals("�ʸ���"))	keyword = "PHL";
		else if(keyword.equals("ȫ��"))	keyword = "HKG";
		else if(keyword.equals("�̰�����"))	keyword = "SGP";
		else if(keyword.equals("��Ʈ��"))	keyword = "VNM";
		else if(keyword.equals("�븸"))	keyword = "TWN";
		
		hiList = schKeywordDao.getHotelOut(keyword);
		close(conn);
		
		return hiList;
	}

	public ArrayList<CsPareview> getPareviewOut(String keyword) {
		ArrayList<CsPareview> cpList = new ArrayList<CsPareview>();
		Connection conn = getConnection();
		SchKeywordDao schKeywordDao = SchKeywordDao.getInstance();
		schKeywordDao.setConnection(conn);
		
		cpList = schKeywordDao.getPareviewOut(keyword);
		close(conn);
		
		return cpList;
		
	}
}
