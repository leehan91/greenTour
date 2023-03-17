package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/pareview_view")
public class PareviewViewCrtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PareviewViewCrtl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpidx = Integer.parseInt(request.getParameter("cpidx"));
		
		PareviewViewSvc pareviewViewSvc = new PareviewViewSvc();
		int result = pareviewViewSvc.readUpdate(cpidx);			// 사용자가 선택한 게시글의 조회수를 증가시키는 메소드 호출
		
		CsPareview cp = pareviewViewSvc.getPareviewInfo(cpidx);		// 사용자가 선택한 게시글의 내용들을 CsNotice형 인스턴스로 받아옴
		

		if (cp == null) {		// 보여줄 게시글이 없으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// 보여줄 게시글이 있으면
			request.setAttribute("cp", cp);
			RequestDispatcher dispatcher = request.getRequestDispatcher("front/review/pareview_view.jsp");
			dispatcher.forward(request, response);
		
		}		
	}

}
