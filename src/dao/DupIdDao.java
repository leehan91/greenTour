package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;

public class DupIdDao {
	private static DupIdDao dupIdDao;
	private Connection conn;
	private DupIdDao() {}		// 기본 생성자를 private으로 선언하여 외부에서 함부로 인스턴스를 생성하지 못하게 막음
	
	public static DupIdDao getInstance() {
	// DupIdDao 클래스의 인스턴스를 생성해 주는 메소드로 이미 인스턴스가 있으면 기존의 인스턴스를 리턴
	// DupIdDao 클래스의 인스턴스를 하나만 생성하여 사용하게 하는 싱글턴 방식
		
		if (dupIdDao == null)	dupIdDao = new DupIdDao();
		// 이미 생성된 DupIdDao 클래스의 인스턴스가 없으면 새롭게 DupIdDao 클래스의 인스턴스를 생성
		
		return dupIdDao;
	}
	
	public void setConnection(Connection conn) {
	// 현 DupIdDao 클래스에서 사용할 커넥션 객체를 받아와서 생성해 주는 메소드
		this.conn = conn;
	}
	
	public int chkDupId(String uid) {
	// 회원 가입시 사용자가 사용할 아이디의 중복 여부를 리턴할 메소드
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null; 
		
		try {
			stmt = conn.createStatement();
			String sql = "select count(*) from t_member_info where mi_id = '" + uid + "'";
			rs = stmt.executeQuery(sql);
			rs.next();		// count() 함수를 사용했기에 데이터가 없을 경우는 없음
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("DupIdDao 클래스의 chkDupId() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);	
		}
		
		return result;
	}
}
