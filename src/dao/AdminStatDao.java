package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminStatDao {
	// 통계 관련된 쿼리 작업들을 모두 처리하는 클래스
	private static AdminStatDao adminStatDao;
	private Connection conn;
	private AdminStatDao() {}	
	public static AdminStatDao getInstance() {		
		if (adminStatDao == null)	adminStatDao = new AdminStatDao();	
		return adminStatDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}	
	
	public StatInfo getPaStat(int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
						
		try {
			String sql = "select sum(op_pay) op, count(op_code) opc "
					+ " from t_order_painfo a where left(op_leave, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' " ;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				si.setSi_pNum(rs.getInt("opc"));
				si.setSi_paAmount(rs.getInt("op"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getPaStat() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;
	}	
	
	public StatInfo getMpStat(int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
						
		try {
			String sql = "select sum(om_pay) om, count(om_code) omc "
					+ " from t_order_mpinfo a where left(om_leave, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' " ;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				si.setSi_mNum(rs.getInt("omc"));
				si.setSi_mpAmount(rs.getInt("om"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getMpStat() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;
	}	
	
	public ArrayList<StatInfo> getPaList(int y, int m) {
	// 지정한 연월에 해당하는 특정 회원의 일정 목록을 ArrayList<ScheduleInfo>로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<StatInfo> dateList = new ArrayList<StatInfo>();
		StatInfo si = null;
				
		try {
			String sql = "select * "
					+ " from t_order_painfo where left(op_leave, 7) = '" 
					+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si = new StatInfo();		// 하나의 일정 정보를 저장할 StatInfo 형 인스턴스 생성
				si.setSi_paRate(rs.getString("op_code"));
				si.setSi_paDate(rs.getString("op_leave"));
				dateList.add(si);
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getPaList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return dateList;
	}
	
	public ArrayList<StatInfo> getMpList(int y, int m) {
	// 지정한 연월에 해당하는 특정 회원의 일정 목록을 ArrayList<StatInfo>로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<StatInfo> dateList = new ArrayList<StatInfo>();
		StatInfo si = null;
				
		try {
			String sql = "select * "
					+ " from t_order_mpinfo where left(om_leave, 7) = '" 
					+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si = new StatInfo();		// 하나의 일정 정보를 저장할 ScheduleInfo 형 인스턴스 생성
				si.setSi_mpRate(rs.getString("om_code"));
				si.setSi_mpDate(rs.getString("om_leave"));
				dateList.add(si);
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getMpList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return dateList;
	}	
	
	public ArrayList<StatInfo> getPaListStat(int y, int sm, int em) {
	// 지정 기간 내에 매출액을 저장
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<StatInfo> List = new ArrayList<StatInfo>();
		StatInfo si = null;
				
		try {
			String sql = "select sum(op_pay) pay from t_order_painfo where left(op_leave, 7) "
					+ "between '" + y + "-" + sm + "' and '" + y + "-" + em + "' ";
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si = new StatInfo();		// 하나의 일정 정보를 저장할 StatInfo 형 인스턴스 생성
				si.setSi_paAmount(rs.getInt("pay"));
				List.add(si);
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getPaListStat() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return List;
	}		
	
	
	public ArrayList<StatInfo> getMpListStat(int y, int sm, int em) {
	// 지정 기간 내에 매출액을 저장
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<StatInfo> List = new ArrayList<StatInfo>();
		StatInfo si = null;
				
		try {
			String sql = "select sum(om_pay) pay from t_order_mpinfo where left(om_leave, 7) "
					+ "between '" + y + "-" + sm + "' and '" + y + "-" + em + "' ";
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si = new StatInfo();		// 하나의 일정 정보를 저장할 StatInfo 형 인스턴스 생성
				si.setSi_mpAmount(rs.getInt("pay"));
				List.add(si);
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getMpListStat() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return List;
	}		
	
	public StatInfo getCcpaAmount(String cc, int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
		
		try {
			String sql = "select sum(op_pay) pay from t_order_painfo "
					+ " where left(cc_id, 3) = '" + cc + "' and "
					+ "left(op_leave, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			//System.out.println(sql);
			while (rs.next()) {
				si.setSi_ccPaAmount(rs.getInt("pay"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getCcpaAmount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;

}

	public StatInfo getCcmpAmount(String cc, int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
		
		try {
			String sql = "select sum(om_pay) pay from t_order_mpinfo "
					+ " where left(cc_id, 3) = '" + cc + "' and "
					+ "left(om_leave, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
			while (rs.next()) {
				si.setSi_ccMpAmount(rs.getInt("pay"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getCcmpAmount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;

}

	public StatInfo getRq(int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
		
		try {
			String sql = "select count(cq_idx) total from t_cs_request "
					+ " where left(cq_rdate, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si.setSi_TotalReq(rs.getInt("total"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getRq() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;

}

public StatInfo getRqYes(int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
		
		try {
			String sql = "select count(cq_idx) yes from t_cs_request "
					+ " where cq_isend = 'y' and "
					+ "left(cq_rdate, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si.setSi_YesReq(rs.getInt("yes"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getRqYes() 메소드 오류 (답변 완료)");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;

}	

public StatInfo getRqNo(int y, int m) {
		Statement stmt = null;
		ResultSet rs = null;
		StatInfo si = new StatInfo();
		
		try {
			String sql = "select count(cq_idx) no from t_cs_request "
					+ " where cq_isend = 'n' and "
					+ "left(cq_rdate, 7) = '"	+ y + "-" + (m < 10 ? "0" + m : m) + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si.setSi_NoReq(rs.getInt("no"));
			}
			
		} catch (Exception e) {
			System.out.println("AdminStatDao 클래스의 getRqNo() 메소드 오류 (답변 미완료)");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return si;

}	

public StatInfo getMemStat() {
	Statement stmt = null;
	ResultSet rs = null;
	StatInfo si = new StatInfo();
	
	try {
		String sql = "select count(mi_id) num from t_member_info ";
//		System.out.println(sql);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			si.setSi_member(rs.getInt("num"));
		}
		
	} catch (Exception e) {
		System.out.println("AdminStatDao 클래스의 getMemStat() 메소드 오류");
		e.printStackTrace();
	} finally {
		close(stmt);	close(rs);
	}
	return si;

}	

public StatInfo getMemAStat() {
	Statement stmt = null;
	ResultSet rs = null;
	StatInfo si = new StatInfo();
	try {
		String sql = "select count(mi_id) num from t_member_info where mi_status = 'a' ";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);	
		while (rs.next()) {
			si.setSi_memberA(rs.getInt("num"));
		}
		
	} catch (Exception e) {
		System.out.println("AdminStatDao 클래스의 getMemAStat() 메소드 오류");
		e.printStackTrace();
	} finally {
		close(stmt);	close(rs);
	}
	return si;

}		

public StatInfo getMemBStat() {
	Statement stmt = null;
	ResultSet rs = null;
	StatInfo si = new StatInfo();
	try {
		String sql = "select count(mi_id) num from t_member_info where mi_status = 'b' ";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);		
		while (rs.next()) {
			si = new StatInfo();		// 패키지 판매 정보를 저장할 StatInfo 형 인스턴스 생성
			si.setSi_memberB(rs.getInt("num"));
		}
		
	} catch (Exception e) {
		System.out.println("AdminStatDao 클래스의 getMemBStat() 메소드 오류");
		e.printStackTrace();
	} finally {
		close(stmt);	close(rs);
	}
	return si;

}

public StatInfo getMemDStat() {
	Statement stmt = null;
	ResultSet rs = null; 
	StatInfo si = new StatInfo();
	
	try {
		String sql = "select count(mi_id) num from t_member_info where mi_status = 'd' ";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			si = new StatInfo();		// 패키지 판매 정보를 저장할 StatInfo 형 인스턴스 생성
			si.setSi_memberD(rs.getInt("num"));
		}
		
	} catch (Exception e) {
		System.out.println("AdminStatDao 클래스의 getMemDStat() 메소드 오류");
		e.printStackTrace();
	} finally {
		close(stmt);	close(rs);
	}
	return si;

}		

	
}
