package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/hotel_list")
public class AdminHotelListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminHotelListCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작 페이지 등을 저장할 변수들
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		// cpage 값이 있으면 받아서 int 형으로 형변환 시킴 (보안상의 이유와 산술 연산을 해야 하기 때문)
		
		String schtype = request.getParameter("schtype");		// 검색 조건(제목, 내용, 제목 + 내용)
		String keyword = request.getParameter("keyword");		// 검색어
		String where = " where hi_isdel = 'n' ";		// 검색 조건이 있을 경우 where 절을 저장할 변수
		
		if (schtype == null || keyword == null) {
			schtype = "";		keyword = "";
			// 화면상에 검색어가 'null'로 보이지 않게 하기 위해 빈 문자열로 채움
			// (검색조건 있을경우 콤보박스 selected 하기 위해 equals()로 검사할 때 nullPointerException 발생을 방지하기 위해) // 
		} else if (!schtype.equals("") && !keyword.equals("")) {		// 단순히 null만 아닌게 아니라 빈 문자열도 거르기 위한 재 조건문 //
		// 검색 조건과 검색어가 모두 있을 경우
			URLEncoder.encode(keyword, "UTF-8");
			// 쿼리 스트링으로 주고 받는 검색어가 한글 일 경우 브라우저에 따라 문제가 발생할 수 있으므로 유니코드로 변환
			
			if("nation".equals(schtype) || "city".equals(schtype)){
				where += " AND UPPER(cc_id) LIKE UPPER('%" + keyword + "%')";;
			} else {
				where += " AND UPPER(hi_" + schtype + ") LIKE UPPER('%" + keyword + "%')";
			}
		}
		
		AdminHotelListSvc adminHotelListSvc = new AdminHotelListSvc();
		rcnt = adminHotelListSvc.getHotelListCount(where);		// 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지 수 계산을 위해 필요
		
		ArrayList<HotelInfo> hotelList = adminHotelListSvc.getHotelList(where, cpage, psize);
		// 목록 화면에서 보여줄 게시글 목록을 ArrayList<BbsFree> 형으로 받아옴, 필요한 만큼만 받아오기 위해 cpage 와 psize가 필요
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);
		pageInfo.setKeyword(keyword);
		// 페이징과 검색에 필요한 정보들을 PageInfo형 인스턴스에 저장
		
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("pageInfo", pageInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/hotel/hotel_list.jsp");
		dispatcher.forward(request, response);
	}
}
