package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/admin_add_package_getpicode")
public class AdminAddPackagegGetPicodeCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public AdminAddPackagegGetPicodeCtrl() { super(); }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String nation = request.getParameter("nation");
		String ccid = request.getParameter("city");
		
		AdminAddPackagegGetPicodeSvc adminAddPackagegGetPicodeSvc = new AdminAddPackagegGetPicodeSvc();
		String picode = adminAddPackagegGetPicodeSvc.getPicode(ccid);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(picode);
		
	}
}
