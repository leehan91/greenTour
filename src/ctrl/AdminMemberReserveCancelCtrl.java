package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/member_reserve_cancel")
public class AdminMemberReserveCancelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public AdminMemberReserveCancelCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String miid = request.getParameter("frmMiid");
		String code = request.getParameter("code");
		AdminMemberCancelSvc adminMemberCancelSvc = new AdminMemberCancelSvc();
		int result = adminMemberCancelSvc.memReserveUP(miid, code);
		
		if (result >= 1) {	// 정상적으로 글이 등록되었으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(result);
    	} else {	// 글 등록 실패		
    		response.setContentType("text/html; charset=utf-8");
    		PrintWriter out = response.getWriter();
    		out.println("<script>");
    		out.println("alert('글등록에 실패했습니다.\\n다시 시도하세요.');");
    		out.println("history.back();");
    		out.println("</script>");
    		out.close();
    	}
	}

}
