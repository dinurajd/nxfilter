<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(AllowedIpDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	AllowedIpData data = new AllowedIpData();
	data.dns_allowed = param_str("dns_allowed");
	data.dns_blocked = param_str("dns_blocked");
	data.login_allowed = param_str("login_allowed");
	data.gui_allowed = param_str("gui_allowed");

	if(dao.update(data)){
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
AllowedIpDao dao = new AllowedIpDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
AllowedIpData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<div class="title">Allowed IP</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
<div style="line-height:20px;">
If you add IP addresses here then unregistered IP will be blocked.<br>
You can add following IP form.
</div>
	<div class="tab">
	ex) 192.168.1 - IP addresses which start with '192.168.1'
	</div>
	</p>

* You can add multiple IP addresses separated by spaces.<br>
	<div class="tab">
	ex) 192.168.1 192.168.2
	</div>

		</td>
	</tr>

	<tr>
		<td colspan="2">
&nbsp;
		</td>
	</tr>

	<tr>
		<td width="200">Allowed IP for DNS</td>
		<td>
			If there's nothing added here everybody can access your DNS.<br>
			<textarea name="dns_allowed" cols="80" rows="4" class="my_textarea"><%= data.dns_allowed%></textarea>
		</td>
	</tr>

	<tr>
		<td colspan="2">
&nbsp;
		</td>
	</tr>

	<tr>
		<td>Blocked IP for DNS</td>
		<td>
			This is a blacklist based way of access control. It overrides 'Allowed IP for DNS'.<br>
			<textarea name="dns_blocked" cols="80" rows="4" class="my_textarea"><%= data.dns_blocked%></textarea>
		</td>
	</tr>

	<tr>
		<td colspan="2">
&nbsp;
		</td>
	</tr>

	<tr>
		<td>Allowed IP for GUI</td>
		<td>
			'localhost' or '127.0.0.1' always allowed for admin GUI.<br>
			<textarea name="gui_allowed" cols="80" rows="4" class="my_textarea"><%= data.gui_allowed%></textarea>
		</td>
	</tr>

	<tr>
		<td>Allowed IP for Login Redirection</td>
		<td>
			If there's nothing added here all unauthenticated users will be redirected to the login-page.<br>
			<textarea name="login_allowed" cols="80" rows="4" class="my_textarea"><%= data.login_allowed%></textarea>
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

<%@include file="include/bottom.jsp"%>
