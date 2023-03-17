package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/schPw")
public class SchPwCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SchPwCtrl() {super();}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid");
		String name = request.getParameter("name");
		String regist = request.getParameter("regist1") + "-" + request.getParameter("regist2");
		String url = request.getParameter("url").replace('$', '&');
		
		SchPwSvc schPwSvc = new SchPwSvc(); 
		MemberInfo mi = schPwSvc.getSchPw(uid, name, regist);
		
		request.setAttribute("mi", mi);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(mi != null) {	
			out.println("<script>");
			out.println("alert('회원님의 비밀번호는 " + mi.getMi_pw() + " 입니다.');");
			out.println("location.replace('" + url + "');");
			out.println("</script>");
			out.close();
			
		} else if(uid == "" || name == "" || regist == "-") {
			out.println("<script>");
			out.println("alert('회원 정보를 입력해주세요.');");
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
