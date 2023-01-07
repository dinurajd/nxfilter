<%@include file="include/top.jsp"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// If there's a user it becomes user specific report.
String stime = param_str("stime");
String user = param_str("user");

// Create data access object.
D1ReportDao dao = new D1ReportDao(stime, user);
ReportStatsData stats = dao.get_stats();
ReportChartData request_trend = dao.get_request_trend();
ReportChartData domain_top = dao.get_domain_top(5);
ReportChartData category_top = dao.get_category_top(5);
ReportChartData user_top = dao.get_user_top(5);
ReportChartData clt_ip_top = dao.get_clt_ip_top(5);

// Global.
String g_stime = strftime_add("yyyyMMdd", -86400);
String g_time_option = param_str("time_option", "yesterday");
String g_user = param_str("user");
%>

<script type='text/javascript'>
//-----------------------------------------------
function set_userdef(form){
	form.time_option[0].checked = true;
}

//-----------------------------------------------
function set_period(form){
	var opt = radio_get_value(form.time_option);

	var stime = '<%= strftime_add("yyyy/MM/dd", -86400)%>';

	if(opt == '2days'){
		stime = '<%= strftime_add("yyyy/MM/dd", -86400 * 2)%>';
	}

	if(opt == '3days'){
		stime = '<%= strftime_add("yyyy/MM/dd", -86400 * 3)%>';
	}

	form.stime.value = stime;
	form.stime.disabled = false;
}

//-----------------------------------------------
function set_period2(form){
	if(!radio_is_checked(form.time_option) || form.time_option[0].checked){
		return;
	}
	set_period(form);
}
</script>

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

// Draw user top chart.
google.setOnLoadCallback(draw_user_top);
function draw_user_top() {
	var data = google.visualization.arrayToDataTable([
		["User", "Request"]
<%
arr_list = user_top.get_data_list();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 user by request",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_user_top"));
	chart.draw(data, options);
}

// Draw user block chart.
google.setOnLoadCallback(draw_user_block);
function draw_user_block() {
	var data = google.visualization.arrayToDataTable([
		["User", "Block"]
<%
arr_list = user_top.get_data_list_blocked();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 user by block",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_user_block"));
	chart.draw(data, options);
}

// Draw clt_ip top chart.
google.setOnLoadCallback(draw_clt_ip);
function draw_clt_ip() {
	var data = google.visualization.arrayToDataTable([
		["IP", "Request"]
<%
arr_list = clt_ip_top.get_data_list();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 client-ip by request",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_clt_ip_top"));
	chart.draw(data, options);
}

// Draw clt_ip block chart.
google.setOnLoadCallback(draw_clt_ip_block);
function draw_clt_ip_block() {
	var data = google.visualization.arrayToDataTable([
		["IP", "Block"]
<%
arr_list = clt_ip_top.get_data_list_blocked();
for(int i = 0; i < arr_list.size(); i++){
	String[] arr = arr_list.get(i);

	printf(", ['%s', %s]", arr[0], arr[1]);
}
%>
	]);

	var options = {
		title: "Top 5 client-ip by block",
        pieHole: 0.4
	};

	var chart = new google.visualization.PieChart(document.getElementById("chart_clt_ip_block"));
	chart.draw(data, options);
}
</script>
<!-- /Google chart -->

<!-- view -->
<form action="<%= get_page_name()%>" method="get">
<div class="title">Daily Report</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="100" align="right">
	Report from :
		</td>
		<td>
			<input id="stime" type="text" value="<%= dao.get_stime()%>" name="stime" size="8" onchange="javascript:set_userdef(this.form)">

			<div style="display: none;">
				<input type="radio" class="no_border" name="time_option" value="userdef" onclick="javascript:set_period(this.form)"
					<%if(g_time_option.equals("userdef")){out.print("checked");}%>> User defined
			</div>

			<input type="radio" class="no_border" name="time_option" value="yesterday" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("yesterday")){out.print("checked");}%>> Yesterday
			<input type="radio" class="no_border" name="time_option" value="2days" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("2days")){out.print("checked");}%>> 2 days ago
			<input type="radio" class="no_border" name="time_option" value="3days" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("3days")){out.print("checked");}%>> 3 days ago
		</td>
	</tr>

	<tr>
		<td width="100" align="right">
	User :
		</td>
		<td>
			<input type="text" value="<%= g_user%>" name="user" size="25">
			<select onchange="javascript:this.form.user.value=this.value">
			<option value=""> Select a user
<%
List<String> user_list = dao.get_log_user_list();
for(String uname : user_list){
	printf("<option value='%s'>%s", uname, uname);
}
%>
			</select>
		</td>

	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:set_period2(this.form);this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<div class="title">
<%= dao.get_stime()%>
<%
if(!is_empty(g_user)){
	out.print(", " + g_user);
}
%>
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
<tr class="line"><td colspan="2"></td></tr>

<tr>
	<td>
    <div id="chart_user_top" style="width: 650px; height: 300px;"></div>
	</td>
	<td>
    <div id="chart_user_block" style="width: 650px; height: 300px;"></div>
	</td>
</tr>
<tr class="line"><td colspan="2"></td></tr>

<tr>
	<td>
    <div id="chart_clt_ip_top" style="width: 650px; height: 300px;"></div>
	</td>
	<td>
    <div id="chart_clt_ip_block" style="width: 650px; height: 300px;"></div>
	</td>
</tr>
<tr class="line"><td colspan="2"></td></tr>

</table>

<%@include file="include/bottom.jsp"%>

<!-- Datetime picker -->
<script type="text/javascript">
//-----------------------------------------------
var dateToDisable = new Date();

//-----------------------------------------------
jQuery("#stime").datetimepicker({
	timepicker: false,
	format: "Y/m/d",
	beforeShowDay: function(date) {
		if (date.getMonth() > dateToDisable.getMonth()) {
			return [false, ""]
		}

		return [true, ""];
	}
});
</script>
