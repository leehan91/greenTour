package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/admin_mainpage")
public class AdminMainpageCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminMainpageCtrl() {super(); }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/admin_mainpage.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
