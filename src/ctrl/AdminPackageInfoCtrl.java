package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/admin_package_info")
public class AdminPackageInfoCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminPackageInfoCtrl() {super();}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String picode = request.getParameter("picode");
		String where = " where pi_isview = 'y' ";
		
		AdminPackageInfoSvc adminPackageInfoSvc = new AdminPackageInfoSvc();
		PackageInfo pai = adminPackageInfoSvc.getPackageInfo(where, picode);
		
		response.setContentType("text/html; charset=utf-8");
	    PrintWriter out = response.getWriter();
	    String info = pai.getCc_name() + "/" + pai.getHi_name() + "/" + pai.getPi_tour() + "/" + pai.getPi_food() + "/" + pai.getPi_stock();
	    out.println(info);
	}

}
