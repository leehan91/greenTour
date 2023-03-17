package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/mypackagetour_pop")
public class MyPackageTourPopCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public MyPackageTourPopCtrl() {super();}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String ptcode = request.getParameter("ptcode");
		
		MyPackageTourPopSvc myPackageTourPopCtrl= new MyPackageTourPopSvc();
		PackageTour pt = myPackageTourPopCtrl.getTourInfo(ptcode);
		
		request.setAttribute("tourinfo", pt);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_tour_pop.jsp");
		dispatcher.forward(request, response);
		
	}

}
