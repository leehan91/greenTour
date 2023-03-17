package ctrl;

import static db.JdbcUtil.commit;
import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/package_for_pay")
public class PackageReservForPayCrtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PackageReservForPayCrtl() {super();}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			// 현재 로그인 정보가 없다면
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('로그인 후 이용 가능합니다..');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}

		String miid = loginInfo.getMi_id();
		
		// 패키지 결제창 띄우기
		String piCode = request.getParameter("piCode");
		String piName = request.getParameter("piName");
		String ccid = request.getParameter("ccid");
		String korName = request.getParameter("korName");
		String fiCode = request.getParameter("fiCode");
		String departure = request.getParameter("departure");
		String period = request.getParameter("period");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String total = request.getParameter("total");
		String adult = request.getParameter("adultCnt");
		String child = request.getParameter("childCnt");
		
		OrderPaInfo op = new OrderPaInfo();
		op.setPi_code(piCode);
		op.setOp_name(piName);
		op.setMi_id(miid);
		op.setOp_period(period);
		op.setOp_spoint("KORICN");
		op.setOp_leave(departure);
		op.setFi_code(fiCode);
		op.setCc_id(ccid);
		op.setOp_customer(korName);
		op.setOp_phone(phone);
		op.setOp_email(email);
		op.setOp_pay(Integer.parseInt(total));
		op.setOp_adult(Integer.parseInt(adult));
		op.setOp_child(Integer.parseInt(child));

		PackageOpcodeSvc packageOpcodeSvc = new PackageOpcodeSvc();
		String opCode = packageOpcodeSvc.packgeOpcodeNew();
	
		int mile = loginInfo.getMi_mileage();
		

		System.out.println("opCode : "+ opCode);
		request.setAttribute("opCode", opCode);
		request.setAttribute("orderPaInfo", op);
		request.setAttribute("mile", mile);

		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/reserv/package_pay.jsp");
		dispatcher.forward(request, response);
	}	

}
