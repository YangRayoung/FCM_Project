<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
 
<%

Class.forName("com.mysql.jdbc.Driver");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

Calendar cal = new GregorianCalendar();
Date date = new Date(cal.getTimeInMillis());

Calendar week = Calendar.getInstance();
week.add(Calendar.DATE , -6);
String beforeWeek = new java.text.SimpleDateFormat("yyyy-MM-dd").format(week.getTime());

Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list1 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list2 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list3 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list4 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list5 = new ArrayList<Map<Object,Object>>();


List<Map<Object,Object>> list11 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list12 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list13 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list14 = new ArrayList<Map<Object,Object>>();
List<Map<Object,Object>> list15 = new ArrayList<Map<Object,Object>>();

SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");


try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select date, remain from A_amount Where date Between ? and ? Order by date");
	pstmt.setDate(1, Date.valueOf(beforeWeek));
	pstmt.setDate(2, date);
	rs = pstmt.executeQuery();
	

	while (rs.next()) {

	String nowdate1 = transFormat.format(rs.getDate("date"));
	int amount1 = rs.getInt("remain");

	map = new HashMap<Object,Object>(); map.put("label", nowdate1); map.put("y", amount1); list1.add(map);

	}
} catch (

SQLException se) {
	se.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
String dataPoints1 = gsonObj.toJson(list1);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select * from B_amount Where (date Between ? and ?) Order by date");
	pstmt.setDate(1, Date.valueOf(beforeWeek));
	pstmt.setDate(2, date);
	rs = pstmt.executeQuery();

	while (rs.next()) {

String nowdate2 = transFormat.format(rs.getDate("date"));
int amount2 = rs.getInt("remain");

map = new HashMap<Object,Object>(); map.put("label", nowdate2); map.put("y", amount2); list2.add(map);

	}
} catch (

SQLException se) {
	se.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
String dataPoints2 = gsonObj.toJson(list2);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select * from C_amount Where (date Between ? and ?) Order by date");
	pstmt.setDate(1, Date.valueOf(beforeWeek));
	pstmt.setDate(2, date);
	rs = pstmt.executeQuery();

	while (rs.next()) {

String nowdate3 = transFormat.format(rs.getDate("date"));
int amount3 = rs.getInt("remain");

map = new HashMap<Object,Object>(); map.put("label", nowdate3); map.put("y", amount3); list3.add(map);

	}
} catch (

SQLException se) {
	se.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
String dataPoints3 = gsonObj.toJson(list3);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select * from D_amount Where (date Between ? and ?) Order by date");
	pstmt.setDate(1, Date.valueOf(beforeWeek));
	pstmt.setDate(2, date);
	rs = pstmt.executeQuery();

	while (rs.next()) {

String nowdate4 = transFormat.format(rs.getDate("date"));
int amount4 = rs.getInt("remain");

map = new HashMap<Object,Object>(); map.put("label", nowdate4); map.put("y", amount4); list4.add(map);

	}
} catch (

SQLException se) {
	se.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
String dataPoints4 = gsonObj.toJson(list4);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select * from E_amount Where (date Between ? and ?) Order by date");
	pstmt.setDate(1, Date.valueOf(beforeWeek));
	pstmt.setDate(2, date);
	rs = pstmt.executeQuery();

	while (rs.next()) {

String nowdate5 = transFormat.format(rs.getDate("date"));
int amount5 = rs.getInt("remain");

map = new HashMap<Object,Object>(); map.put("label", nowdate5); map.put("y", amount5); list5.add(map);

	}
} catch (

SQLException se) {
	se.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
String dataPoints5 = gsonObj.toJson(list5);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select remain from A_amount Where date=?");
	pstmt.setDate(1, date);
	rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int a1 = rs.getInt("remain");
		int b1 = 100-a1;
		
		map = new HashMap<Object,Object>(); map.put("label", "필동 수거함"); map.put("y", a1); list11.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "남은 양"); map.put("y", b1); list11.add(map);
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
String dataPoints11 = gsonObj.toJson(list11);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select remain from B_amount Where date=?");
	pstmt.setDate(1, date);
	rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int a2 = rs.getInt("remain");
		int b2 = 100-a2;
		
		map = new HashMap<Object,Object>(); map.put("label", "장충동 수거함"); map.put("y", a2); list12.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "남은 양"); map.put("y", b2); list12.add(map);
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
String dataPoints12 = gsonObj.toJson(list12);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select remain from C_amount Where date=?");
	pstmt.setDate(1, date);
	rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int a3 = rs.getInt("remain");
		int b3 = 100-a3;
		
		map = new HashMap<Object,Object>(); map.put("label", "신당동 수거함"); map.put("y", a3); list13.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "남은 양"); map.put("y", b3); list13.add(map);
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
String dataPoints13 = gsonObj.toJson(list13);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select remain from D_amount Where date=?");
	pstmt.setDate(1, date);
	rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int a4 = rs.getInt("remain");
		int b4 = 100-a4;
		
		map = new HashMap<Object,Object>(); map.put("label", "을지로 수거함"); map.put("y", a4); list14.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "남은 양"); map.put("y", b4); list14.add(map);
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
String dataPoints14 = gsonObj.toJson(list14);

try {
	String jdbcDriver = "jdbc:mysql://fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com:3306/FCM";
	String dbUser = "FCM_RDS";
	String dbPwd = "wjdxhd0603~!";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);

	pstmt = conn.prepareStatement("select remain from E_amount Where date=?");
	pstmt.setDate(1, date);
	rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int a5 = rs.getInt("remain");
		int b5 = 100-a5;
		
		map = new HashMap<Object,Object>(); map.put("label", "청구동 수거함"); map.put("y", a5); list15.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "남은 양"); map.put("y", b5); list15.add(map);
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
String dataPoints15 = gsonObj.toJson(list15);

%>
 
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/chart.css?ver=1">
<script type="text/javascript">
window.onload = function() { 
	
	CanvasJS.addColorSet("greenShades",
            [//colorSet Array

            "#ACEC00",
            "#BA65C9",
            "#00BBD6",
            "#EF3C79",
            "#FF9224"                
            ]);
	CanvasJS.addColorSet("greenShades1",
            [//colorSet Array

            "#ACEC00",
            "#EAFABF"               
            ]);
	CanvasJS.addColorSet("greenShades2",
            [//colorSet Array

            "#BA65C9",
            "#EED8F1"               
            ]);
	CanvasJS.addColorSet("greenShades3",
            [//colorSet Array

            "#00BBD6",
            "#BFEEF5"               
            ]);
	CanvasJS.addColorSet("greenShades4",
            [//colorSet Array

            "#EF3C79",
            "#FBCEDD"               
            ]);
	CanvasJS.addColorSet("greenShades5",
            [//colorSet Array

            "#FF9224",
            "#FFD8B0"               
            ]);
	
 
var chart1 = new CanvasJS.Chart("chartContainer1", {
	animationEnabled: true,
	theme: "light2",
	backgroundColor: "#eae7d5",
	colorSet: "greenShades",
	//title: {
	//	text: "최근 일주일간 폐기물 량"
	//},
	axisY: {
		title: "% - percentage",
		gridColor: "#eae7d5"
	},
	toolTip: {
		shared: true
	},
	legend: {
		cursor: "pointer",
		itemclick: toggleDataSeries
	},
	data: [{
		type: "column",
		name: "필동",
		showInLegend: true,
		indexLabelPlacement: "outside",
		dataPoints: <%out.print(dataPoints1);%>
	}, {
		type: "column",
		name: "장충동",
		showInLegend: true,
		dataPoints: <%out.print(dataPoints2);%>
	}, {
		type: "column",
		name: "신당동",
		showInLegend: true,
		dataPoints: <%out.print(dataPoints3);%>
	}, {
		type: "column",
		name: "을지로",
		showInLegend: true,
		dataPoints: <%out.print(dataPoints4);%>
	}, {
		type: "column",
		name: "청구동",
		showInLegend: true,
		dataPoints: <%out.print(dataPoints5);%>
	}]
});
chart1.render();
 
function toggleDataSeries(e) {
	if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	}
	else {
		e.dataSeries.visible = true;
	}
	chart1.render();
}
	 
	var chart11 = new CanvasJS.Chart("chartContainer11", {
		animationEnabled: true,
		theme: "light2",
		backgroundColor: "#EEEDDF",
		colorSet: "greenShades1",
		title: {
			text: "필동 수거함"
		},
		subtitles: [{
			text: "percentage"
		}],
		data: [{
			type: "doughnut",
			yValueFormatString: "#,##0",
			indexLabel: "{label}: {y}%",
			toolTipContent: "{y}%",
			dataPoints : <%out.print(dataPoints11);%>
		}]
	});
	chart11.render();
	
	var chart12 = new CanvasJS.Chart("chartContainer12", {
		animationEnabled: true,
		backgroundColor: "#EEEDDF",
		colorSet: "greenShades2",
		theme: "light2",
		title: {
			text: "장충동 수거함"
		},
		subtitles: [{
			text: "percentage"
		}],
		data: [{
			type: "doughnut",
			yValueFormatString: "#,##0",
			indexLabel: "{label}: {y}%",
			toolTipContent: "{y}%",
			dataPoints : <%out.print(dataPoints12);%>
		}]
	});
	chart12.render();
	
	var chart13 = new CanvasJS.Chart("chartContainer13", {
		animationEnabled: true,
		backgroundColor: "#EEEDDF",
		colorSet: "greenShades3",
		theme: "light2",
		title: {
			text: "신당동 수거함"
		},
		subtitles: [{
			text: "percentage"
		}],
		data: [{
			type: "doughnut",
			yValueFormatString: "#,##0",
			indexLabel: "{label}: {y}%",
			toolTipContent: "{y}%",
			dataPoints : <%out.print(dataPoints13);%>
		}]
	});
	chart13.render();
	
	var chart14 = new CanvasJS.Chart("chartContainer14", {
		animationEnabled: true,
		backgroundColor: "#EEEDDF",
		colorSet: "greenShades4",
		theme: "light2",
		title: {
			text: "을지로 수거함"
		},
		subtitles: [{
			text: "percentage"
		}],
		data: [{
			type: "doughnut",
			yValueFormatString: "#,##0",
			indexLabel: "{label}: {y}%",
			toolTipContent: "{y}%",
			dataPoints : <%out.print(dataPoints14);%>
		}]
	});
	chart14.render();
	
	var chart15 = new CanvasJS.Chart("chartContainer15", {
		animationEnabled: true,
		backgroundColor: "#EEEDDF",
		colorSet: "greenShades5",
		theme: "light2",
		title: {
			text: "청구동 수거함"
		},
		subtitles: [{
			text: "percentage"
		}],
		data: [{
			type: "doughnut",
			yValueFormatString: "#,##0",
			indexLabel: "{label}: {y}%",
			toolTipContent: "{y}%",
			dataPoints : <%out.print(dataPoints15);%>
		}]
	});
	chart15.render();
	
}

</script>
<title>FCM</title>
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
	
	
	<div id = "all-graph">
	<h2>현재 수거함 별 수거량</h2>
	<p>&nbsp;</p>
	<div id="chartContainer11" style="height: 350px; width: 18%;display: inline-block;"></div>
	<div id="chartContainer12" style="height: 350px; width: 18%;display: inline-block;"></div>
	<div id="chartContainer13" style="height: 350px; width: 18%;display: inline-block;"></div>
	<div id="chartContainer14" style="height: 350px; width: 18%;display: inline-block;"></div>
	<div id="chartContainer15" style="height: 350px; width: 18%;display: inline-block;"></div>
	</div>
	
	
	<div id = "graph2">
	<h2>최근 일주일간 폐기물량</h2>
	<div id="chartContainer1" style="height: 370px; width: 100%;"></div>
	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	</div>
</body>
</html> 