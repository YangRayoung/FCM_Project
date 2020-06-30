<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<jsp:useBean id="b" scope="page"
   class="com.fcm.win.remainVO" />
   <jsp:useBean id="a" scope="page"
   class="com.fcm.win.RestAPI" />
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<jsp:useBean id = "hj" scope="page" class = "com.fcm.win.heejin2"/>

<html>
<head>
<title>FCM</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/prediction.css?ver=1">
</head>
<body>

	<div id = "menu">
      <div class = "logo">
        <img src="<%= request.getContextPath() %>/resources/img/fcm_logo_heejin.png" onclick = "location='/FCM/'"  alt="fcm" >
      </div>

      <div class = "menu1">
        <button onclick = "location='intro'"  > INTRODUCTION</button> <!---- 소개 메뉴 ---->

        <button onclick = "location='today'"  >MANAGEMENT</button> <!-- 지금 메뉴를 가리킴 --->
	
		<button onclick = "location = 'day'"> SEARCHING </button> <!-- 날짜 조회 -->
		
        <button onclick = "location='chart'"> STATISTICS</button> <!-- 통계메뉴 (수빈이 담당) --->

        <button onclick = "location='prediction'">PREDICTION</button> <!-- 딥러닝??? --->

      </div>
    </div>
    <%
   int a_amount = b.getA();
   int b_amount = b.getB();
   int c_amount = b.getC();
   int d_amount = b.getD();
   int e_amount = b.getE();
   
   //int a_int = Integer.parseInt(a_amount);
   //int b_int = Integer.parseInt(b_amount);
   //int c_int = Integer.parseInt(c_amount);
   //int d_int = Integer.parseInt(d_amount);
   //int e_int = Integer.parseInt(e_amount);
   
   //hj.receive2(a_amount,b_amount,c_amount,d_amount,e_amount);
   //hj.receive1();
   
   hj.receive(a_amount,b_amount,c_amount,d_amount,e_amount);
   
   hj.reset_0();
   hj.cal_importance();
   int today[] = hj.on_off();
   hj.reset();
   hj.input_num();
   hj.reset2();
   hj.action();
   int way[] =hj.heejin(); 
   int num = hj.ret_num();
   
   int way1 = hj.heejin1();
   int way2 = hj.heejin2();
   int way3 = hj.heejin3();
   int way4 = hj.heejin4();
   int way5 = hj.heejin5();
   int lowcost = hj.cost_print(); 
   
   Gson gsonObj = new Gson();
   Map<Object,Object> map = null;
   List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
   
    map = new HashMap<Object,Object>(); map.put("label", "필동"); map.put("y", a_amount); list.add(map);
	map = new HashMap<Object,Object>(); map.put("label", "장충동"); map.put("y", b_amount); list.add(map);
	map = new HashMap<Object,Object>(); map.put("label", "신당동"); map.put("y", c_amount); list.add(map);
	map = new HashMap<Object,Object>(); map.put("label", "을지로"); map.put("y", d_amount); list.add(map);
	map = new HashMap<Object,Object>(); map.put("label", "청구동"); map.put("y", e_amount); list.add(map);
	
	String dataPoints = gsonObj.toJson(list);
      %>
     
   <div id = "h_pre">
   	<div class = "heejin_left">
   	<h2> 내일 수거 예측량 </h2>
   	<div id="chartContainer" style="width: 90%; height:80%; margin: auto;"></div>
		<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	
     </div>
     
     <div class = "heejin_right">
     
    <h4>이에 따른 예상 방문 경로는 다음과 같습니다: </h4> 
    <% 
						for(int i=1; i<num; i++)
						{
							if(way[i]==1){%>
								<%out.println(i);%>  &nbsp; 필동&nbsp; 수거함  <br>
						<%}
							if(way[i]==2){%>
								<%out.println(i);%>  장충동 수거함  <br>
						<%}
							if(way[i]==3){%>
								<%out.println(i);%>  신당동 수거함  <br>
						<%}
							if(way[i]==4){%>
								<%out.println(i);%>  을지로 수거함  <br>
						<%}
							if(way[i]==5){%>
								<%out.println(i);%>  청구동 수거함  <br>
						<%}
					
						}
					
					%>
			<p>예상 운행 거리는 <b>총
			<% double total_cost = lowcost / 1000.0; %>
			<%out.println(total_cost); %>km</b>입니다. <br>
   
	</div>
   </div>
   
   <div id = "heejin_all">
   	<div class = "waste_A">
   		 <img src="<%= request.getContextPath() %>/resources/WasteA.png" width="95%" ><br>
   		 <p>A의 예측량</p>
   	</div>
   <div class = "waste_B">
   		 <img src="<%= request.getContextPath() %>/resources/WasteB.png" width="95%"><br>
   		 <p>B의 예측량</p>
   	</div>
   	<div class = "waste_C">
   		 <img src="<%= request.getContextPath() %>/resources/WasteC.png" width="95%"><br>
   		 <p>C의 예측량</p>
   	</div>
   	<div class = "waste_D">
   		 <img src="<%= request.getContextPath() %>/resources/WasteD.png" width="95%"><br>
   		 <p>D의 예측량</p>
   	</div>
   	<div class = "waste_E">
   		 <img src="<%= request.getContextPath() %>/resources/WasteE.png" width="95%"><br>
   		 <p>E의 예측량</p>
   	</div>
   </div>
  
   
   
</body>
<script type="text/javascript"> //오늘의 수거일정 그래프
    window.onload = function() {
    	
    	CanvasJS.addColorSet("greenShades",
    			
                [
                	<% for(int k=0; k<5; k++)
                	{
                		if(today[k] == 1) //이쓰레기통은 방문한다! 
                		{%>
                			"#ef9b83" <%} 
                		else 
                		{%>
                			"#f3dabb" <%} %> ,
                	<%}%> 
                	             
                ]);
    	 
    	var chart = new CanvasJS.Chart("chartContainer", {
    		theme: "light2",
    		
    		colorSet: "greenShades",
    		backgroundColor: "#EEEDDF",
    		axisY: {
    			//title: "percent %",
    			labelFormatter: addSymbols,
    			gridColor: "#eae7d5"
    		},
    		data: [{
    			type: "bar",
    			indexLabel: "{y}",
    			indexLabelFontColor: "#444",
    			indexLabelPlacement: "outside",
    			dataPoints: <%out.print(dataPoints);%>
    		}]
    	});
    	chart.render();
    	 
    	function addSymbols(e) {
    		var suffixes = ["", "K", "M", "B"];
    	 
    		var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);
    		if(order > suffixes.length - 1)
    		order = suffixes.length - 1;
    	 
    		var suffix = suffixes[order];
    		return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
    	}
    	 
    	}
    </script>
</html>