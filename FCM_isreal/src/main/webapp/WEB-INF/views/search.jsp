<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>수빈 통계 페이지</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/search.css">
<script>
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#startDate").datepicker({
		dateFormat : "yy-mm-dd",
		dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
		monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
				"8월", "9월", "10월", "11월", "12월" ],
		onSelect : function(startDate) {

			var arr = startDate;

			$("#date1").text(arr);
		}
	});
	
	$("#endDate").datepicker({
		dateFormat : "yy-mm-dd",
		dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
		monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
				"8월", "9월", "10월", "11월", "12월" ],
		onSelect : function(endDate) {

			var arr = endDate;

			$("#date2").text(arr);
		}
	});

});

	function nodate(){
		if(document.getElementById("startDate").value == ""){
			alert("시작 날짜를 지정해 주세요.");
			return false;
		}else
			document.d.submit();
		
		if(document.getElementById("endDate").value == ""){
			alert("종료 날짜를 지정해 주세요.");
			return false;
		}else
			document.d.submit();
	}

</script>

</head>

<body>
	<div id = "menu">
      <div class = "logo">
        <img src="<%= request.getContextPath() %>/resources/img/fcm_logo_heejin.png" onclick = "location='/fcm/'"  alt="fcm" >
      </div>

      <div class = "menu1">
        <button onclick = "location='intro'"  > INTRODUCTION</button> <!---- 소개 메뉴 ---->

        <button onclick = "location='tsp'"  >MANAGEMENT</button> <!-- 지금 메뉴를 가리킴 --->

        <button onclick = "location='day'">STATISTICS</button> <!-- 통계메뉴 (수빈이 담당) --->

        <button onclick = "location='chart'">PREDICTION</button> <!-- 딥러닝??? --->

      </div>
    </div>


	<form name="d" action="search" method="POST">
		<input type="text" name="startDate" id="startDate"/> ~ <input type="text"
			name="endDate" id="endDate"/> <input type="button" value="조회" onclick = "nodate()">
	</form>
		<%
			request.setCharacterEncoding("euc-kr");
			
			String date1 = request.getParameter("startDate");
			String date2 = request.getParameter("endDate");
			
			java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd",java.util.Locale.KOREA);
			java.util.Date d=formatter.parse(date1);
			java.util.Date d2=formatter.parse(date2);
		%>


		<!--표 설정-->		
		<table id="a_table" class='scrolltbody'>
			<thead>
				<tr>
					<th>날짜</th>
					<th>필동</th>
					<th>장충동</th>
					<th>신당동</th>
					<th>을지로</th>
					<th>인현동</th>
				</tr>
			</thead>
			<tbody>
				<%
					Class.forName("com.mysql.jdbc.Driver");
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {
					String jdbcDriver = "jdbc:mysql://210.94.185.24:3306/FCM";
					String dbUser = "capston";
					String dbPwd = "capston1234";

					conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

					pstmt = conn.prepareStatement("select * from A_amount,B_amount,C_amount,D_amount,E_amount Where (A_amount.date Between ? and ?) AND (A_amount.date=B_amount.date and A_amount.date=C_amount.date and A_amount.date=D_amount.date and A_amount.date = E_amount.date) ORDER BY A_amount.date");
					pstmt.setDate(1,Date.valueOf(date1));
					pstmt.setDate(2,Date.valueOf(date2));

					rs = pstmt.executeQuery();

					while (rs.next()) {
				%>
				<tr>

					<td><%=rs.getDate("A_amount.date")%></td>
					<td><%=rs.getInt("A_amount.remain")%></td>
					<td><%=rs.getInt("B_amount.remain")%></td>
					<td><%=rs.getInt("C_amount.remain")%></td>
					<td><%=rs.getInt("D_amount.remain")%></td>
					<td><%=rs.getInt("E_amount.remain")%></td>

				</tr>
				<%
					}
				} catch (SQLException se) {
					se.printStackTrace();
				} finally {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				}
				%>
			</tbody>
		</table>
	<!-- https://hyounjp.tistory.com/10 -->
</body>

</html>