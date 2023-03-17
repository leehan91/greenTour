package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.JsonObject;

import vo.HotelInfo;
import vo.MemberInfo;

public class AdminHotelProcDao {
	private static AdminHotelProcDao adminHotelProcDao;
	private Connection conn;
	private AdminHotelProcDao() {}
	
	public static AdminHotelProcDao getInstance() {
		
		if (adminHotelProcDao == null)	adminHotelProcDao = new AdminHotelProcDao();
		
		return adminHotelProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getHotelListCount(String where) {
	// 자유 게시판의 검색된 결과의 레코드(게시글) 개수를 리턴하는 메소드
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_hotel_info " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())		rcnt = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao 클래스의 getHotelListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return rcnt;
	}
	
	public ArrayList<HotelInfo> getHotelList(String where, int cpage, int psize) {
	// 자유 게시판에서 검색된 결과의 레코드(게시글) 목록을 ArrayList로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<HotelInfo> HotelList = new ArrayList<HotelInfo>();		// 검색된 게시글들을 저장할 ArrayList<BbsFree>
		HotelInfo hi = null;		// freeList에 저장할 하나의 게시글 정보를 담을 인스턴스
		
		try {
			String sql = "select hi_code, left(cc_id,3) nation, right(cc_id,3) city, hi_grade, hi_name, hi_addr, hi_tel, hi_price "
				+ "from t_hotel_info " + where + " order by hi_code desc limit " 
				+ ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				hi = new HotelInfo();
				hi.setHi_code(rs.getString("hi_code"));
				hi.setCc_nation(rs.getString("nation"));
				hi.setCc_city(rs.getString("city"));
				hi.setHi_grade(rs.getString("hi_grade"));
				hi.setHi_name(rs.getString("hi_name"));
				hi.setHi_addr(rs.getString("hi_addr"));
				hi.setHi_tel(rs.getString("hi_tel"));
				hi.setHi_price(rs.getInt("hi_price"));
				HotelList.add(hi);
			}
			
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao 클래스의 getHotelList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return HotelList;
	}
	
	public int hotelDelete(String hicode) {
	// 지정한 댓글을 삭제하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "UPDATE t_hotel_info SET hi_isdel = 'Y' WHERE hi_code = '" + hicode + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			System.out.println("sql : " + sql );
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao 클래스의 hotelDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public JsonObject getHotelUniqueId(String ccid) {
		Statement stmt = null;
		ResultSet rs = null;
		JsonObject hotelUniqueId = new JsonObject();
		
		try {
			String sql = "select concat('HO', '" + ccid +"', LPAD(max(CAST(substring(hi_code, 9, 11) AS signed integer)) + 1, 3, 0)) "
					+ "as new_id from t_hotel_info where cc_id = '" + ccid +"';";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				hotelUniqueId.addProperty("new_id", rs.getString("new_id"));
				// System.out.println(piDataObject);
			}
			
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao 클래스의 getHotelUniqueId() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return hotelUniqueId;
	}
	
	public int getHotelAdd(HttpServletRequest request) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql="INSERT INTO t_hotel_info ("
					+ "hi_code, cc_id, hi_name, hi_grade, hi_addr, "
					+ "hi_tel, hi_price, hi_standard, hi_deluxe, hi_suite, hi_img1, "
					+ "hi_desc, hi_notice) "
					+ "VALUES ('"
					+ request.getParameter("code")+"', '"+request.getParameter("nation")+request.getParameter("city")+"', '"+request.getParameter("name")+"', '"+request.getParameter("grade")+"', '"+request.getParameter("addr")+"', '"+request.getParameter("tel")+"', "+request.getParameter("standard")+", "+request.getParameter("standard")+", "+request.getParameter("deluxe")+", "+request.getParameter("suite")+", '"+request.getParameter("name")+"', '"+request.getParameter("desc")+"', '"+request.getParameter("notice")+"')";
			
			System.out.println("sql : " +sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao 클래스의 getHotelAdd() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
	public HotelInfo getHotelInfo(String hicode) {
	// 지정한 게시글의 정보들을 HotelInfo 형 인스턴스로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		HotelInfo hi = null;
		try {
			String sql = "select *, left(cc_id,3) nation, right(cc_id,3) city from t_hotel_info where hi_isdel = 'n' and hi_code = '" + hicode + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
			
			if (rs.next()) {
				hi = new HotelInfo();
				hi.setHi_code(rs.getString("hi_code"));
				hi.setCc_nation(rs.getString("nation"));
				hi.setCc_city(rs.getString("city"));
				hi.setHi_grade(rs.getString("hi_grade"));
				hi.setHi_name(rs.getString("hi_name"));
				hi.setHi_addr(rs.getString("hi_addr"));
				hi.setHi_tel(rs.getString("hi_tel"));
				hi.setHi_price(rs.getInt("hi_price"));
				hi.setHi_standard(rs.getInt("hi_standard"));
				hi.setHi_deluxe(rs.getInt("hi_deluxe"));
				hi.setHi_suite(rs.getInt("hi_suite"));
				hi.setHi_img1(rs.getString("hi_img1"));
			}
		} catch (Exception e) {
			System.out.println("AdminHotelProcDao 클래스의 getHotelInfo() 메소드 오류");
		} finally {
			close(rs);		close(stmt);
		}
		return hi;
	}
	
	public int getHotelUpdate(HttpServletRequest request) {
		// 사용자가 입력한 데이터들로 회원 정보 수정을 하는 메소드
			Statement stmt = null;
			int result = 0;

			try {
				String sql = "UPDATE t_hotel_info "
				+ "SET hi_grade = '"+request.getParameter("grade")+"', hi_name = '"+request.getParameter("name")+"', hi_addr = '"+request.getParameter("addr")+"', hi_tel = '"+request.getParameter("tel")+"', hi_price = '"+request.getParameter("standard")+"',"
				+ " hi_standard = '"+request.getParameter("standard")+"', hi_deluxe = '"+request.getParameter("deluxe")+"', hi_suite = '"+request.getParameter("suite")+"' "
				+ "WHERE hi_code = '"+ request.getParameter("code") +"'";
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				System.out.println("update :" + sql);
						
			} catch (Exception e) {
				System.out.println("AdminHotelProcDao의 getHotelUpdate() 메소드 오류");
			} finally {
				close(stmt);
			}
			
			return result;
		}
}