package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/admin_TourList_Pop")
public class AdminTourListPopCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AdminTourListPopCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String ccid = request.getParameter("ccid");
		String day = request.getParameter("day");
		
		AdminTourListPopSvc adminTourListPopSvc = new AdminTourListPopSvc();
		ArrayList<PackageTour> tourList = adminTourListPopSvc.getTourList(ccid);
		
		request.setAttribute("tourList", tourList);
		request.setAttribute("day", day);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/tourlistPop.jsp");
		dispatcher.forward(request, response);
	}
}
