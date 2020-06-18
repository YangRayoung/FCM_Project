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

<jsp:useBean id = "bin" scope="page" class = "com.win.fcm.heejin1"/>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6d2186a37aa74710ede6229870333091"></script>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>오늘의 수거</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/today.css">

  </head>
 
  <body>
    <div id = "menu">
      <div class = "logo">
        <img src="<%= request.getContextPath() %>/resources/img/fcm_logo_heejin.png" onclick = "location='/fcm/'"  alt="fcm" >
      </div>

      <div class = "menu1">
        <button onclick = "location='intro'"  > INTRODUCTION</button> <!---- 소개 메뉴 ---->

        <button onclick = "location='today'"  >MANAGEMENT</button> <!-- 지금 메뉴를 가리킴 --->

        <button onclick = "location='day'">STATISTICS</button> <!-- 통계메뉴 (수빈이 담당) --->

        <button onclick = "location='chart'">PREDICTION</button> <!-- 딥러닝??? --->

      </div>
    </div>

      <div id="map" style="width:800px; height:350px;">
              <%--TSP와 연동하여 찾아가야 할 node의 순서를 받아옴 --%>
   <%
   Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Calendar cal = new GregorianCalendar();
	Date date = new Date(cal.getTimeInMillis());

	try {
		String jdbcDriver = "jdbc:mysql://210.94.185.24:3306/FCM";
		String dbUser = "capston";
		String dbPwd = "capston1234";

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
			
			bin.receive(a,b,c,d,e);
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
	
   	  
	  int way1, way2, way3, way4, way5 = 0; 
     
	  bin.reset_0();
      bin.reset_1();
      bin.cal_importance();
      bin.on_off();
      bin.reset();
      bin.input_num();
      bin.reset2();
      bin.action();
      bin.heejin(); 
      
      way1 = bin.heejin1();
      way2 = bin.heejin2();
      way3 = bin.heejin3();
      way4 = bin.heejin4();
      way5 = bin.heejin5();
            
      /*out.println(way1);
      out.println(way2);
      out.println(way3);
      out.println(way4);
      out.println(way5);*/
   
   %>
      </div>

      <div class = "sta">
      	<h1> 오늘의 수거량  </h1><br>
      
      <%

				try {
					String jdbcDriver = "jdbc:mysql://210.94.185.24:3306/FCM";
					String dbUser = "capston";
					String dbPwd = "capston1234";

					conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

					pstmt = conn.prepareStatement("select * from A_amount,B_amount,C_amount,D_amount,E_amount Where (A_amount.date=?) AND (A_amount.date=B_amount.date and A_amount.date=C_amount.date and A_amount.date=D_amount.date and A_amount.date = E_amount.date)");
					pstmt.setDate(1,date);

					rs = pstmt.executeQuery();

					while (rs.next()) {
				
						if(rs.getInt("A_amount.remain")>=50){%>
							<p>필동 수거함 : <%=rs.getInt("A_amount.remain")%>%</p><br>
					<%}
						if(rs.getInt("B_amount.remain")>=50){%>
							<p>장충동 수거함 : <%=rs.getInt("B_amount.remain")%>%</p><br>
					<%}
						if(rs.getInt("C_amount.remain")>=50){%>
							<p>신당동 수거함 : <%=rs.getInt("C_amount.remain")%>%</p><br>
					<%}
						if(rs.getInt("D_amount.remain")>=50){%>
							<p>을지로 수거함 : <%=rs.getInt("D_amount.remain")%>%</p><br>
					<%}
						if(rs.getInt("E_amount.remain")>=50){%>
							<p>청구동 수거함 : <%=rs.getInt("E_amount.remain")%>%</p><br>
					<%}
				
					%>
				<br>
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
      </div>

    <div id="wrap" class="section">
    <button class="btn" onclick="location.href='  https://map.naver.com/v5/directions/14136070.52500112,4517590.198756363,Home/14136070.52500112,4517590.198756363,Home/'+ waypoints1 + waypoints2 + waypoints3 + waypoints4 + waypoints5;">>수거시작</button>
    </div>
   
    <script>

    //지도 표시
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.5624966,126.9956336), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커를 표시할 위치와 title 객체 배열
    var positions = [
        {
            title: '충무로역',
            latlng: new kakao.maps.LatLng(37.5609697,126.9913374)
        },
        {
            title: '을지로4가역',
            latlng: new kakao.maps.LatLng(37.5670145,126.9956365)
        },
        {
            title: '동국대학교',
            latlng: new kakao.maps.LatLng(37.5601098,126.9988097)
        },
        {
            title: '인제대학병원',
            latlng: new kakao.maps.LatLng(37.5649096,126.9865585)
        },
        {
            title: '장충초등학교',
            latlng: new kakao.maps.LatLng(37.559504,127.0089383)
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
        '    <span class="title">A</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">B</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">C</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">D</span>' +
        '  </a>' +
        '</div>', '<div class="customoverlay">' +
        '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
        '    <span class="title">E</span>' +
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
         return "14136928.330733273,4517631.948647877,wastebin_A";
       else if(param==2)
          return "14136287.898570787,4518402.940263405,wastebin_B";
       else if(param==3)
          return "14137168.112916443,4518594.938651372,wastebin_C";
       else if(param==4)
          return "14138355.279626008,4517847.286926374,wastebin_D";
       else if(param==5)
          return "14137833.057630796,4517492.572347818,wastebin_E";
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

    
    // 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
    

    
    var linePath = [
        new kakao.maps.LatLng(37.5609697,126.9913374),
        new kakao.maps.LatLng(37.5649096,126.9865585),
        new kakao.maps.LatLng(37.5670145,126.9956365),
        new kakao.maps.LatLng(37.559504,127.0089383),
        new kakao.maps.LatLng(37.5601098,126.9988097)
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
