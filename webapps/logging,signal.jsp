<%@include file="include/top.jsp"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// Create data access object.
SignalDao dao = new SignalDao();

// Set filtering option.
dao.limit = 100;
dao.page = param_int("page", 1);
dao.stime = param_str("stime");
dao.etime = param_str("etime");

dao.user = param_str("user");
dao.clt_ip = param_str("clt_ip");
dao.signal_ping = param_bool("signal_ping");
dao.signal_start = param_bool("signal_start");

dao.signal_stop = param_bool("signal_stop");
dao.signal_switch = param_bool("signal_switch");
dao.signal_ipupdate = param_bool("signal_ipupdate");

// Global.
int g_count = dao.select_count();
int g_page = dao.page;
int g_limit = dao.limit;
String g_time_option = param_str("time_option", "2h");
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function go_page(page){
	var form = document.go_form;
	form.page.value = page;
	form.submit();
}

//-----------------------------------------------
function set_userdef(form){
	form.time_option[0].checked = true;
}

//-----------------------------------------------
function set_period(form){
	var opt = radio_get_value(form.time_option);

	var stime = '<%= strftime_add("yyyy/MM/dd HH:mm", -3600 * 2)%>';
	var etime = '<%= strftime("yyyy/MM/dd HH:mm")%>';

	if(opt == '24h'){
		stime = '<%= strftime_add("yyyy/MM/dd HH:mm", -3600 * 24)%>';
	}

	if(opt == '48h'){
		stime = '<%= strftime_add("yyyy/MM/dd HH:mm", -3600 * 48)%>';
	}

	form.stime.value = stime;
	form.etime.value = etime;
	form.stime.disabled = false;
	form.etime.disabled = false;
}

//-----------------------------------------------
function set_period2(form){
	if(!radio_is_checked(form.time_option) || form.time_option[0].checked){
		return;
	}
	set_period(form);
}

//-----------------------------------------------
function clear_search_form(){
	document.search_form.user.value = "";
	document.search_form.clt_ip.value = "";
}

//-----------------------------------------------
function search_by_user(user){
	clear_search_form();
	document.search_form.user.value = user;
	document.search_form.submit();
}

//-----------------------------------------------
function search_by_clt_ip(clt_ip){
	clear_search_form();
	document.search_form.clt_ip.value = clt_ip;
	document.search_form.submit();
}
</script>

<!-- view -->
<form name="search_form" action="<%= get_page_name()%>" method="get">
<div class="title">Signal</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="100" align="right">Time :</td>
		<td colspan="7">
			<input id="stime" type="text" name="stime" value="<%= dao.get_stime()%>" size="12" onchange="javascript:set_userdef(this.form)">
				~ <input id="etime" type="text" name="etime" value="<%= dao.get_etime()%>" size="12" onchange="javascript:set_userdef(this.form)">

			<div style="display: none;">
				<input type="radio" class="no_border" name="time_option" value="userdef" onclick="javascript:set_period(this.form)"
					<%if(g_time_option.equals("userdef")){out.print("checked");}%>> User defined
			</div>

			<input type="radio" class="no_border" name="time_option" value="2h" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("2h")){out.print("checked");}%>> Last 2 hours
			<input type="radio" class="no_border" name="time_option" value="24h" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("24h")){out.print("checked");}%>> Last 24 hours
			<input type="radio" class="no_border" name="time_option" value="48h" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("48h")){out.print("checked");}%>> Last 48 hours
		</td>
	</tr>

	<tr>
		<td width="100" align="right">User :</td>
		<td width="100"><input type="text" name="user" value="<%= dao.user%>" size="25"></td>

		<td width="100" align="right">Client IP :</td>
		<td width="100"><input type="text" name="clt_ip" value="<%= dao.clt_ip%>" size="25"></td>
		
		<td width="100" align="right"></td>
		<td width="100"></td>

		<td width="60"></td>
		<td ></td>
	</tr>

	<tr>
		<td width="100" align="right">Signal :</td>
		<td width="100" colspan="6">
<!-- 
			<input type="checkbox" class="no_border"
				onclick="javascript:checkbox_toggle_all2(this, "signal_arr")" checked>toggle-all<br>
-->
			<input type="checkbox" class="no_border" name="signal_ping"	<%if(dao.signal_ping){out.print("checked");}%>>PING
			<input type="checkbox" class="no_border" name="signal_start" <%if(dao.signal_start){out.print("checked");}%>>START
			<input type="checkbox" class="no_border" name="signal_stop" <%if(dao.signal_stop){out.print("checked");}%>>STOP
			<input type="checkbox" class="no_border" name="signal_ipupdate" <%if(dao.signal_ipupdate){out.print("checked");}%>>IPUPDATE
		</td>

		<td width="60"></td>
		<td ></td>
	</tr>

	<tr height="30">
		<td></td>
		<td></td>
		<td></td>
		<td colspan="5">
<input type="button" value="SUBMIT" onclick="javascript:set_period2(this.form);this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
<input type="button" value="CLEAR" onclick="javascript:clear_search_form();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<p>

<!-- list -->
<div class="list">
<table width="100%">
	<tr>
		<td>
			Count : <%= g_count%> / Page : <%= dao.page%>
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="4"></td></tr>
	<tr class="head">
		<td width="100">Time</td>
		<td width="150">User</td>
		<td width="150">Client IP</td>
		<td width="">Signal</td>
	</tr>
	<tr class="line"><td colspan="4"></td></tr>

<%
List<SignalData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='4' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	SignalData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='4'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.get_ctime()%></td>
		<td><a href="javascript:search_by_user('<%= data.user%>')"><%= data.user%></a></td>
		<td><a href="javascript:search_by_clt_ip('<%= data.clt_ip%>')"><%= data.clt_ip%></a></td>
		<td><%= data.signal%></td>
	</tr>
<%}%>

	<tr class="line"><td colspan="4"></td></tr>
</table>

<table border="0" width="100%">
	<tr>
		<td align="center"><%= get_pagination(g_count, g_limit, g_page)%></td>
	</tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="page" value="<%= g_page%>">
<input type="hidden" name="limit" value="<%= g_limit%>">
<input type="hidden" name="time_option" value="<%= g_time_option%>">
<input type="hidden" name="stime" value="<%= dao.stime%>">
<input type="hidden" name="etime" value="<%= dao.etime%>">
<input type="hidden" name="user" value="<%= dao.user%>">
<input type="hidden" name="clt_ip" value="<%= dao.clt_ip%>">
<input type="hidden" name="signal_ping" value="<%= dao.signal_ping%>">
<input type="hidden" name="signal_start" value="<%= dao.signal_start%>">
<input type="hidden" name="signal_stop" value="<%= dao.signal_stop%>">
<input type="hidden" name="signal_ipupdate" value="<%= dao.signal_ipupdate%>">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>

<!-- Datetime picker -->
<script type="text/javascript">
//-----------------------------------------------
var dateToDisable = new Date();

//-----------------------------------------------
jQuery("#stime").datetimepicker({
	format: "Y/m/d H:i",
	step: 1,
	beforeShowDay: function(date) {
		if (date.getMonth() > dateToDisable.getMonth()) {
			return [false, ""]
		}

		return [true, ""];
	}
});

//-----------------------------------------------
jQuery("#etime").datetimepicker({
	format: "Y/m/d H:i",
	step: 1,
	beforeShowDay: function(date) {
		if (date.getMonth() > dateToDisable.getMonth()) {
			return [false, ""]
		}

		return [true, ""];
	}
});
</script>
