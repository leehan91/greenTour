package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;	// session 을 사용하기 위해 http.*;(all)
import svc.*;
import vo.*;

@WebServlet("/pareview_proc_in")
public class PareviewProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PareviewProcInCtrl() { super();}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('login_form.jsp?url=pareview_list');");
			out.println("</script>");
			out.close();
		}
		
		String miid = loginInfo.getMi_id();
		
		String name = request.getParameter("name");
		String uid = request.getParameter("uid");
		String list = request.getParameter("list");
		String title = request.getParameter("title");
		int score = Integer.parseInt(request.getParameter("reviewStar"));
		String content = request.getParameter("content");
		if (content != null) 	content = getStr(content);
		System.out.println(miid + "/" + name + "/" + uid + "/" + list + "/" 
		+ title + "/" + score  + "/" + content);
		String[] cpName = list.split("/");

		CsPareview cp = new CsPareview(); 
		cp.setMi_id(uid);
		cp.setMi_name(name);
		cp.setCp_title(title);
		cp.setCp_name(cpName[0]);
		cp.setOp_code(cpName[1]);
		cp.setCp_content(content);
		cp.setCp_score(score);
		cp.setOp_code(cp.getOp_code());
		
		PareviewProcInSvc pareviewProcInSvc = new PareviewProcInSvc();
		int result = pareviewProcInSvc.PareviewInsert(cp);
		// int 값 받아서 쓰는 곳이 없음 
		
		
		response.sendRedirect("pareview_list");

	}
	private String getStr(String str) {
		// 사용자가 입력한 문자열에 대한 처리를 해서 리턴하는 메소드
		// null이 아닐때 사용하거나 null인지 검사를 하고 사용
		return str.trim().replace("'","''").replace("<", "&lt;");
	}

}
