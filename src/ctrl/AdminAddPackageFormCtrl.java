package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/admin_add_package_form")
public class AdminAddPackageFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminAddPackageFormCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		AdminInfo adminLoginInfo = (AdminInfo)session.getAttribute("adminLoginInfo");
		
		if(adminLoginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('admin/admin_index.jsp?url=admin_add_package_form')");
			out.println("</script>");
			out.close();
		}
		
		AdminAddPackageFormSvc adminAddPackageFormSvc = new AdminAddPackageFormSvc();
		ArrayList<CtgrCity> cityList = adminAddPackageFormSvc.getCtgrCity();		
		ArrayList<HotelInfo> hotelList = adminAddPackageFormSvc.getHotelList();
		ArrayList<FlightRealPrice> frpList = adminAddPackageFormSvc.getFrpList();
		
		request.setAttribute("cityList", cityList);		
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("frpList", frpList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/package_insert_form.jsp");
		dispatcher.forward(request, response);
		
	}
}
