<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/home.css">

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

    <div id= "back">
      <div class = "ment">
        <h2> SUPPROT FOR THE ENVIRONMENT </h2>
        <p> 스마트시티 조성을 위한 쓰레기통 관리 프로젝트 </p>
      </div>

      <div class = "page">
        <img src="<%= request.getContextPath() %>/resources/img/back02_heejin.png" alt="jangheejin">
      </div>

    </div>

    <div class = "today">
      <button onclick = "location='today'"> 오늘의 수거 일정 바로가기 </button>
    </div>

  </body>
</html>
