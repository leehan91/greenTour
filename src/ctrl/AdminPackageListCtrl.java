package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;


@WebServlet("/admin_package_list")
public class AdminPackageListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminPackageListCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		
		String schtype = request.getParameter("schtype");		
		String keyword = request.getParameter("keyword");		
		String where = " where pi_isview = 'y' ";
		
		
		HttpSession session = request.getSession();
		// JSP가 아니므로 세션을 사용하려면 직접 HttpSession 클래스의 인스턴스를 생성해야 함.
//		if(session.getAttribute("adminLoginInfo") == null) {
//			response.setContentType("text/html; charset=utf-8");
//			PrintWriter out = response.getWriter();
//			out.println("<script>");
//			out.println("alert('잘못된 경로로 들어오셨습니다');");
//			out.println("history.back();");
//			out.println("</script>");
//			out.close();
//		}
		
		if (schtype == null || keyword == null) {
			schtype = "";		keyword = "";
		} else if (!schtype.equals("") && !keyword.equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			if (schtype.equals("name") || schtype.equals("code") || schtype.equals("period"))
				where += " and pi_" + schtype + " like '%" + keyword + "%'";
			}
		
		AdminPackageListSvc adminPackageListSvc = new AdminPackageListSvc();
		rcnt = adminPackageListSvc.getPackageListCount(where);
		ArrayList<PackageInfo> packageList = adminPackageListSvc.getPackageList(where, cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		
		request.setAttribute("packageList", packageList);
		request.setAttribute("pageInfo", pageInfo);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/package_list.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
