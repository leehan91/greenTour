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
		// �ش� �� ���� ����Ǿ� �ִ� �������� ScheduleInfo �� �ν��Ͻ��� ������ ArrayList ���� 
		
		// ���� ��¥(������)�� �޷� ���� ��¥(������)�� ������ ������ ����
		int cYear, cMonth, cDay, sYear, sMonth, sDay;
		LocalDate today = LocalDate.now();		// ���� ��¥�� ���� �ν��Ͻ� ����
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
		// �޷� ��¿� �ʿ��� �������� CalendarInfo �� �ν��Ͻ� ci�� ����

		
		AdminStatCalPaySvc adminStatCalPaySvc = new AdminStatCalPaySvc();
		AdminStatCalRqSvc adminStatCalRqSvc = new AdminStatCalRqSvc();
		AdminStatMemSvc adminStatMemSvc = new AdminStatMemSvc();
		AdminStatListSvc adminStatListSvc = new AdminStatListSvc();
		
		statP = adminStatCalPaySvc.getPaStat(sYear, sMonth);		statM = adminStatCalPaySvc.getMpStat(sYear, sMonth);	// ī��Ʈ
		rq = adminStatCalRqSvc.getRq(sYear, sMonth);		rqYes = adminStatCalRqSvc.getRqYes(sYear, sMonth);		rqNo = adminStatCalRqSvc.getRqNo(sYear, sMonth);
		member = adminStatMemSvc.getMemStat();		memberA = adminStatMemSvc.getMemAStat();
		memberB = adminStatMemSvc.getMemBStat();	memberD = adminStatMemSvc.getMemDStat();
		paList = adminStatListSvc.getPaList(sYear, sMonth);	mpList = adminStatListSvc.getMpList(sYear, sMonth);
		
		request.setAttribute("ci", ci);
		
		request.setAttribute("statP", statP);		request.setAttribute("statM", statM);	//	 ���� ���� �����
		
		request.setAttribute("rq", rq);		request.setAttribute("rqYes", rqYes);		request.setAttribute("rqNo", rqNo);
		
		request.setAttribute("member", member);			request.setAttribute("memberA", memberA);
		request.setAttribute("memberB", memberB);		request.setAttribute("memberD", memberD);
		
		request.setAttribute("memberB", memberB);		request.setAttribute("memberD", memberD);
		
		request.setAttribute("paList", paList);		request.setAttribute("mpList", mpList);
		// �޷� ��¿� ���� �ν��Ͻ��� ���� ��� �ν��Ͻ��� request ��ü�� ����
		
		System.out.println("AdminStatCtrl Operated");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stat/stat_main.jsp");
		dispatcher.forward(request, response);	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
