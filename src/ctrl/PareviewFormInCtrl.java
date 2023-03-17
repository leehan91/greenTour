package ctrl;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

// pareview_list.jsp에서 글등록 클릭하여 
@WebServlet("/pareview_form_in")
public class PareviewFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PareviewFormInCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ArrayList<CsPareview> csPareview = new ArrayList<CsPareview>();
		CsPareview cp = new CsPareview();
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('login_form.jsp?url=pareview_form_in');");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		
		PareviewFormSvc pareviewFormSvc = new PareviewFormSvc();
		ArrayList<CsPareview> formList = pareviewFormSvc.getPareviewForm(miid);
		
		request.setAttribute("formList", formList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/review/pareview_form_in.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
