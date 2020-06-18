<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/intro.css">

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

    <div id = "intro">
      <div class = "no1">
        <img src="<%= request.getContextPath() %>/resources/img/trash_h.png" alt= "trash">
        <h2> 쓰레기량 측정 </h2>
        <p> 초음파센서를 이용하여 쓰레기통이 <br> 얼마나 채워졌는지 원격으로 확인할 수 있습니다. </p>
      </div>


      <div class = "no2">
        <img src="<%= request.getContextPath() %>/resources/img/truck_color.png" alt = "truck">
        <h2> 수거 관리 </h2>
        <p> 비워야 하는 쓰레기통이 몇군데인지 확인하고 <br> 가장 짧은 경로인 방문순서를 찾아줍니다. </p>
      </div>

      <div class = "no3">
        <img src="<%= request.getContextPath() %>/resources/img/graph_h_color.png" alt = "graph">
        <h2> 통계 및 분석 </h2>
        <p> 쓰레기통의 수거 주기를 파악하고 <br> 일별 쓰레기양을 조회할 수 있습니다. </p>
      </div>
    </div>


  </body>

</html>
