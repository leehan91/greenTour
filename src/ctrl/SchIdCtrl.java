package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/schId")
public class SchIdCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SchIdCtrl() {super();}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String regist = request.getParameter("regist1") + "-" + request.getParameter("regist2");
		String url = request.getParameter("url").replace('$', '&');
		
		SchIdSvc schIdSvc = new SchIdSvc(); 
		MemberInfo mi = schIdSvc.getSchId(name, regist);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		request.setAttribute("mi", mi);
		
		if(mi != null) {	
			out.println("<script>");
			out.println("alert('회원님의 아이디는 " + mi.getMi_id() + " 입니다.');");
			out.println("location.replace('" + url + "');");
			out.println("</script>");
			out.close();
			
		} else if(name == "" || regist == "-") {
			out.println("<script>");
			out.println("alert('이름 또는 주민번호를 입력해주세요.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
		}
		
		else {
			out.println("<script>");
			out.println("alert('일치하는 회원 정보가 없습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
		}
	}

}
