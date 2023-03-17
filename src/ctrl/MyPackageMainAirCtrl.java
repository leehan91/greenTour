package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/mypackage_main_air")
public class MyPackageMainAirCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public MyPackageMainAirCtrl() { super(); }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('login_form.jsp?url=mypackage_main')");
			out.println("</script>");
			out.close();
		}
		
		
		
		
		// 쿠키 ============================================================================
//		String cook = request.getHeader("Cookie");
//		
//		Cookie[] cookies = request.getCookies();
//		boolean isCity = false;
//		for(int i=0; i<cookies.length; i++){
//			if(cookies[i].getName().equals("city")){
//				isCity = true;
//				cookies[i].setValue(city);				
//			}else if(cookies[i].getName().equals("sdate")){
//				cookies[i].setValue(sdate);				
//			}else if(cookies[i].getName().equals("edate")){
//				cookies[i].setValue(edate);
//			}
//		}
//		if (!isCity) {	// city 쿠키가 없으면 생성 
//			Cookie cookie1 = new Cookie("city", city);
//			Cookie cookie2 = new Cookie("sdate", sdate);
//			Cookie cookie3 = new Cookie("edate", edate);
//			cookie1.setMaxAge(1800);
//			cookie2.setMaxAge(1800);
//			cookie3.setMaxAge(1800);
//			response.addCookie(cookie1);
//			response.addCookie(cookie2);
//			response.addCookie(cookie3);
//		}
////		}

		// 쿠키 ============================================================================
		
		
		String city = request.getParameter("city");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		
		
		MyPackageMainAirSvc myPackageMainAirSvc = new MyPackageMainAirSvc();
		ArrayList<FlightInfo> airList = myPackageMainAirSvc.getAirList(city, sdate, edate);
		
		if(airList.size() == 0) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('선택가능한 항공편이 없습니다. 다른날짜를 선택해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		String ccid = myPackageMainAirSvc.getCcid(city);
		
		
		request.setAttribute("ccid", ccid);
		
		request.setAttribute("airList", airList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_air.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
