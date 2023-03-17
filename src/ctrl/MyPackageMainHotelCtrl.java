package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/mypackage_main_hotel")
public class MyPackageMainHotelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyPackageMainHotelCtrl() { super(); }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		String city = request.getParameter("city");
		String ccid = request.getParameter("ccid");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		int adult = Integer.parseInt(request.getParameter("adult"));
		int child = Integer.parseInt(request.getParameter("child"));
		String air = request.getParameter("air");	// '대한항공/KOAITHAHKT001' //KO + ficode
		String ficode = air.substring(7);
		int fridx = Integer.parseInt(request.getParameter("fridx"));
		//System.out.println("fridx :" + fridx);
//		String ccid = air.substring(9, 15);
		String grade = request.getParameter("grade");
		int atotal = Integer.parseInt(request.getParameter("total"));
		//System.out.println(grade);
		
//		String cook = request.getHeader("Cookie");	
//		Cookie[] cookies = request.getCookies();
//		boolean isAir = false;
//		for(int i=0; i<cookies.length; i++){
//			if(cookies[i].getName().equals("air")){
//				isAir = true;
//				cookies[i].setValue(air);				
//			}else if(cookies[i].getName().equals("city")){
//				cookies[i].setValue(city);
//			}else if(cookies[i].getName().equals("sdate")){
//				cookies[i].setValue(sdate);
//			}else if(cookies[i].getName().equals("edate")){
//				cookies[i].setValue(edate);
//			}else if(cookies[i].getName().equals("child")){
//				cookies[i].setValue(child+"");
//			}else if(cookies[i].getName().equals("adult")){
//				cookies[i].setValue(adult+"");
//			}else if(cookies[i].getName().equals("grade")){
//				cookies[i].setValue(grade);
//			}else if(cookies[i].getName().equals("total")){
//				cookies[i].setValue(total);
//			}
//		}
//		if (!isAir) {	// air 쿠키가 없으면 생성 
//			Cookie cookie4 = new Cookie("adult", adult+"");		Cookie cookie5 = new Cookie("child", child+"");		
//			Cookie cookie6 = new Cookie("air", air);			Cookie cookie7 = new Cookie("total", total);		
//			Cookie cookie8 = new Cookie("grade", grade);
//			
//			cookie4.setMaxAge(1800);			cookie5.setMaxAge(1800);			cookie6.setMaxAge(1800);
//			cookie7.setMaxAge(1800);			cookie8.setMaxAge(1800);
//			response.addCookie(cookie4);			response.addCookie(cookie5);			response.addCookie(cookie6);
//			response.addCookie(cookie7);			response.addCookie(cookie8);
//		}
		
		MyPackageMainHotelSvc myPackageMainHotelSvc = new MyPackageMainHotelSvc();
		ArrayList<HotelInfo> hotelList = myPackageMainHotelSvc.getHotelList(ccid);
		
		MyPackageMy mm = new MyPackageMy();
		mm.setMm_destination(city);
		mm.setCc_id(ccid);
		mm.setFi_code(ficode);
		mm.setFr_idx(fridx);
		mm.setMm_agrade(grade);
		mm.setMm_adult(adult);
		mm.setMm_child(child);
		mm.setMm_atotal(atotal); // atotal = 항공가격
		
		request.setAttribute("mypackagemy", mm);
		
		request.setAttribute("sdate", sdate);
		request.setAttribute("edate", edate);		
		request.setAttribute("air", air);			 
		
		request.setAttribute("hotelList", hotelList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_hotel.jsp");
		dispatcher.forward(request, response);

	}

}
