package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/mypackagehotel_pop")
public class MyPackageHotelPopCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyPackageHotelPopCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String hicode = request.getParameter("hicode");
		
		MyPackageHotelPopSvc myPackageHotelPopSvc = new MyPackageHotelPopSvc();
		HotelInfo hi = myPackageHotelPopSvc.getHotelInfo(hicode);
		request.setAttribute("hotelinfo", hi);
	
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_hotel_pop.jsp");
		dispatcher.forward(request, response);
		
	}

}
