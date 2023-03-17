package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/tour_list")
public class AdminTourListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminTourListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String schtype, keyword;
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 시작 페이지 등을 저장할 변수들
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String where ="where pt_price >= 0 ";	// 검색조건이 있을 경우 where절을 저장할 변수
		if(request.getParameter("keyword") == null) keyword = "";
		else keyword = request.getParameter("keyword").toUpperCase();	// 검색어
		
		schtype = request.getParameter("schtype");	// 검색조건(제목, 내용, 제목+내용)
			if (schtype == null) {
				schtype = "";
				// 화면상의 검색어가 'null'로 보이지 않게 하기 위해 빈 문자열로 채움
			} else if (!schtype.contentEquals("") && !keyword.contentEquals("")) {
			// 검색조건과 검색어가 모두 있을 경우
			URLEncoder.encode(keyword, "UTF-8");
			// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 브라우저에 따라 문제가 발생할 수 있으므로 유니코드로 변환
			if (schtype.equals("code")) { // 검색 조건이 '코드'일 경우0
				
				where += " and (cc_id like '%" + keyword + "%' )";
			} else if (schtype.equals("name")) {	// 검색 조건이 '도시'일 경우 
				where += " and pt_name like '%" + keyword +"%' ";
			}
		}
		AdminTourListSvc tourListSvc = new AdminTourListSvc();
		rcnt = tourListSvc.getPareviewListCount(where);
		ArrayList<PackageTour> ptList = tourListSvc.getTourList(where,cpage,psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);		pageInfo.setKeyword(keyword);

		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("ptList", ptList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/product/tour_list.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
