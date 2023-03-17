package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/mypackage_main_tour")
public class MyPackageMainTourCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public MyPackageMainTourCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String ccid = request.getParameter("ccid");
		String city = request.getParameter("city");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		int adult = Integer.parseInt(request.getParameter("adult"));
		int child = Integer.parseInt(request.getParameter("child"));
		String total = request.getParameter("total");
		
		String air = request.getParameter("air");
		String agrade = request.getParameter("agrade");
		String ficode = request.getParameter("ficode");
		int fridx = Integer.parseInt(request.getParameter("fridx"));
		int atotal = Integer.parseInt(request.getParameter("atotal"));
		
		String hotel = request.getParameter("hotel");
		String hicode = request.getParameter("hicode");
		String hgrade = request.getParameter("hgrade");
		int htotal = Integer.parseInt(request.getParameter("htotal"));
		
		MyPackageMy mm = new MyPackageMy();
		mm.setCc_id(ccid);
		mm.setMm_destination(city);
		mm.setMm_child(child);
		mm.setMm_adult(adult);
		mm.setFi_code(ficode);
		mm.setFr_idx(fridx);
		mm.setMm_agrade(agrade);
		mm.setMm_atotal(atotal);
		mm.setHi_code(hicode);
		mm.setMm_hgrade(hgrade);
		mm.setMm_htotal(htotal);
		
		
		
		MyPackageMainTourSvc mypackageMainTourSvc = new MyPackageMainTourSvc();
		ArrayList<PackageTour> tourList = mypackageMainTourSvc.getTourList(ccid);
		
		request.setAttribute("tourList", tourList);
		request.setAttribute("mypackagemy", mm);
		
		request.setAttribute("hotel", hotel);
		request.setAttribute("air", air);
		request.setAttribute("sdate", sdate);
		request.setAttribute("edate", edate);
		request.setAttribute("total", total);

		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_tour.jsp");
		dispatcher.forward(request, response);
		
	}

}
