package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/sch_keyword")
public class SchKeywordCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SchKeywordCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String keyword, date="";
		ArrayList<PackageInfo> piList = null;
		SchKeywordSvc schKeywordSvc = new SchKeywordSvc();
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword").trim();
			piList = schKeywordSvc.getPackageOut(keyword);
			ArrayList<HotelInfo> hiList = schKeywordSvc.getHotelOut(keyword);
			ArrayList<CsPareview> cpList = schKeywordSvc.getPareviewOut(keyword);
			
			
			request.setAttribute("hiList", hiList);
			request.setAttribute("cpList", cpList);
		} else {
			keyword = "";
		}
		
		if(request.getParameter("city") != null) {
		
		String city = request.getParameter("city");
		date = request.getParameter("date");

		piList = schKeywordSvc.getPackageOut(city);

		}
		
		request.setAttribute("piList", piList);
		
		
		

		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sch_keyword.jsp");
		dispatcher.forward(request, response);
		
	}

}
