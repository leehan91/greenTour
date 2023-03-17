package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/admin_add_package_notice")
public class AdminAddPackageNoticeCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;     

    public AdminAddPackageNoticeCtrl() {super();}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String ccid = request.getParameter("ccid");
		String pninsur = request.getParameter("pninsur");
		String pnguide = request.getParameter("pnguide");
		String pninclude = request.getParameter("pninclude");
		String pndeclude = request.getParameter("pndeclude");
		String pnwarning = request.getParameter("pnwarning");
		String pnsafe = request.getParameter("pnsafe");
		
		PackageNotice pn = new PackageNotice();
		pn.setCc_id(ccid);
		pn.setPn_insur(pninsur);
		pn.setPn_guide(pnguide);
		pn.setPn_include(pninclude);
		pn.setPn_declude(pndeclude);
		pn.setPn_warning(pnwarning);
		pn.setPn_safe(pnsafe);
		
		String result = "";
		
		AdminAddPackageNoticeSvc adminAddPackageNoticeSvc = new AdminAddPackageNoticeSvc();
		result = adminAddPackageNoticeSvc.insertPackageNotice(pn);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}

}
