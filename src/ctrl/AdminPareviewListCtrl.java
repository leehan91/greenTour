package ctrl;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.*;
import vo.*;

@WebServlet("/admin_pareview_list")
public class AdminPareviewListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminPareviewListCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		
		String schtype = request.getParameter("schtype");	
		String keyword = request.getParameter("keyword");	
		
		if (schtype == null || keyword == null) {
			schtype = "";		keyword = "";
		} else if (!schtype.equals("") && !keyword.equals("")) {		// �ܼ��� null�� �ƴѰ� �ƴ϶� �� ���ڿ��� �Ÿ��� ���� �� ���ǹ� //
			
			if("nation".equals(schtype) || "city".equals(schtype)){
				where += " AND UPPER(cc_id) LIKE UPPER('%" + keyword + "%')";;
			} else {
				where += " AND UPPER(hi_" + schtype + ") LIKE UPPER('%" + keyword + "%')";
			}
		}
		
		AdminPareviewListSvc aplc = new AdminPareviewListSvc();
		rcnt = aplc.getPareviewCount();
		
		ArrayList<CsPareview> cpList = aplc.getPareviewList(cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		
		request.setAttribute("cpList", cpList);
		request.setAttribute("pageInfo", pageInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/cs/pareview_list.jsp");
		dispatcher.forward(request, response);
		
	}

}
