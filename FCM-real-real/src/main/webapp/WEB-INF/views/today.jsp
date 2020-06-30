<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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

<jsp:useBean id = "bin" scope="page" class = "com.fcm.win.heejin1"/>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6d2186a37aa74710ede6229870333091"></script>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

Calendar cal = new GregorianCalendar();
Date date = new Date(cal.getTimeInMillis());

Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
	
	pstmt = conn.prepareStatement("select * from A_amount,B_amount,C_amount,D_amount,E_amount Where (A_amount.date=?) AND (A_amount.date=B_amount.date and A_amount.date=C_amount.date and A_amount.date=D_amount.date and A_amount.date = E_amount.date)");
	pstmt.setDate(1,date);

	rs = pstmt.executeQuery();

	while (rs.next()) {
		int a,b,c,d,e;
		a=rs.getInt("A_amount.remain");
		b=rs.getInt("B_amount.remain");
		c=rs.getInt("C_amount.remain");
		d=rs.getInt("D_amount.remain");
		e=rs.getInt("E_amount.remain");
		
		map = new HashMap<Object,Object>(); map.put("label", "필동"); map.put("y", a); list.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "장충동"); map.put("y", b); list.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "신당동"); map.put("y", c); list.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "을지로"); map.put("y", d); list.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "청구동"); map.put("y", e); list.add(map);
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
 
String dataPoints = gsonObj.toJson(list);
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>FCM</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/today.css?ver=1">
     <style type="text/css">
      @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);      .customoverlay {position:relative;bottom:40px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
      .customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
      .customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #87CE00 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 6px center;}
      .customoverlay .title {display:block;text-align:center;background:#fff;margin-right:20px;padding:5px 9px;font-size:12px;font-weight:bold;font-family: 'Nanum Gothic', sans-serif;}
      .customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    </style>
    
   
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
  
  <div id = "iiii">
  		
  <div id= "heejins" >
 		
      <div id="map" style="width:95%; height: 80%;">
              <%--TSP와 연동하여 찾아가야 할 node의 순서를 받아옴 --%>
   <%

	try {
		String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
		String dbUser = "FCM_RDS";
		String dbPwd = "wjdxhd0603~!";

		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

		pstmt = conn.prepareStatement("select * from A_amount,B_amount,C_amount,D_amount,E_amount Where (A_amount.date=?) AND (A_amount.date=B_amount.date and A_amount.date=C_amount.date and A_amount.date=D_amount.date and A_amount.date = E_amount.date);");
		pstmt.setDate(1,date);

		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			int a,b,c,d,e;
	
			a=rs.getInt("A_amount.remain");
			b=rs.getInt("B_amount.remain");
			c=rs.getInt("C_amount.remain");
			d=rs.getInt("D_amount.remain");
			e=rs.getInt("E_amount.remain");
			
			
			bin.receive(a,b,c,d,e);%>
			
			 
   			
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
	
	<%
	  
     
	  bin.reset_0();
      bin.cal_importance();
      int today[] = bin.on_off();
      bin.reset();
      bin.input_num();
      bin.reset2();
      bin.action();
      int way[] =bin.heejin(); 
      int num = bin.ret_num();
      
      int way1 = bin.heejin1();
      int way2 = bin.heejin2();
      int way3 = bin.heejin3();
      int way4 = bin.heejin4();
      int way5 = bin.heejin5();
      int lowcost = bin.cost_print(); 
      int test[] = bin.test1(); 
            
      out.println(way1);
      out.println(way2);
      out.println(way3);
      out.println(way4);
      out.println(way5);
   
   %>
      </div>

      
	</div>
	
	<div id= "graph" >
		<h2>오늘의 수거 일정</h2>	
		<div id="chartContainer" style="width: 90%; height: 30%; margin: auto;"></div>
		<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
		
		<div class = "ment" >
			<h3> 오늘 방문할 수거함의 순서는 다음과 같습니다:  </h3><br>
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
			<br> 오늘 운행할 거리는 <b>총
			<% double total_cost = lowcost / 1000.0; %>
			<%out.println(total_cost); %>km</b>입니다. <br>
			
		
	
    <button onclick="location.href='  https://map.naver.com/v5/directions/14136070.52500112,4517590.198756363,Home/14136070.52500112,4517590.198756363,Home/'+ waypoints1 + waypoints2 + waypoints3 + waypoints4 + waypoints5;">수거시작</button>
    </div>
    </div>
   </div>
   
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
    		backgroundColor: "#eae7d5",
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
    <script>

    //지도 표시
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.563, 127.00638), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커를 표시할 위치와 title 객체 배열
    var positions = [
        {
            title: '충무로역',
            latlng: new kakao.maps.LatLng(37.561008,126.995335)
        },
        {
            title: '동대입구역',
            latlng: new kakao.maps.LatLng(37.559157,127.005005)
        },
        {
            title: '신당동주민센터',
            latlng: new kakao.maps.LatLng(37.562110,127.014553)
        },
        {
            title: '현대시티아울렛',
            latlng: new kakao.maps.LatLng(37.568818,127.007634)
        },
        {
            title: '청구어린이공원',
            latlng: new kakao.maps.LatLng(37.555420, 127.013107)
        }
    ];

    // 마커 이미지의 이미지 주소
    var imageSrc = "https://www.pinclipart.com/picdir/big/30-303539_recycle-bin-icon-icons-png-green-recycle-bin.png";

    for (var i = 0; i < positions.length; i ++) {

        // 마커 이미지의 이미지 크기
        var imageSize = new kakao.maps.Size(31, 31);

        // 마커 이미지를 생성
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

        // 마커를 생성
        var marker = new kakao.maps.Marker({
            map: map, // 마커를 표시할 지도
            position: positions[i].latlng, // 마커를 표시할 위치
            title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
            image : markerImage // 마커 이미지
        });
    }
    
    
    var content = ['<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">필동 수거함</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">장충동 수거함</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">신당동 수거함</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">을지로 수거함</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">청구동 수거함</span>' +
        '  </a>' +
        '</div>'];

    for(var t=0; t<5; t++){

    var customOverlay = new kakao.maps.CustomOverlay({
        map: map,
        position: positions[t].latlng,
        content: content[t],
        yAnchor: 1 
       });       
    }
    
    
    
    //node에 따라 위도, 경도 지정하는 함수
    function rachange(param){
       if(param==1)
         return "14136928.330733273,4517631.948647877,Pil-dong";
       else if(param==2)
          return "14138142.013745543,4517321.981092075,Jangchung-dong";
       else if(param==3)
          return "14138634.7532659,4517643.3507960,Sindang-dong";
       else if(param==4)
          return "14138197.8401327,4518698.3476259,Euljiro";
       else if(param==5)
          return "14139053.8660030,4516856.8689114,Cheonggu-dong";
       else
          return "";
    }

    
   var qmark = ":";

   var firstway = <%=way1%>;
   var secondway = <%=way2%>;
   var thirdway = <%=way3%>;
   var fourthway = <%=way4%>;
   var fifthway = <%=way5%>;

   var points1 = rachange(firstway);
   var points2 = rachange(secondway);
   var points3 = rachange(thirdway);
   var points4 = rachange(fourthway);
   var points5 = rachange(fifthway);

   var myline = [firstway, secondway, thirdway, fourthway, fifthway];
   

   //경유지 수에 따라 url에 입력할 파라미터 문법 변경
   if(points2!="")
         var waypoints1 = points1.concat(qmark);
       else {
         var waypoints1 = points1;
       }
   if(points3!="")
         var waypoints2 = points2.concat(qmark);
       else {
         var waypoints2 = points2;
       }
    if(points4!="")
      var waypoints3 = points3.concat(qmark);
    else {
      var waypoints3 = points3;
    }
    if(points5!="")
        var waypoints4 = points4.concat(qmark);
      else {
        var waypoints4 = points4;
      }
    var waypoints5 = points5;
    
    var car = "/car?";

    
    // 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
    

    
    var linePath = [
        new kakao.maps.LatLng(37.561008,126.995335), //대한극장
        new kakao.maps.LatLng(37.559157,127.005005), //동대입구
        new kakao.maps.LatLng(37.562110,127.014553), //신당동주민센터
        new kakao.maps.LatLng(37.568818,127.007634), //현대시티아울렛
        new kakao.maps.LatLng(37.555420, 127.013107) //청구어린이공원
    ];
    
    var content = [
       
    ];
    
    var mylinePath = [];

    for(var j=0; j<5; j++){
       if(myline[j]==1)
          mylinePath[j] = linePath[0];
       else if(myline[j]==2)
          mylinePath[j] = linePath[1];
       else if(myline[j]==3)
          mylinePath[j] = linePath[2];
       else if(myline[j]==4)
          mylinePath[j] = linePath[3];
       else if(myline[j]==5)
          mylinePath[j] = linePath[4];
    }
    
    
    // 지도에 표시할 선을 생성합니다
    var polyline = new kakao.maps.Polyline({
        path: mylinePath, // 선을 구성하는 좌표배열 입니다
        strokeWeight: 5, // 선의 두께 입니다
        strokeColor: '#75BC00', // 선의 색깔입니다
        strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
        strokeStyle: 'solid' // 선의 스타일입니다
    });

    // 지도에 선을 표시합니다
    polyline.setMap(map);
   </script>
  </body>
</html>
