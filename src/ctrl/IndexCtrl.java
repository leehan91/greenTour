package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/index")
public class IndexCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IndexCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		IndexSvc indexSvc = new IndexSvc();
		ArrayList<PackageInfo> piList = indexSvc.getPackageOut();
		ArrayList<PackageInfo> piList2 = indexSvc.getPackageOut2();
		
		request.setAttribute("piList", piList);
		request.setAttribute("piList2", piList2);
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
