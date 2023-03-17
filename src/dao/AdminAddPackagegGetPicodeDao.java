package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import java.time.LocalDate;

import vo.*;

public class AdminAddPackagegGetPicodeDao {
	private static AdminAddPackagegGetPicodeDao adminAddPackagegGetPicodeDao;
	private Connection conn;
	private AdminAddPackagegGetPicodeDao() { }
		
	public static AdminAddPackagegGetPicodeDao getInstance() {		
		if(adminAddPackagegGetPicodeDao == null) adminAddPackagegGetPicodeDao = new AdminAddPackagegGetPicodeDao();
		
		return adminAddPackagegGetPicodeDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public String getPicode(String ccid){
		String picode = "";
		LocalDate today = LocalDate.now();	// yyyy-mm-dd
		String td = (today + "").substring(2).replace("-", "");	// yymmdd
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select right(pi_code,3) seq from t_package_info where mid(pi_code,3,6) = '" + ccid + "' order by pi_date desc limit 0, 1";
			rs = stmt.executeQuery(sql);
			System.out.println("picode : " + sql);
			if(rs.next()) {	//같은 지역의 패키지 코드가 있으면
				int num = Integer.parseInt(rs.getString("seq")) + 1;
				String number = "";
				if(num < 10) number = "00"+ num;
				else if (num >= 10 && num < 100 ) number = "0" + num;
				else if (num >= 100) number = "" + num;
				
				picode = "PA" + ccid + number;
			}else { //마이패키지 코드가 없었다면
				picode = "PA" + ccid + "001";
			}
			
		}catch(Exception e) {
			System.out.println("AdminAddPackagegGetPicodeDao 클래스의 getPicode() 메소드 오류발생");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return picode;
	}
}
