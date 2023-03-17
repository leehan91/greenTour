package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminMemberListDao {
	private static AdminMemberListDao adminMemberListDao;
	private Connection conn;
	private AdminMemberListDao() {}
	
	public static AdminMemberListDao getInstance() {
		
		if (adminMemberListDao == null)	adminMemberListDao = new AdminMemberListDao();
		
		return adminMemberListDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getMemberListCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_member_info " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())		rcnt = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("AdminMemberListDao 클래스의 getMemberListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return rcnt;
	}
	
	public ArrayList<MemberInfo> getMemberList(String where, int cpage, int psize) {
		// 자유 게시판에서 검색된 결과의 레코드(게시글) 목록을 ArrayList로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();		// 검색된 게시글들을 저장할 ArrayList<BbsFree>
		MemberInfo mi = null;		// freeList에 저장할 하나의 게시글 정보를 담을 인스턴스
		
		try {
			String sql = "select * from t_member_info " + where + " order by mi_id desc limit " 
				+ ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_email(rs.getString("mi_email"));
				mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
				mi.setMi_joindate(rs.getString("mi_joindate"));
				mi.setMi_status(rs.getString("mi_status"));
				mi.setMi_date(rs.getString("mi_date"));
				memberList.add(mi);
			}
			
		} catch (Exception e) {
			System.out.println("AdminMemberListDao 클래스의 getMemberList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return memberList;
	}
	public MemberInfo getMemberInfo(String miid) {
		// 지정한 게시글의 정보들을 BbsFree 형 인스턴스로 리턴하는 메소드
				Statement stmt = null;
				ResultSet rs = null;
				MemberInfo mi = null;
				
				try {
					String sql = "select * from t_member_info where mi_id = '" + miid + "' ";
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					if (rs.next()) {
						mi = new MemberInfo();
						mi.setMi_id(miid);
						mi.setMi_name(rs.getString("mi_name"));
						mi.setMi_pw(rs.getString("mi_pw"));
						mi.setMi_registration(rs.getString("mi_registration"));
						mi.setMi_phone(rs.getString("mi_phone"));
						mi.setMi_email(rs.getString("mi_email"));
						mi.setMi_joindate(rs.getString("mi_joindate"));
						mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
						mi.setMi_status(rs.getString("mi_status"));
						mi.setMi_date(rs.getString("mi_date"));
						
					}
					
				} catch (Exception e) {
					System.out.println("AdminMemberListDao 클래스의 getMemberInfo() 메소드 오류");
				} finally {
					close(rs);		close(stmt);
				}
		return mi;
	}
	
	
	
}
