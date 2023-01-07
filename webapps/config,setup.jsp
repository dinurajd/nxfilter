<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
boolean chk_param(ConfigData data){
	// Redirection IP.
	if (!ParamTest.is_valid_block_ip(data.block_redi_ip)) {
	    err_list.add("Invalid block redirection IP!");
	    return false;
	}

	if (is_not_empty(data.rf_block_redi_ip)) {
	    if (!ParamTest.is_valid_block_ip(data.rf_block_redi_ip)) {
		    err_list.add("Invalid external redirection IP!");
			return false;
	    }
	}

	if (is_not_empty(data.ipv6_block_redi_ip)) {
	    if (!is_valid_ipv6(data.ipv6_block_redi_ip)) {
		    err_list.add("Invalid IPv6 redirection IP!");
			return false;
	    }
	}

	// Login, logout domain.
	if (!is_valid_domain(data.login_domain)) {
		err_list.add("Invalid login domain!");
		return false;
	}

	if (!is_valid_domain(data.logout_domain)) {
		err_list.add("Invalid logout domain!");
		return false;
	}

	// Syslog.
	if (is_not_empty(data.syslog_host) && !is_valid_ip(data.syslog_host)) {
		err_list.add("Invalid IP address for Syslog host!");
		return false;
	}

	if (data.remote_logging && is_empty(data.syslog_host)) {
	    err_list.add("Remote logging option requires Syslog host!");
	    return false;
	}

	// Netflow.
	if (is_not_empty(data.netflow_ip) && !is_valid_ip(data.netflow_ip)) {
		err_list.add("Invalid router IP!");
		return false;
	}

	if (data.use_netflow && is_empty(data.netflow_ip)) {
	    err_list.add("Router IP missing!");
	    return false;
	}

	// Misc.
	if (!is_valid_domain(data.admin_domain)) {
	    err_list.add("Invalid admin domain!");
	    return false;
	}

	return true;
}

//-----------------------------------------------
void update(ConfigDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	ConfigData data = new ConfigData();

	// Block and authentication.
    data.block_redi_ip = param_str("block_redi_ip");
    data.rf_block_redi_ip = param_str("rf_block_redi_ip");
    data.ipv6_block_redi_ip = param_str("ipv6_block_redi_ip");
    data.enable_login = param_bool("enable_login");
    data.login_domain = param_str("login_domain");
    data.logout_domain = param_str("logout_domain");
    data.login_session_ttl = param_int("login_session_ttl");

	// Syslog.
    data.syslog_host = param_str("syslog_host");
    data.export_blocked_only = param_bool("export_blocked_only");
    data.remote_logging = param_bool("remote_logging");

    // Netflow.
	data.netflow_ip = param_str("netflow_ip");
    data.netflow_port = param_int("netflow_port");
    data.use_netflow = param_bool("use_netflow");

	// Misc.
    data.admin_domain = param_str("admin_domain");
    data.bypass_ms_update = param_bool("bypass_ms_update");
    data.log_retention_days = param_int("log_retention_days");
    data.ssl_only = param_bool("ssl_only");
	data.auto_backup_days = param_int("auto_backup_days");
	data.agent_policy_update_period = param_int("agent_policy_update_period");

	// Validate and update it.
	if(chk_param(data) && dao.update(data)){
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
ConfigDao dao = new ConfigDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
ConfigData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!--  -->
<div class="title">Block and Authentication</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Block Redirection IP</td>
		<td><input type="text" name="block_redi_ip" value="<%= data.block_redi_ip%>" size="25"></td>
	</tr>

	<tr>
		<td>External Redirection IP</td>
		<td><input type="text" name="rf_block_redi_ip" value="<%= data.rf_block_redi_ip%>" size="25"></td>
	</tr>

	<tr>
		<td>IPv6 Redirection IP</td>
		<td><input type="text" name="ipv6_block_redi_ip" value="<%= data.ipv6_block_redi_ip%>" size="25"></td>
	</tr>

	<tr>
		<td>Enable Authentication</td>
		<td><input type="checkbox" class="no_border"
			name="enable_login"	<%if(data.enable_login){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Login Domain</td>
		<td><input type="text" name="login_domain" value="<%= data.login_domain%>" size="25"></td>
	</tr>

	<tr>
		<td>Logout Domain</td>
		<td><input type="text" name="logout_domain" value="<%= data.logout_domain%>" size="25"></td>
	</tr>

	<tr>
		<td>Login Session TTL</td>
		<td><input type="text" name="login_session_ttl" size="4" maxlength="4"
			value="<%= data.login_session_ttl%>"> minutes, 5 ~ 1440</td>
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

<!--  -->
<div class="title">Syslog</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Syslog Host</td>
		<td>
		You neet to restart NxFilter when you change Syslog setup.<br>
		<input type="text" name="syslog_host" value="<%= data.syslog_host%>" size="25"></td>
	</tr>

	<tr>
		<td>Export Blocked Only</td>
		<td><input type="checkbox" class="no_border"
			name="export_blocked_only" <%if(data.export_blocked_only){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Enable Remote Logging</td>
		<td><input type="checkbox" class="no_border"
			name="remote_logging" <%if(data.remote_logging){out.print("checked");}%>></td>
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

<!--  -->
<div class="title">NetFlow</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Router IP</td>
		<td>
		You neet to restart NxFilter when you change NetFlow setup.<br>
		<input type="text" name="netflow_ip" value="<%= data.netflow_ip%>" size="25"></td>
	</tr>

	<tr>
		<td>Listen Port</td>
		<td><input type="text" name="netflow_port" value="<%= data.netflow_port%>" size="2"></td>
	</tr>

	<tr>
		<td>Run Collector</td>
		<td><input type="checkbox" class="no_border"
			name="use_netflow" <%if(data.use_netflow){out.print("checked");}%>>
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

<!--  -->
<div class="title">Misc</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Admin Domain</td>
		<td><input type="text" name="admin_domain" value="<%= data.admin_domain%>" size="25"></td>
	</tr>

	<tr>
		<td>Bypass Microsoft Update</td>
		<td><input type="checkbox" class="no_border"
			name="bypass_ms_update" <%if(data.bypass_ms_update){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Log Retention Days</td>
		<td><input type="text" name="log_retention_days" size="2" maxlength="3"
			value="<%= data.log_retention_days%>"> days, 3 ~ 400</td>
	</tr>

	<tr>
		<td>SSL Only to Admin GUI</td>
		<td><input type="checkbox" class="no_border"
			name="ssl_only" <%if(data.ssl_only){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Auto Backup</td>
		<td><input type="text" name="auto_backup_days" size="2" maxlength="2"
			value="<%= data.auto_backup_days%>"> days, 0 ~ 30</td>
	</tr>

	<tr>
		<td>Agent Policy Update Period</td>
		<td><input type="text" name="agent_policy_update_period" size="3" maxlength="3"
			value="<%= data.agent_policy_update_period%>"> seconds, 60 ~ 600</td>
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
