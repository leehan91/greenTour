package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

import vo.MemberInfo;
import vo.OrderMpInfo;

@WebServlet("/mypackage_end")
public class MyPackageEndCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;      
    
    public MyPackageEndCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String omcode = request.getParameter("omcode");
		
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
		
		MyPackageEndSvc myPackageEndSvc = new MyPackageEndSvc();
		OrderMpInfo orderMpInfo = myPackageEndSvc.getOmInfo(omcode);
		
		String loginId = loginInfo.getMi_id().trim();
		System.out.println("loginId : " +loginId);
		String checkId = orderMpInfo.getMi_id().trim();
		System.out.println("chkId : " + checkId);
		
		if(loginId.equals(checkId)) {	// 검색정보의 아이디와 현재 로그인된 아이디가 같으면 정상작동 
			
			request.setAttribute("orderMpInfo", orderMpInfo);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_end.jsp");
			dispatcher.forward(request, response);
			
		}else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로입니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	}
}
