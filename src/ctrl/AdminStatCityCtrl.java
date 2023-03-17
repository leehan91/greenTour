package ctrl;

import java.io.*;
import java.time.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/admin_city")
public class AdminStatCityCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminStatCityCtrl() {        super();    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		
		String[] ccArr = {"HKG", "JPN", "PHL", "SGP", "THA", "TWN", "VNM"};
		
		StatInfo hkgp = new StatInfo();	StatInfo hkgm = new StatInfo();
		StatInfo jpnp = new StatInfo();	StatInfo jpnm = new StatInfo();
		StatInfo phlp = new StatInfo();	StatInfo phlm = new StatInfo();
		StatInfo sgpp = new StatInfo();	StatInfo sgpm = new StatInfo();
		StatInfo thap = new StatInfo();	StatInfo tham = new StatInfo();
		StatInfo twnp = new StatInfo();	StatInfo twnm = new StatInfo();
		StatInfo vnmp = new StatInfo();	StatInfo vnmm = new StatInfo();
			
		int cYear, cMonth, cDay, sYear, sMonth, sDay;
		LocalDate today = LocalDate.now();		// 오늘 날짜를 가진 인스턴스 생성
		cYear = today.getYear();
		cMonth = today.getMonthValue();
		cDay = today.getDayOfMonth();
		
		if (request.getParameter("schYear") == null) {
			sYear = cYear;	sMonth = cMonth;	sDay = cDay;
		} else {
			sYear = Integer.parseInt(request.getParameter("schYear"));
			sMonth = Integer.parseInt(request.getParameter("schMonth"));
			sDay = 1;
		}
		
		CalendarInfo ci = new CalendarInfo();
		ci.setcYear(cYear);		ci.setcMonth(cMonth);		ci.setcDay(cDay);
		ci.setsYear(sYear);		ci.setsMonth(sMonth);		ci.setsDay(sDay);
			
		AdminStatCitySvc adminStatCitySvc = new AdminStatCitySvc();
		hkgp = adminStatCitySvc.getCcpaAmount("HKG", cYear, cMonth);
		jpnp = adminStatCitySvc.getCcpaAmount("JPN", cYear, cMonth);
		phlp = adminStatCitySvc.getCcpaAmount("PHL", cYear, cMonth);
		sgpp = adminStatCitySvc.getCcpaAmount("SGP", cYear, cMonth);
		thap = adminStatCitySvc.getCcpaAmount("THA", cYear, cMonth);
		twnp = adminStatCitySvc.getCcpaAmount("TWN", cYear, cMonth);
		vnmp = adminStatCitySvc.getCcpaAmount("VNM", cYear, cMonth);
		
		hkgm = adminStatCitySvc.getCcmpAmount("HKG", cYear, cMonth);
		jpnm = adminStatCitySvc.getCcmpAmount("JPN", cYear, cMonth);
		phlm = adminStatCitySvc.getCcmpAmount("PHL", cYear, cMonth);
		sgpm = adminStatCitySvc.getCcmpAmount("SGP", cYear, cMonth);
		tham = adminStatCitySvc.getCcmpAmount("THA", cYear, cMonth);
		twnm = adminStatCitySvc.getCcmpAmount("TWN", cYear, cMonth);
		vnmm = adminStatCitySvc.getCcmpAmount("VNM", cYear, cMonth);
		
		
		request.setAttribute("ci", ci);
		request.setAttribute("hkgp", hkgp);	request.setAttribute("hkgm", hkgm);
		request.setAttribute("jpnp", jpnp);	request.setAttribute("jpnm", jpnm);
		request.setAttribute("phlp", phlp);	request.setAttribute("phlm", phlm);
		request.setAttribute("sgpp", sgpp);	request.setAttribute("sgpm", sgpm);
		request.setAttribute("thap", thap);	request.setAttribute("tham", tham);
		request.setAttribute("twnp", twnp);	request.setAttribute("twnm", twnm);
		request.setAttribute("vnmp", vnmp);	request.setAttribute("vnmm", vnmm);
		
		System.out.println("AdminStatCityCtrl Operated");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stat/stat_cc.jsp");
		dispatcher.forward(request, response);	
		
		

		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
