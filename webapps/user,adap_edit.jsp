<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(AdapDao dao){
	LdapData data = new LdapData();
	data.id = param_int("id");
	data.host = param_str("host");
	data.admin = param_str("admin");
	data.passwd = param_str("passwd");
	data.basedn = param_str("basedn");
	data.domain = param_str("domain");
	data.follow_referral = param_bool("follow_referral");
	data.period = param_int("period");
	data.exclude_keyword = param_str("exclude_keyword");

    data.dns_ip = param_str("dns_ip");
    data.dns_timeout = param_int("dns_timeout");
	data.dns_load_balance = param_bool("dns_load_balance");

	// Param validation.
	if (!is_valid_ip(data.host)) {
		err_list.add("Invalid host IP!");
		return;
	}

	if (is_empty(data.admin)) {
		err_list.add("Admin missing!");
		return;
	}

	if (is_empty(data.basedn)) {
		err_list.add("Base DN missing!");
		return;
	}

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
AdapDao dao = new AdapDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
LdapData data = dao.select_one(param_int("id"));
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_update(form){
	if(form.dns_ip.value.indexOf(form.host.value) == -1 && !confirm("MS DNS server IP is different from host IP address?")){
		return;
	}

	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">
<input type="hidden" name="id" value="<%= data.id%>">

<div class="title">Active Directory</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="200">Host</td>
		<td><input type="text" name="host" size="25" value="<%= data.host%>"></td>
	</tr>

	<tr>
		<td>Admin</td>
		<td><input type="text" name="admin" size="25" value="<%= data.admin%>"></td>
	</tr>

	<tr>
		<td>Password</td>
		<td><input type="password" name="passwd" size="25" value="<%= data.passwd%>"></td>
	</tr>

	<tr>
		<td>Base DN</td>
		<td><input type="text" name="basedn" size="40" value="<%= data.basedn%>"></td>
	</tr>

	<tr>
		<td>Domain</td>
		<td><input type="text" name="domain" size="40" value="<%= data.domain%>"></td>
	</tr>

	<tr>
		<td>Follow Referral</td>
		<td><input type="checkbox" class="no_border"
			name="follow_referral" <%if(data.follow_referral){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Auto-sync</td>
		<td>
<select name="period">
<%
Map<Integer, String> period_map = get_ldap_period_map();
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

	<tr>
		<td>Exclude Keyword</td>
		<td>
			You can exclude some of users or groups based on keyword matching when you don't want to import<br>
			certain users or groups. You can add keywords separated by spaces. For a keyword having space use double quotes,<br>
			for exact matching use square brackets.<br>
			&nbsp;&nbsp;ex) support devel [DHCP Users] "main Co" john<br>
			<textarea name="exclude_keyword" cols="80" rows="6" class="my_textarea"><%= data.exclude_keyword%></textarea>
		</td>
	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:action_update(this.form);">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

<!-- MS DNS -->
<div class="title">MS DNS</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="200">DNS IP</td>
		<td>
		You can add multiple IP addresses separated by commas for redundancy or load banlacing.<br>
		<input type="text" name="dns_ip" size="25" value="<%= data.dns_ip%>">
		</td>
	</tr>

	<tr>
		<td>DNS Query Timeout</td>
		<td><input type="text" name="dns_timeout" size="2" maxlength="2" value="<%= data.dns_timeout%>"> seconds, 1 ~ 20</td>
	</tr>

	<tr>
		<td>DNS Load Balance</td>
		<td><input type="checkbox" class="no_border"
			name="dns_load_balance" <%if(data.dns_load_balance){out.print("checked");}%>></td>
	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:action_update(this.form);">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>

<!-- view -->

<%@include file="include/bottom.jsp"%>
