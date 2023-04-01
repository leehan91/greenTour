package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/member_list")
public class AdminMemberListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminMemberListCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		
		String schtype = request.getParameter("schtype");		
		String keyword = request.getParameter("keyword");		
		String where = " where mi_status <> '' ";
		
		if (schtype == null || keyword == null) {
			schtype = "";		keyword = "";
		} else if (!schtype.equals("") && !keyword.equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			if (schtype.equals("name") || schtype.equals("id") || schtype.equals("status"))
				where += " and mi_" + schtype + " like '%" + keyword + "%'";
			}
		
		AdminMemberListSvc adminMemberListSvc = new AdminMemberListSvc();
		rcnt = adminMemberListSvc.getMemberListCount(where);
		
		ArrayList<MemberInfo> memberList = adminMemberListSvc.getMemberList(where, cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);
		pageInfo.setKeyword(keyword);
		// ����¡�� �˻��� �ʿ��� �������� PageInfo�� �ν��Ͻ��� ����
		
		request.setAttribute("memberList", memberList);
		request.setAttribute("pageInfo", pageInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/greenTour/admin/member/member_list.jsp");
		dispatcher.forward(request, response);
	}

}
