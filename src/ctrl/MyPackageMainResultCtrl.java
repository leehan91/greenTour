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
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
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
		 
		    try{// String Type을 Date Type으로 캐스팅하면서 생기는 예외로 인해 여기서 예외처리 해주지 않으면 컴파일러에서 에러가 발생해서 컴파일을 할 수 없다.
		        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		        // date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
		        Date FirstDate = format.parse(sdate);
		        Date SecondDate = format.parse(edate);
		        
		        // Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
		        // 연산결과 -950400000. long type 으로 return 된다.
		        long calDate = FirstDate.getTime() - SecondDate.getTime(); 
		        
		        // Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다. 
		        // 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
		        long calDateDays = calDate / ( 24*60*60*1000); 
		 
		        calDateDays = Math.abs(calDateDays);
		        String result = String.valueOf(calDateDays);
		        period = result;
		        
		        //System.out.println("두 날짜의 날짜 차이: "+ calDateDays);
		        }catch(ParseException e){
		            e.printStackTrace();// 예외 처리
		        }
		    
	    String calperiod = period+"박 "+(Integer.parseInt(period)+1)+"일";
		// calperiod : 몇박 몇일 
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
		
		// int - > String 로바꿈 
		String result = myPackageMainResultSvc.myPackageInsert(mypackagemy, memberinfo, payment);
		// 귀찮아서 memberinfo 만들어서 감 , mypackagemy - 마이패키지 테이블 , payment 결제방식
		
		
//		OrderMpInfo orderMpInfo = myPackageMainResultSvc.getOmInfo(mmcode); // 이거 따로 빼기 
		
		
		String[] arr = result.split("/");
		int chk = Integer.parseInt(arr[0]);
		String omcode = arr[1];
		
		
		// result 짤라서 앞에꺼가 2 값일 때 로 처리 (chk/omcode)로 리턴됨 
		
		if(chk == 2) {//잘 처리 됐을때 
//			request.setAttribute("orderMpInfo", orderMpInfo);
			
			response.sendRedirect("mypackage_end?omcode="+omcode);
			
			//response.sendRedirect("mypackage_result"); //마무리 서브스트링  ============================ 결제확인창 만들어야 돼 
		}else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('결제가 정상적으로 처리되지 않았습니다.\\n고객 센터에 문의하세요.');");	// 문자열이기 대문에 백슬레시(\) 를 치고 난뒤에 \n 을 사용
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
