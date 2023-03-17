package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/mypage_mileage")
public class MypageMileageCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MypageMileageCtrl() {super();}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// ���� ������ ��ȣ, ������ ũ��, ��� ũ��, ���ڵ�(�Խñ�) ����, ������ ����, ���� ������ ���� ������ ������
		
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		// cpage ���� ������ �޾Ƽ� int ������ ����ȯ ��Ŵ (���Ȼ��� ������ ��� ������ �ؾ� �ϱ� ����)
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();	
		String where = " where mi_id = '"+ miid +"'";

		
		MileageSvc mileageSvc = new MileageSvc();
		rcnt = mileageSvc.getOrderListCount(where);
		ArrayList<OrderPaInfo> orderList = mileageSvc.getOrderList(where, cpage, psize);
		MemberInfo mi = mileageSvc.getMemberMileage(miid);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		
		request.setAttribute("orderList", orderList);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("mi", mi);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/front/mypage/mypage_mileage.jsp");
		dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
