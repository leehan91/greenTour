package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/package_detail")
public class PackageDetailCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PackageDetailCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String picode = request.getParameter("pi_code");
		String fideparture = request.getParameter("fi_departure");
		String fientry = request.getParameter("fi_entry");
		String frname = request.getParameter("fr_name");
		
		
		PackageDetailSvc packageDetailSvc = new PackageDetailSvc();
		PackageInfo pi = packageDetailSvc.getDetailInfo(picode);
		FlightInfo fi = packageDetailSvc.getFlightInfo(picode, fideparture, fientry, frname);
		
		
		//if (pi == null) {
//			response.setContentType("text/html; charset=utf-8");
//			PrintWriter out = response.getWriter();
//			out.println("<script>");
//			out.println("alert('잘못된 경로로 들어오셨습니다.);");
//			out.println("history.back();");
//			out.println("</script>");
//			out.close();
		//} else {		// 보여줄 게시글이 있으면
			request.setAttribute("pi", pi);
			request.setAttribute("fi", fi);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("front/package/package_detail.jsp");
			dispatcher.forward(request, response);
		
		//}	
	}
}

