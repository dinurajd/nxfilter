<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(LicenseDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	if(dao.update_license_key(param_str("license_key"))){
        succ_list.add("Data updated.");
        succ_list.add("Restarting needed to apply the new license.");
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
// Need to pass err_list for this one.
LicenseDao dao = new LicenseDao(err_list);

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
LicenseData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!--  -->
<div class="title">License</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">License key</td>
		<td>
			<input type="text" name="license_key" size="60">
		</td>
	</tr>

	<tr>
		<td>End date</td>
		<td>
			<%= data.end_date%>
		</td>
	</tr>

	<tr>
		<td>Max user</td>
		<td>
			<%= data.max_user%>
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

<%@include file="include/bottom.jsp"%>
