package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/package_pay_view")
public class PackagePayViewCtrl extends HttpServlet {
	//결제 후 t_order_painfo 에 값 저장
	private static final long serialVersionUID = 1L;
    public PackagePayViewCtrl() {        super();    }
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
		String opCode = request.getParameter("opCode");
		String piCode = request.getParameter("piCode");
		String opName = request.getParameter("opName");
		String ccid = request.getParameter("ccid");
		String customer = request.getParameter("customer");
		String spoint = request.getParameter("spoint");
		String departure = request.getParameter("departure");
		String fiCode = request.getParameter("fiCode");
		String period = request.getParameter("period");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String total = request.getParameter("total");
		String adult = request.getParameter("adult");
		String child = request.getParameter("child");
		String payment = request.getParameter("payment");
		String umile = request.getParameter("umile");
		
		OrderPaInfo op = new OrderPaInfo();
		// MemberMileage mm = new MemberMileage();
		
		op.setOp_code(opCode);
		op.setPi_code(piCode);
		op.setOp_name(opName);
		op.setMi_id(miid);	
		op.setCc_id(ccid);
		op.setOp_customer(customer);
		op.setOp_spoint(spoint);
		op.setOp_period(period);
		op.setOp_phone(phone);
		op.setOp_email(email);
		op.setOp_adult(Integer.parseInt(adult));
		op.setOp_child(Integer.parseInt(child));
		op.setOp_pay(Integer.parseInt(total));
		op.setOp_payment(payment);
		op.setFi_code(fiCode);
		op.setOp_leave(departure);
//		mm.setMi_id(miid);
//		mm.setMm_mileage(Integer.parseInt(umile));
//		mm.setMm_detail(opName);
//		
		PaOrderProcInSvc paOrderProcInSvc = new PaOrderProcInSvc();

		

		String result = null;
		result = paOrderProcInSvc.orderInsert(miid, op);
		
		String[] arr = result.split(",");
		if(arr[1].equals(arr[2])) {		//정상적으로 결제가 이루어졌으면
			
			response.sendRedirect("paorder_end?opCode=" + arr[0]);
			
		}	
		else{		//정상적으로 결제가 이루어지지 않았으면 
						
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('결제가 정상적으로 처리되지 않았습니다. \\n 고객 센터에 문의하세요. ');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

	}
}
