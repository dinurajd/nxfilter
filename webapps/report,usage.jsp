<%@include file="include/top.jsp"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// Global.
String g_user = param_str("user");
String g_etime = strftime_add("yyyy/MM/dd", 86400 * -1);
String g_stime = strftime_add("yyyy/MM/dd", 86400 * -30);
%>

<script type="text/javascript">
//-----------------------------------------------
function set_userdef(form){
	form.time_option[0].checked = true;
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="get">
<div class="title">Usage Report</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="100" align="right">
	User :
		</td>
		<td>
			<input type="text" value="<%= g_user%>" name="user" size="25">
			<select onchange="javascript:this.form.user.value=this.value">
			<option value=''> Select a user
<%
List<String> user_list = new D1ReportDao("20000101", "").get_log_user_list();
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
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<div class="title">
<%= g_stime%> ~ <%= g_etime%>
<%
if(is_not_empty(g_user)){
	out.print(", " + g_user);
}
%>
</div>
</p>

<!-- list -->
<div class="list">

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="9"></td></tr>
	<tr class="head">
		<td width="90">Time</td>
		<td width="110" align="right">Request Sum</td>
		<td width="110" align="right">Request Count</td>
		<td width="110" align="right">Block Sum</td>
		<td width="110" align="right">Block Count</td>
		<td width="110" align="right">Domain Count</td>
		<td width="110" align="right">User Count</td>
		<td width="110" align="right">Client IP</td>
		<td width=""></td>
	</tr>
	<tr class="line"><td colspan="9"></td></tr>
<%
for(int i = 0; i < 30; i++){
	String stime = strftime_add("yyyyMMdd", (86400 * i * -1) - 1);

	D1ReportDao dao = new D1ReportDao(stime, g_user);
	ReportStatsData stats = dao.get_stats();

	if(i > 0){
		out.println("<tr class='line2'><td colspan='9'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= dao.get_stime()%></td>
		<td align="right"><%= stats.req_sum%>&nbsp;</td>
		<td align="right"><%= stats.req_cnt%>&nbsp;</td>
		<td align="right"><%= stats.block_sum%>&nbsp;</td>
		<td align="right"><%= stats.block_cnt%>&nbsp;</td>
		<td align="right"><%= stats.domain_cnt%>&nbsp;</td>
		<td align="right"><%= stats.user_cnt%>&nbsp;</td>
		<td align="right"><%= stats.clt_ip_cnt%>&nbsp;</td>
		<td width=""></td>
	</tr>
<%}%>

	<tr class="line"><td colspan="9"></td></tr>
</table>

</div>
<!-- /list -->

<%@include file="include/bottom.jsp"%>
