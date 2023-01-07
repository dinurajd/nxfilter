<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
boolean chk_param(AlertData data){
	if (is_empty(data.admin_email) || !is_valid_email(data.admin_email)) {
		err_list.add("Invalid email!");
		return false;
	}

	if (data.period > 0 && (is_empty(data.admin_email) || is_empty(data.smtp_host))) {
		err_list.add("Email alert option requires admin email and SMTP host!");
		return false;
	}

	return true;
}

//-----------------------------------------------
void update(AlertDao dao){
	AlertData data = new AlertData();

	data.admin_email = param_str("admin_email");
	data.smtp_host = param_str("smtp_host");
	data.smtp_port = param_int("smtp_port");
	data.smtp_ssl = param_bool("smtp_ssl");
	data.smtp_user = param_str("smtp_user");
	data.smtp_passwd = param_str("smtp_passwd");
	data.period = param_int("period");

	data.alert_category_arr = param_arr("alert_category_arr");

	// Validate and update it.
	if(chk_param(data) && dao.update(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void test(AlertDao dao){
	AlertData data = new AlertData();

	data.admin_email = param_str("admin_email");
	data.smtp_host = param_str("smtp_host");
	data.smtp_port = param_int("smtp_port");
	data.smtp_ssl = param_bool("smtp_ssl");
	data.smtp_user = param_str("smtp_user");
	data.smtp_passwd = param_str("smtp_passwd");
	data.period = param_int("period");

	// Validate and update it.
	if(!chk_param(data) || !dao.update(data)){
		return;
	}

	try{
		dao.test();
		succ_list.add("Test email has been sent!");
	}
	catch(Exception e){
		err_list.add(e.toString());
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
AlertDao dao = new AlertDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}
if(action_flag.equals("test")){
	test(dao);
}

// Global.
AlertData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_test(form){
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "test";
	form.submit();
}
</script>

<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!--  -->
<div class="title">Alert</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Admin Email</td>
		<td><input type="text" name="admin_email" value="<%= data.admin_email%>" size="25"></td>
	</tr>

	<tr>
		<td>SMTP Host</td>
		<td><input type="text" name="smtp_host" value="<%= data.smtp_host%>" size="25"></td>
	</tr>

	<tr>
		<td>SMTP Port</td>
		<td><input type="text" name="smtp_port" value="<%= data.smtp_port%>" size="2"></td>
	</tr>

	<tr>
		<td>SMTP SSL</td>
		<td><input type="checkbox" class="no_border"
			name="smtp_ssl" <%if(data.smtp_ssl){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>SMTP User</td>
		<td><input type="text" name="smtp_user" value="<%= data.smtp_user%>" size="25"></td>
	</tr>

	<tr>
		<td>SMTP Password</td>
		<td><input type="password" name="smtp_passwd" value="<%= data.smtp_passwd%>" size="25"></td>
	</tr>

	<tr>
		<td>Alert Period</td>
		<td>
<select name="period">
<%
Map<Integer, String> period_map = get_alert_period_map();
for(Map.Entry<Integer, String> entry : period_map.entrySet()){
	Integer key = entry.getKey();
	String val = entry.getValue();

	if(key == data.period){
		printf("<option value='%s' selected>%s", key, val);
	}
	else{
		printf("<option value='%s'>%s", key, val);
	}
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
<input type="button" value="TEST" onclick="javascript:action_test(this.form);">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

<!--  -->
<div class="title">Alert Categories</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
<input type="button" value="TOGGLE-ALL" onclick="javascript:checkbox_toggle_all3('alert_category_arr');">
	<br>

<%
for(int i = 0; i < data.alert_category_list.size(); i++){
	CategoryData cd = data.alert_category_list.get(i);

	String chk = "";
	if(cd.check_flag){
		chk = "checked";	
	}

	if(i > 0 && i % 6 == 0){
		out.println("<br>");
	}
%>
	<span class="category_item">
<input type="checkbox" class="no_border"
	name="alert_category_arr" value="<%= cd.id%>" <%= chk%>><%= cd.name%>
	</span>
<%}%>

		</td>
	</tr>

	<tr height="30">
		<td align="center">
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

</form>

<%@include file="include/bottom.jsp"%>
