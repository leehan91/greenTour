package dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰ� ����
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminAddPackageNoticeDao {
	private static AdminAddPackageNoticeDao adminAddPackageNoticeDao;
	private Connection conn;
	private AdminAddPackageNoticeDao() { }
		
	public static AdminAddPackageNoticeDao getInstance() {		
		if(adminAddPackageNoticeDao == null) adminAddPackageNoticeDao = new AdminAddPackageNoticeDao();
		
		return adminAddPackageNoticeDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	

	public String insertPackageNotice(PackageNotice pn) {
		String result = "";
		int chk = 0;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;
		
		try {
			String sql = "insert into t_package_notice (cc_id, pn_insur, pn_guide, pn_include, pn_declude, pn_warning, pn_safe) values ('" +
						pn.getCc_id() + "', '" + pn.getPn_insur() + "', '" + pn.getPn_guide() + "', '" + pn.getPn_include() + "', '" +
						pn.getPn_declude() + "', '" + pn.getPn_warning() + "', '" + pn.getPn_safe() + "')";
			//System.out.println("��Ű����Ƽ���μ�Ʈ sql"+sql);
			stmt = conn.createStatement();
			chk = stmt.executeUpdate(sql);
			
			if(chk==1) {
				stmt2 = conn.createStatement();
				sql = "select pn_idx from t_package_notice where cc_id ='" + pn.getCc_id() +"' order by pn_date desc limit 0, 1";
				rs = stmt2.executeQuery(sql);
				if(rs.next()) {
					result = rs.getString("pn_idx");
					result = result + "/" + chk;
				}
			}
			
			
		} catch (Exception e) {
			System.out.println("AdminAddPackageNoticeDao Ŭ������ insertPackageNotice() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt2);	close(stmt);
		}
		
		return result;
	}
}
