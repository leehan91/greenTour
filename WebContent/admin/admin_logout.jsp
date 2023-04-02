<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
session.invalidate();	// 세션을 전부 삭제 
// 경우에 따라 session.removeAttribute("login_info"); 를 사용할수도 있음. 

response.sendRedirect("/greenTour/admin/admin_index.jsp");
%>