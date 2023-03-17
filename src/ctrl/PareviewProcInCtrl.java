package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;	// session �� ����ϱ� ���� http.*;(all)
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
			out.println("alert('�α��� �� ����Ͻ� �� �ֽ��ϴ�.');");
			out.println("location.replace('login_form.jsp?url=pareview_list');");
			out.println("</script>");
			out.close();
		}
		
		String miid = loginInfo.getMi_id();
		
		String writer = request.getParameter("writer");
		String uid = request.getParameter("uid");
		String reserve = request.getParameter("reserve");
		String title = request.getParameter("title");
		int score = Integer.parseInt(request.getParameter("reviewStar"));
		String content = request.getParameter("content");
		if (content != null) 	content = getStr(content);

		CsPareview cp = new CsPareview(); 
		cp.setMi_id(uid);
		cp.setCp_title(title);
		cp.setCp_content(content);
		cp.setCp_score(score);
		cp.setOp_code(cp.getOp_code());
		
		PareviewProcInSvc pareviewProcInSvc = new PareviewProcInSvc();
		int result = pareviewProcInSvc.PareviewInsert(cp);
		// int �� �޾Ƽ� ���� ���� ���� 
		
		
		response.sendRedirect("pareview_list");

	}
	private String getStr(String str) {
		// ����ڰ� �Է��� ���ڿ��� ���� ó���� �ؼ� �����ϴ� �޼ҵ�
		// null�� �ƴҶ� ����ϰų� null���� �˻縦 �ϰ� ���
		return str.trim().replace("'","''").replace("<", "&lt;");
	}

}
