package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/tour_form_up")
public class AdminTourFormUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminTourFormUpCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String ptcode = request.getParameter("ptcode");
		
		AdminTourUpSvc adminTourUpSvc = new AdminTourUpSvc();
		PackageTour pt = adminTourUpSvc.getTour(ptcode);
		
		request.setAttribute("pt", pt);
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/tour_form_up.jsp");
		dispatcher.forward(request, response);
	}

}
