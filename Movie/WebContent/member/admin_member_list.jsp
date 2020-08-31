<%@page import="vo.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td{
	border : 1px solid black;
}</style>
<%
ArrayList<MemberBean> memberList = (ArrayList<MemberBean>)request.getAttribute("memberList");
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
<% for(MemberBean mb : memberList) {%>
	<table>
	  <tr><td>idx</td> <td>email</td>  <td>pass</td>  <td>nick</td>  <td>phone</td>  <td>date</td> </tr>
	    <tr>
	      <td><%= mb.getIdx() %></td>  
	      <td><%= mb.getEmail() %></td> 
	      <td><%= mb.getPass() %></td> 
	      <td><%= mb.getNick() %></td>
	      <td><%= mb.getPhone() %></td>  
	      <td><%= mb.getDate() %></td>
	    </tr>
	</table>
<%} %>
</body>
</html>