package ctrl;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.*;
import vo.*;

@WebServlet("/pareview_list")
public class PareviewListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PareviewListCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 시작 페이지 등을 저장할 변수들
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		String schtype = request.getParameter("schtype");	// 검색조건(제목, 내용, 제목+내용)
		String keyword = request.getParameter("keyword");	// 검색어
		String where = " where cp_isdel = 'n' ";	// 검색조건이 있을 경우 where절을 저장할 변수
		if (schtype == null || keyword == null) {
			schtype = "";			keyword = "";
			// 화면상의 검색어가 'null'로 보이지 않게 하기 위해 빈 문자열로 채움
		} else if (!schtype.contentEquals("") && !keyword.contentEquals("")) {
			// 검색조건과 검색어가 모두 있을 경우
			URLEncoder.encode(keyword, "UTF-8");
			// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 브라우저에 따라 문제가 발생할 수 있으므로 유니코드로 변환
			if (schtype.equals("tc")) { // 검색 조건이 '제목+내용'일 경우
				where += " and (cp_title like '%" + keyword + "%' or cp_content like '%" + 
						keyword + "%')";
			} else {	// 검색 조건이 '제목'이나 '내용'일 경우
				where += "and cp_" + schtype + " like '%" + keyword +"%' ";
			}
		}
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);		pageInfo.setKeyword(keyword);
		// 페이징과 검색에 필요한 정보들을 PageInfo형 인스턴스에 저장

		PareviewListSvc pareviewListSvc = new PareviewListSvc();
		rcnt = pareviewListSvc.getPareviewListCount(where);
		
		ArrayList<CsPareview> csPareview = pareviewListSvc.getPareviewList(where,cpage,psize);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("csPareview", csPareview);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/review/pareview_list.jsp");
		dispatcher.forward(request, response);

		
	}

}
