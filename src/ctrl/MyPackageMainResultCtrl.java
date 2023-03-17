package ctrl;

import java.time.Period;
import java.util.*;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import svc.*;
import vo.*;


@WebServlet("/mypackage_main_result")
public class MyPackageMainResultCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;      
    
    public MyPackageMainResultCtrl() {super();}

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
		
		String miid = loginInfo.getMi_id();
		String miname = loginInfo.getMi_name();
		String miphone = loginInfo.getMi_phone();
		String email = loginInfo.getMi_email();
		
		String mmcode = request.getParameter("mmcode");
		String mmname = request.getParameter("mmname");
		String cityname = request.getParameter("cityname");
		String ccid = request.getParameter("ccid");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		int adult = Integer.parseInt(request.getParameter("adult"));
		int child = Integer.parseInt(request.getParameter("child"));
		String hotel = request.getParameter("hotel");
		String hgrade = request.getParameter("hgrade");
		String hicode = request.getParameter("hicode");
		String air = request.getParameter("air");
		String agrade = request.getParameter("agrade");
		String ficode = request.getParameter("ficode");
		int fridx = Integer.parseInt(request.getParameter("fridx"));
		int price = Integer.parseInt(request.getParameter("total"));
		int atotal = Integer.parseInt(request.getParameter("atotal"));
		int htotal = Integer.parseInt(request.getParameter("htotal"));
		int ttotal = Integer.parseInt(request.getParameter("ttotal"));
		String payment = request.getParameter("payment");
		String period = "";
		
		// sdate : 2023-02-20 edate : 2023-02-24
		 
		    try{// String Type�� Date Type���� ĳ�����ϸ鼭 ����� ���ܷ� ���� ���⼭ ����ó�� ������ ������ �����Ϸ����� ������ �߻��ؼ� �������� �� �� ����.
		        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		        // date1, date2 �� ��¥�� parse()�� ���� Date������ ��ȯ.
		        Date FirstDate = format.parse(sdate);
		        Date SecondDate = format.parse(edate);
		        
		        // Date�� ��ȯ�� �� ��¥�� ����� �� �� ���ϰ����� long type ������ �ʱ�ȭ �ϰ� �ִ�.
		        // ������ -950400000. long type ���� return �ȴ�.
		        long calDate = FirstDate.getTime() - SecondDate.getTime(); 
		        
		        // Date.getTime() �� �ش糯¥�� ��������1970�� 00:00:00 ���� �� �ʰ� �귶������ ��ȯ���ش�. 
		        // ���� 24*60*60*1000(�� �ð����� ���� ������) �� �����ָ� �ϼ��� ���´�.
		        long calDateDays = calDate / ( 24*60*60*1000); 
		 
		        calDateDays = Math.abs(calDateDays);
		        String result = String.valueOf(calDateDays);
		        period = result;
		        
		        //System.out.println("�� ��¥�� ��¥ ����: "+ calDateDays);
		        }catch(ParseException e){
		            e.printStackTrace();// ���� ó��
		        }
		    
	    String calperiod = period+"�� "+(Integer.parseInt(period)+1)+"��";
		// calperiod : ��� ���� 
		int umile = 0;
		int smile = 0;
		String tours = request.getParameter("tours");
		
		MyPackageMy mypackagemy = new MyPackageMy();
		mypackagemy.setMm_code(mmcode);
		mypackagemy.setMi_id(miid);
		mypackagemy.setMm_name(mmname);
		mypackagemy.setCc_id(ccid);
		mypackagemy.setFi_code(ficode);
		mypackagemy.setHi_code(hicode);
		mypackagemy.setFr_idx(fridx);
		mypackagemy.setMm_tour(tours);
		mypackagemy.setMm_adult(adult);
		mypackagemy.setMm_child(child);
		mypackagemy.setMm_price(price);
		mypackagemy.setMm_destination(cityname);
		mypackagemy.setMm_hgrade(hgrade);
		mypackagemy.setMm_agrade(agrade);
		mypackagemy.setMm_atotal(atotal);
		mypackagemy.setMm_htotal(htotal);
		mypackagemy.setMm_ttotal(ttotal);				
		mypackagemy.setMm_period(calperiod);
		
		MemberInfo memberinfo = new MemberInfo();
		memberinfo.setMi_id(miid);
		memberinfo.setMi_name(miname);
		memberinfo.setMi_email(email);
		memberinfo.setMi_phone(miphone);
		
		
		MyPackageMainResultSvc myPackageMainResultSvc = new MyPackageMainResultSvc();
		
		// int - > String �ιٲ� 
		String result = myPackageMainResultSvc.myPackageInsert(mypackagemy, memberinfo, payment);
		// �����Ƽ� memberinfo ���� �� , mypackagemy - ������Ű�� ���̺� , payment �������
		
		
//		OrderMpInfo orderMpInfo = myPackageMainResultSvc.getOmInfo(mmcode); // �̰� ���� ���� 
		
		
		String[] arr = result.split("/");
		int chk = Integer.parseInt(arr[0]);
		String omcode = arr[1];
		
		
		// result ©�� �տ����� 2 ���� �� �� ó�� (chk/omcode)�� ���ϵ� 
		
		if(chk == 2) {//�� ó�� ������ 
//			request.setAttribute("orderMpInfo", orderMpInfo);
			
			response.sendRedirect("mypackage_end?omcode="+omcode);
			
			//response.sendRedirect("mypackage_result"); //������ ���꽺Ʈ��  ============================ ����Ȯ��â ������ �� 
		}else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('������ ���������� ó������ �ʾҽ��ϴ�.\\n�� ���Ϳ� �����ϼ���.');");	// ���ڿ��̱� �빮�� �齽����(\) �� ġ�� ���ڿ� \n �� ���
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
