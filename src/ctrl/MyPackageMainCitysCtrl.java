package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/mypackage_main_citys")
public class MyPackageMainCitysCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
          
    public MyPackageMainCitysCtrl() { super(); }
	
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
		
		String nation = request.getParameter("nation");
		
		MyPackageMainCitysSvc myPackageMainCitysSvc = new MyPackageMainCitysSvc();
		ArrayList<CtgrCity> cityList = myPackageMainCitysSvc.getCityList(nation);
		
		request.setAttribute("cityList", cityList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_main.jsp");
		dispatcher.forward(request, response);
		
//		response.setContentType("text/html; charset=utf-8");
//		PrintWriter out = response.getWriter();
//		out.println(cityList.size());
//		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
