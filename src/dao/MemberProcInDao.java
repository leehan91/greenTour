package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberProcInDao {
// 회원 가입에 관련된 쿼리 작업들을 처리하는 클래스
	private static MemberProcInDao memberProcInDao;
	private Connection conn;
	private MemberProcInDao() {}	// 기본 생성자를 private으로 선언하여 외부에서 함부로 인스턴스를 생성하지 못하게 막음
	
	public static MemberProcInDao getInstance() {
	// MemberProcInDao 클래스의 인스턴스를 생성해 주는 메소드로 이미 인스턴스가 있으면 기존의 인스턴스를 리턴
	// MemberProcInDao 클래스의 인스턴스를 하나만 생성하여 사용하게 하는 싱글턴 방식
		
		if (memberProcInDao == null)	memberProcInDao = new MemberProcInDao();
		// 이미 생성된 MemberProcInDao 클래스의 인스턴스가 없으면 새롭게 MemberProcInDao 클래스의 인스턴스를 생성
		
		return memberProcInDao;
	}
	
	public void setConnection(Connection conn) {
	// 현 MemberProcInDao 클래스에서 사용할 커넥션 객체를 받아와서 생성해 주는 메소드
		this.conn = conn;
	}
	
	public int memberProcIn(MemberInfo memberInfo) {
	// 사용자가 입력한 데이터들로 회원가입 시키는 메소드
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			String sql = "insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_registration, mi_phone, mi_email, "
					+ "mi_mileage) values (?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberInfo.getMi_id());
			pstmt.setString(2, memberInfo.getMi_pw());
			pstmt.setString(3, memberInfo.getMi_name());
			pstmt.setString(4, memberInfo.getMi_gender());
			pstmt.setString(5, memberInfo.getMi_registration());
			pstmt.setString(6, memberInfo.getMi_phone());
			pstmt.setString(7, memberInfo.getMi_email());
			pstmt.setInt(8, memberInfo.getMi_mileage());
			System.out.println(sql);
			result = pstmt.executeUpdate();
				
				if (result == 1) {		// t_member_info 테이블에 insert 쿼리가 정상적으로 동작했으면
					sql = "insert into t_member_mileage (mi_id, mm_mileage, mm_desc, mm_detail) values (?, ?, '가입 축하금', '')";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, memberInfo.getMi_id());
					pstmt.setInt(2, memberInfo.getMi_mileage());
					result += pstmt.executeUpdate();

				}
		} catch (Exception e) {
			System.out.println("MemberProcInDao의 memberProcIn() 메소드 오류");
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
}