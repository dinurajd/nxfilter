<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(FreeTimeDao dao){
	String stime_hh = param_str("stime_hh");
	String stime_mm = param_str("stime_mm");
	String etime_hh = param_str("etime_hh");
	String etime_mm = param_str("etime_mm");

	FreeTimeData data = new FreeTimeData();
	data.stime = stime_hh + stime_mm;
	data.etime = etime_hh + etime_mm;
	data.wday_arr = param_arr("wday_arr");
	data.description = param_str("description");

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(FreeTimeDao dao){
	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}
%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// Create data access object.
FreeTimeDao dao = new FreeTimeDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("insert")){
	insert(dao);
}
if(action_flag.equals("delete")){
	delete(dao);
}

// Global.
int g_count = dao.select_count();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id){
	if(!confirm("Deleting free-time?")){
		return;
	}

	var form = document.go_form;
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Free Time</div>

<%
List<String> hh_list = get_hh_list();
List<String> mm_list = get_mm_list();
%>
<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>Time</td>
		<td>
<select name="stime_hh">
<%
for(String hh : hh_list){
	printf("<option value='%s'>%s</option>\n", hh, hh);
}
%>
</select>

<select name="stime_mm">
<%
for(String mm : mm_list){
	printf("<option value='%s'>%s</option>\n", mm, mm);
}
%>
</select>
 ~
<select name="etime_hh">
<%
for(String hh : hh_list){
	printf("<option value='%s'>%s</option>\n", hh, hh);
}
%>
</select>

<select name="etime_mm">
<%
for(String mm : mm_list){
	printf("<option value='%s'>%s</option>\n", mm, mm);
}
%>
</select>

		</td>
	</tr>

	<tr>
		<td width="200">Day of Week</td>
		<td>
			<input type="button" value="TOGGLE-ALL" onclick="javascript:checkbox_toggle_all3('wday_arr');"><br>
			<input type="checkbox" class="no_border" name="wday_arr" value="2">Mon
			<input type="checkbox" class="no_border" name="wday_arr" value="3">Tue
			<input type="checkbox" class="no_border" name="wday_arr" value="4">Wed
			<input type="checkbox" class="no_border" name="wday_arr" value="5">Thu
			<input type="checkbox" class="no_border" name="wday_arr" value="6">Fri
			<input type="checkbox" class="no_border" name="wday_arr" value="7">Sat
			<input type="checkbox" class="no_border" name="wday_arr" value="1">Sun
		</td>
	</tr>

	<tr>
		<td>Description</td>
		<td><input type="text" name="description" size="50"></td>
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
<p>

<!-- list -->
<div class="list">
<table width="100%">
	<tr>
		<td>
			Count : <%= g_count%>
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="4"></td></tr>
	<tr class="head">
		<td width="200">Time</td>
		<td width="300">Day of Week</td>
		<td width="">Description</td>
		<td width="100"></td>
	</tr>
	<tr class="line"><td colspan="4"></td></tr>

<%
List<FreeTimeData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='4' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	FreeTimeData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='4'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.stime%> ~ <%= data.etime%></td>
		<td><%= data.get_wday_line()%></td>
		<td><%= data.description%></td>
		<td align="right">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>)">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="4"></td></tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form name="go_form" method="get">
<input type="hidden" name="mode" value="">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="id" value="">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
