<%@include file="include/top.jsp"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// Create data access object for chart.
H2ReportDao report_dao = new H2ReportDao();
ReportStatsData stats = report_dao.get_stats();
ReportChartData request_trend = report_dao.get_request_trend();
ReportChartData domain_top = report_dao.get_domain_top(5);
ReportChartData category_top = report_dao.get_category_top(5);

// Create data access object for blocked list.
RequestDao request_dao = new RequestDao();
request_dao.page = 1;
request_dao.limit = 10;
request_dao.stime = strftime_add("yyyyMMddHHmm", 60 * 60 * -12);  // 12 hours ago.
request_dao.etime = strftime("yyyyMMddHHmm");
request_dao.block_flag = true;

// Version check.
chk_new_version();
%>
<%@include file="include/action_info.jsp"%>

<!-- Google chart -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
google.load("visualization", "1", {packages:["corechart"]});

// Draw request trend chart.
google.setOnLoadCallback(draw_request_trend);
function draw_request_trend() {
	var data = google.visualization.arrayToDataTable([
		["Time", "Request"]
<%
List<String[]> arr_list = request_trend.get_data_list();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Request trend",
		legend: {position: "none"}
	};

	var chart = new google.visualization.LineChart(document.getElementById("chart_request_trend"));
	chart.draw(data, options);
}

// Draw block trend chart.
google.setOnLoadCallback(draw_block_trend);
function draw_block_trend() {
	var data = google.visualization.arrayToDataTable([
		["Time", "Block"]
<%
arr_list = request_trend.get_data_list_blocked();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Block trend",
		legend: {position: "none"}
	};

	var chart = new google.visualization.LineChart(document.getElementById("chart_block_trend"));
	chart.draw(data, options);
}

// Draw domain top chart.
google.setOnLoadCallback(draw_domain_top);
function draw_domain_top() {
	var data = google.visualization.arrayToDataTable([
		["Domain", "Request"]
<%
arr_list = domain_top.get_data_list();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 domain by request",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_domain_top"));
	chart.draw(data, options);
}

// Draw domain block chart.
google.setOnLoadCallback(draw_domain_block);
function draw_domain_block() {
	var data = google.visualization.arrayToDataTable([
		["Domain", "Block"]
<%
arr_list = domain_top.get_data_list_blocked();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 domain by block",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_domain_block"));
	chart.draw(data, options);
}

// Draw category top chart.
google.setOnLoadCallback(draw_category_top);
function draw_category_top() {
	var data = google.visualization.arrayToDataTable([
		["Category", "Request"]
<%
arr_list = category_top.get_data_list();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 category by request",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_category_top"));
	chart.draw(data, options);
}

// Draw category block chart.
google.setOnLoadCallback(draw_category_block);
function draw_category_block() {
	var data = google.visualization.arrayToDataTable([
		["Category", "Block"]
<%
arr_list = category_top.get_data_list_blocked();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 category by block",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_category_block"));
	chart.draw(data, options);
}
</script>
<!-- /Google chart -->

<div class="title">
<%= report_dao.get_stime()%> ~ <%= report_dao.get_etime()%>
</div>
<div class="stats">
request-sum = <%= stats.req_sum%>
, request-cnt = <%= stats.req_cnt%>
, block-sum = <%= stats.block_sum%>
, block-cnt = <%= stats.block_cnt%>
, domain = <%= stats.domain_cnt%>
, user = <%= stats.user_cnt%>
, client-ip = <%= stats.clt_ip_cnt%>
</div>

<table width="1300" cellpadding="0" cellspacing="0">
<tr class="line"><td colspan="2"></td></tr>

<tr>
	<td width="650">
    <div id="chart_request_trend" style="width: 650px; height: 300px;"></div>
	</td>
	<td width="650">
    <div id="chart_block_trend" style="width: 650px; height: 300px;"></div>
	</td>
</tr>
<tr class="line"><td colspan="2"></td></tr>

<tr>
	<td>
    <div id="chart_domain_top" style="width: 650px; height: 300px;"></div>
	</td>
	<td>
    <div id="chart_domain_block" style="width: 650px; height: 300px;"></div>
	</td>
</tr>
<tr class="line"><td colspan="2"></td></tr>

<tr>
	<td>
    <div id="chart_category_top" style="width: 650px; height: 300px;"></div>
	</td>
	<td>
    <div id="chart_category_block" style="width: 650px; height: 300px;"></div>
	</td>
</tr>
</table>

<!-- Recently Blocked Request -->
<p>

<div class="list">
<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="11"></td></tr>
	<tr class="head">
		<td width="90">Time</td>
		<td width="50">Block</td>
		<td width="50" align="center">Count</td>
		<td width="60" align="center">Type</td>
		<td width="250">Domain</td>
		<td width="120">User</td>
		<td width="120">Client IP</td>
		<td width="120">Group</td>
		<td width="120">Policy</td>
		<td width="180">Category</td>
		<td width="">Reason</td>
	</tr>
	<tr class="line"><td colspan="11"></td></tr>

<%
List<RequestData> data_list = request_dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='11' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	RequestData data = data_list.get(i);

	String category_line = data.category;
	if(category_line.length() > 30){
		category_line = safe_substring(data.category, 30) + "..";
	}

	if(i > 0){
		out.println("<tr class='line2'><td colspan='11'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.get_ctime()%></td>
		<td align="center"><%= data.get_block_yn()%></td>
		<td align="right"><%= data.cnt%>&nbsp;&nbsp;</td>
		<td align="center"><%= data.get_type_code()%></td>
		<td><%= data.domain%></td>
		<td><%= data.user%></td>
		<td><%= data.clt_ip%></td>
		<td title="<%= data.grp%>"><%= data.get_first_grp()%></td>
		<td><%= data.policy%></td>
		<td title="<%= data.category%>"><%= category_line%></td>
		<td><%= data.get_reason()%></td>
	</tr>
<%}%>

	<tr class="line"><td colspan="11"></td></tr>
</table>
</div>

<%@include file="include/bottom.jsp"%>
