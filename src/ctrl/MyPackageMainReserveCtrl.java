package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/mypackage_main_reserve")
public class MyPackageMainReserveCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public MyPackageMainReserveCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�α��� �� ����Ͻ� �� �ֽ��ϴ�.');");
			out.println("location.replace('login_form.jsp?url=mypackage_main')");
			out.println("</script>");
			out.close();
		}
		
		String miid =""; String miname = "";
		if(loginInfo != null) {
			miid = loginInfo.getMi_id();
			miname = loginInfo.getMi_name();
		}
		
		String ccid = request.getParameter("ccid");
		String city = request.getParameter("city");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		int adult = Integer.parseInt(request.getParameter("adult"));
		int child = Integer.parseInt(request.getParameter("child"));
		
		
		String air = request.getParameter("air");
		String agrade = request.getParameter("agrade");
		String ficode = request.getParameter("ficode");
		int fridx = Integer.parseInt(request.getParameter("fridx"));
		int atotal = Integer.parseInt(request.getParameter("atotal"));
		
		String hotel = request.getParameter("hotel");
		String hicode = request.getParameter("hicode");
		String hgrade = request.getParameter("hgrade");
		int htotal = Integer.parseInt(request.getParameter("htotal"));
		
		String total = request.getParameter("total");		
		String ptcode = request.getParameter("ptcode");
		String tours = request.getParameter("frmtourlist");
		int ttotal = 0;
		if(!request.getParameter("ttotal").equals("")) {
			ttotal = Integer.parseInt(request.getParameter("ttotal"));						
		}
		
		MyPackageMy mm = new MyPackageMy();
		mm.setMi_id(miid);
		mm.setCc_id(ccid);
		mm.setMm_destination(city);
		mm.setMm_child(child);
		mm.setMm_adult(adult);
		mm.setFi_code(ficode);
		mm.setFr_idx(fridx);
		mm.setMm_agrade(agrade);
		mm.setMm_atotal(atotal);
		mm.setHi_code(hicode);
		mm.setMm_hgrade(hgrade);
		mm.setMm_htotal(htotal);
		mm.setMm_tour(ptcode);
		mm.setMm_ttotal(ttotal);
		
		String city3 = ccid.substring(3);	// EX)TPE 
		MyPackageMainReserveSvc mypackageMainReserveSvc = new MyPackageMainReserveSvc();
		String mmcode = mypackageMainReserveSvc.getMmCode(city3);	// ������Ű�� ��ȣ �޾ƿ��� �޼ҵ� 
				
		String mmname = "[" + city + "] " + miname + " ���� ������  ��Ű��";
		
		mm.setMm_code(mmcode);// ������ mmcode�� mm�� ���� 
		mm.setMm_name(mmname);// �����ش��� ������ Ÿ������ ���� ��Ű��
		
		
		request.setAttribute("hotel", hotel);
		request.setAttribute("air", air);
		request.setAttribute("sdate", sdate);
		request.setAttribute("edate", edate);
		request.setAttribute("total", total);	// ������� ��ģ ���� 
		
		if(!tours.equals("") && tours.indexOf(",") == 0) tours = tours.substring(2);		
		request.setAttribute("tours", tours);	// �����̸��� ", " �� ������ 
		
		request.setAttribute("mypackagemy", mm);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_reserve.jsp");
		dispatcher.forward(request, response);
		
	}
}
