package ctrl;

import java.io.*;
import java.time.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/admin_stat")
public class AdminStatCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminStatCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		StatInfo statP = new StatInfo();		StatInfo statM = new StatInfo();
		StatInfo rq = new StatInfo();		StatInfo rqYes = new StatInfo();		StatInfo rqNo = new StatInfo();
		StatInfo member = new StatInfo();		StatInfo memberA = new StatInfo();
		StatInfo memberB = new StatInfo();		StatInfo memberD = new StatInfo();
		ArrayList<StatInfo> paList = new ArrayList<StatInfo>();
		ArrayList<StatInfo> mpList = new ArrayList<StatInfo>();
		// 해당 연 월에 저장되어 있는 일정들을 ScheduleInfo 형 인스턴스로 저장할 ArrayList 생성 
		
		// 오늘 날짜(연월일)와 달력 시작 날짜(연월일)를 저장할 변수들 선언
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
		// 달력 출력에 필요한 정보들을 CalendarInfo 형 인스턴스 ci에 저장

		
		AdminStatCalPaySvc adminStatCalPaySvc = new AdminStatCalPaySvc();
		AdminStatCalRqSvc adminStatCalRqSvc = new AdminStatCalRqSvc();
		AdminStatMemSvc adminStatMemSvc = new AdminStatMemSvc();
		AdminStatListSvc adminStatListSvc = new AdminStatListSvc();
		
		statP = adminStatCalPaySvc.getPaStat(sYear, sMonth);		statM = adminStatCalPaySvc.getMpStat(sYear, sMonth);	// 카운트
		rq = adminStatCalRqSvc.getRq(sYear, sMonth);		rqYes = adminStatCalRqSvc.getRqYes(sYear, sMonth);		rqNo = adminStatCalRqSvc.getRqNo(sYear, sMonth);
		member = adminStatMemSvc.getMemStat();		memberA = adminStatMemSvc.getMemAStat();
		memberB = adminStatMemSvc.getMemBStat();	memberD = adminStatMemSvc.getMemDStat();
		paList = adminStatListSvc.getPaList(sYear, sMonth);	mpList = adminStatListSvc.getMpList(sYear, sMonth);
		
		request.setAttribute("ci", ci);
		
		request.setAttribute("statP", statP);		request.setAttribute("statM", statM);	//	 현재 월의 매출액
		
		request.setAttribute("rq", rq);		request.setAttribute("rqYes", rqYes);		request.setAttribute("rqNo", rqNo);
		
		request.setAttribute("member", member);			request.setAttribute("memberA", memberA);
		request.setAttribute("memberB", memberB);		request.setAttribute("memberD", memberD);
		
		request.setAttribute("memberB", memberB);		request.setAttribute("memberD", memberD);
		
		request.setAttribute("paList", paList);		request.setAttribute("mpList", mpList);
		// 달력 출력용 정보 인스턴스와 일정 목록 인스턴스를 request 객체에 저장
		
		System.out.println("AdminStatCtrl Operated");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stat/stat_main.jsp");
		dispatcher.forward(request, response);	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
