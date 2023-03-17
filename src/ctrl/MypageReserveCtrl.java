package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;


@WebServlet("/mypage_reserve")
public class MypageReserveCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MypageReserveCtrl() { super(); }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// ȸ���� ���� ���� �ҷ�����
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�α��� �� ����Ͻ� �� �ֽ��ϴ�.');");
			out.println("location.replace('login_form.jsp?url=mypage_reserve')");
			out.println("</script>");
			out.close();
		}
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// ���� ������ ��ȣ, ������ ũ��, ��� ũ��, ���ڵ�(�Խñ�) ����, ������ ����, ���� ������ ���� ������ ������
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		// cpage ���� ������ �޾Ƽ� int ������ ����ȯ ��Ŵ (���Ȼ��� ������ ��� ������ �ؾ� �ϱ� ����)
		
		String miid = loginInfo.getMi_id();	
		String where = " where mi_id = '"+ miid +"'";

		
		OrderListSvc orderListSvc = new OrderListSvc();
		rcnt = orderListSvc.getOrderListCount(where);
		ArrayList<OrderPaInfo> orderList = orderListSvc.getOrderList(where, cpage, psize);
		ArrayList<OrderMpInfo> myorderList = orderListSvc.getMyOrderList(where, cpage, psize);
		
		ArrayList<FlightInfo> flightList = orderListSvc.getFlightList();

		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		// ����¡�� �ʿ��� �������� PageInfo�� �ν��Ͻ��� ����
		
		request.setAttribute("orderList", orderList);
		request.setAttribute("myorderList", myorderList);
		request.setAttribute("flightList", flightList);
		request.setAttribute("pageInfo", pageInfo);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypage/mypage_reserve.jsp");
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doGet(request, response);
	}

}
