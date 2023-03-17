package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/package_up")
public class AdminPackageUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminPackageUpCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String picode = request.getParameter("picode");
		String where = " where pi_isview = 'y' ";
		
		AdminPackageUpSvc adminPackageUpSvc = new AdminPackageUpSvc();
		PackageInfo pi = adminPackageUpSvc.getPackageInfo(picode);
		AdminAddPackageFormSvc adminAddPackageFormSvc = new AdminAddPackageFormSvc();
		ArrayList<CtgrCity> cityList = adminAddPackageFormSvc.getCtgrCity();
		ArrayList<HotelInfo> hotelList = adminAddPackageFormSvc.getHotelList();
		ArrayList<FlightRealPrice> frpList = adminAddPackageFormSvc.getFrpList();
		
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("cityList", cityList);
		request.setAttribute("pi", pi);
		request.setAttribute("frpList", frpList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/package_update_form.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
