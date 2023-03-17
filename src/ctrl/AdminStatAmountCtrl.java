package ctrl;

import java.io.*;
import java.time.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/admin_amount")
public class AdminStatAmountCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminStatAmountCtrl() {
        super();
    }
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
		
		
		StatInfo pa = new StatInfo();
		StatInfo mp = new StatInfo();
		
		StatInfo si1 = new StatInfo();	StatInfo si2 = new StatInfo();
		
		StatInfo sp1 = new StatInfo();		StatInfo sp2 = new StatInfo();		StatInfo sp3 = new StatInfo();
		StatInfo sp4 = new StatInfo();		StatInfo sp5 = new StatInfo();		StatInfo sp6 = new StatInfo();
		StatInfo sp7 = new StatInfo();		StatInfo sp8 = new StatInfo();		StatInfo sp9 = new StatInfo();
		StatInfo sp10 = new StatInfo();		StatInfo sp11 = new StatInfo();		StatInfo sp12 = new StatInfo();
		
		StatInfo sm1 = new StatInfo();		StatInfo sm2 = new StatInfo();		StatInfo sm3 = new StatInfo();
		StatInfo sm4 = new StatInfo();		StatInfo sm5 = new StatInfo();		StatInfo sm6 = new StatInfo();
		StatInfo sm7 = new StatInfo();		StatInfo sm8 = new StatInfo();		StatInfo sm9 = new StatInfo();
		StatInfo sm10 = new StatInfo();		StatInfo sm11 = new StatInfo();		StatInfo sm12 = new StatInfo();
		
		ArrayList<StatInfo> palist = new ArrayList<StatInfo>();
		ArrayList<StatInfo> mplist = new ArrayList<StatInfo>();

			
		if (request.getParameter("schYear") == null) {
			sYear = cYear;	sMonth = cMonth;	sDay = cDay;
		} else {
			sYear = Integer.parseInt(request.getParameter("schYear"));
			sMonth = Integer.parseInt(request.getParameter("schMonth"));
			sDay = 1;
		}
		
		int sm = 0, em = 0;
		
		if (cMonth <= 6) {
			sm = 1; em = 6;
		}else if(cMonth > 6) {
			sm = 7; em = 12;
		}
		
		palist  = adminStatCalPaySvc.getPalistStat(sYear, sm, em);
		mplist  = adminStatCalPaySvc.getMplistStat(sYear, sm, em);
		pa = adminStatCalPaySvc.getPaStat(sYear, cMonth);
		mp = adminStatCalPaySvc.getMpStat(sYear, cMonth);
		
		request.setAttribute("ci", ci);
		request.setAttribute("pa", pa);
		request.setAttribute("mp", mp);
		request.setAttribute("palist", palist);
		request.setAttribute("mplist", mplist);
		
		si1 = adminStatCalPaySvc.getPaStat(sYear, cMonth);
		si2 = adminStatCalPaySvc.getMpStat(sYear, cMonth);
		
		sp1  = adminStatCalPaySvc.getPaStat(sYear, 1);		sp2  = adminStatCalPaySvc.getPaStat(sYear, 2);
		sp3  = adminStatCalPaySvc.getPaStat(sYear, 3);		sp4  = adminStatCalPaySvc.getPaStat(sYear, 4);
		sp5  = adminStatCalPaySvc.getPaStat(sYear, 5);		sp6  = adminStatCalPaySvc.getPaStat(sYear, 6);
		sp7  = adminStatCalPaySvc.getPaStat(sYear, 7);		sp8  = adminStatCalPaySvc.getPaStat(sYear, 8);
		sp9  = adminStatCalPaySvc.getPaStat(sYear, 9);		sp10  = adminStatCalPaySvc.getPaStat(sYear, 10);
		sp11  = adminStatCalPaySvc.getPaStat(sYear, 11);	sp12  = adminStatCalPaySvc.getPaStat(sYear, 12);		

		sm1  = adminStatCalPaySvc.getMpStat(sYear, 1);		sm2  = adminStatCalPaySvc.getMpStat(sYear, 2);
		sm3  = adminStatCalPaySvc.getMpStat(sYear, 3);		sm4  = adminStatCalPaySvc.getMpStat(sYear, 4);
		sm5  = adminStatCalPaySvc.getMpStat(sYear, 5);		sm6  = adminStatCalPaySvc.getMpStat(sYear, 6);
		sm7  = adminStatCalPaySvc.getMpStat(sYear, 7);		sm8  = adminStatCalPaySvc.getMpStat(sYear, 8);
		sm9  = adminStatCalPaySvc.getMpStat(sYear, 9);		sm10  = adminStatCalPaySvc.getMpStat(sYear, 10);
		sm11  = adminStatCalPaySvc.getMpStat(sYear, 11);	sm12  = adminStatCalPaySvc.getMpStat(sYear, 12);
		
		request.setAttribute("si1", si1);	request.setAttribute("si2", si2);
		
		request.setAttribute("sp1", sp1);	request.setAttribute("sp2", sp2);
		request.setAttribute("sp3", sp3);	request.setAttribute("sp4", sp4);
		request.setAttribute("sp5", sp5);	request.setAttribute("sp6", sp6);
		request.setAttribute("sp7", sp7);	request.setAttribute("sp8", sp8);
		request.setAttribute("sp9", sp9);	request.setAttribute("sp10", sp10);
		request.setAttribute("sp11", sp11);	request.setAttribute("sp12", sp12);
		
		request.setAttribute("sm1", sm1);	request.setAttribute("sm2", sm2);
		request.setAttribute("sm3", sm3);	request.setAttribute("sm4", sm4);
		request.setAttribute("sm5", sm5);	request.setAttribute("sm6", sm6);
		request.setAttribute("sm7", sm7);	request.setAttribute("sm8", sm8);
		request.setAttribute("sm9", sm9);	request.setAttribute("sm10", sm10);
		request.setAttribute("sm11", sm11);	request.setAttribute("sm12", sm12);
		
		System.out.println("AdminStatAmountCtrl Operated");
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/stat/stat_amount.jsp");
		dispatcher.forward(request, response);
	
	}
	
	
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

