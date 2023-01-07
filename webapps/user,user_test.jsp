<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void quota_reset(UserTestDao dao){
	if(dao.quota_reset(param_str("name"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void bandwidth_reset(UserTestDao dao){
	if(dao.bandwidth_reset(param_str("name"))){
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
UserTestDao dao = new UserTestDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("quota_reset")){
	quota_reset(dao);
}
if(action_flag.equals("bandwidth_reset")){
	bandwidth_reset(dao);
}

// Global.
UserTestData data = dao.test(param_str("name"));
%>

<script type="text/javascript">
//-----------------------------------------------
function action_quota_reset_user(form){
	form.action_flag.value = "quota_reset";
	form.submit();
}

//-----------------------------------------------
function action_bandwidth_reset_user(form){
	form.action_flag.value = "bandwidth_reset";
	form.submit();
}
</script>
<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="quota_reset">
<input type="hidden" name="name" value="<%= data.name%>">

<!--  -->
<div class="title">User</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="100">Name : </td>
		<td>
			<%= data.name%>
		</td>
	</tr>
	<tr>
		<td>Group : </td>
		<td>
			<%= data.group_name%>
		</td>
	</tr>
	<tr>
		<td>User Policy : </td>
		<td>
			<%= data.policy_name%>
		</td>
	</tr>
	<tr>
		<td>Applied Policy : </td>
		<td>
			<%= data.applied_policy_name%>
		</td>
	</tr>
	<tr>
		<td>Free-time : </td>
		<td>
			<%= data.is_free_time ? "Yes" : "No"%>
		</td>
	</tr>
	<tr>
		<td>Quota : </td>
		<td>
			<%= data.quota_used%> / <%= data.quota_limit%> minutes
			<input type="button" value="RESET" onclick="javascript:action_quota_reset_user(this.form)">
		</td>
	</tr>
	<tr>
		<td>Bandwidth : </td>
		<td>
			<%= data.bandwidth_used%> / <%= data.bandwidth_limit%> MB
			<input type="button" value="RESET" onclick="javascript:action_bandwidth_reset_user(this.form)">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

<!-- /view -->

<%@include file="include/bottom.jsp"%>
