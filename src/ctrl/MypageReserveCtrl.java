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
		// 회원의 예약 정보 불러오기
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('login_form.jsp?url=mypage_reserve')");
			out.println("</script>");
			out.close();
		}
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작 페이지 등을 저장할 변수들
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		// cpage 값이 있으면 받아서 int 형으로 형변환 시킴 (보안상의 이유와 산술 연산을 해야 하기 때문)
		
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
		// 페이징에 필요한 정보들을 PageInfo형 인스턴스에 저장
		
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
