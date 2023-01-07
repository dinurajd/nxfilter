<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
boolean chk_param(DnsSetupData data){
	if (!is_valid_ip(data.upstream_dns1)) {
		err_list.add("Invalid IP address for DNS server #1!");
		return false;
	}

	if (is_not_empty(data.upstream_dns2) && !is_valid_ip(data.upstream_dns2)) {
		err_list.add("Invalid IP address for DNS server #2!");
		return false;
	}

	if (is_not_empty(data.upstream_dns3) && !is_valid_ip(data.upstream_dns3)) {
	    err_list.add("Invalid IP address for DNS server #3!");
	    return false;
	}

	return true;
}

//-----------------------------------------------
void update(DnsSetupDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	DnsSetupData data = new DnsSetupData();

	// DNS setup.	
	data.upstream_dns1 = param_str("upstream_dns1");
    data.upstream_dns2 = param_str("upstream_dns2");
    data.upstream_dns3 = param_str("upstream_dns3");
    data.upstream_timeout = param_int("upstream_timeout");
	data.upstream_load_balance = param_bool("upstream_load_balance");
    data.clt_cache_ttl = param_int("clt_cache_ttl");
    data.resp_cache_size = param_int("resp_cache_size");

    data.local_dns = param_str("local_dns");
    data.local_domain = param_str("local_domain");
    data.local_timeout = param_int("local_timeout");
	data.local_load_balance = param_bool("local_load_balance");
	data.use_local_dns = param_bool("use_local_dns");

    data.dynamic_dns_domain = param_str("dynamic_dns_domain");
	data.dynamic_dns_ttl = param_int("dynamic_dns_ttl");
	data.enable_dynamic_dns = param_bool("enable_dynamic_dns");

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
DnsSetupDao dao = new DnsSetupDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
DnsSetupData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!--  -->
<div class="title">DNS Setup</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Upstream DNS Server #1</td>
		<td><input type="text" name="upstream_dns1" value="<%= data.upstream_dns1%>" size="25"></td>
	</tr>
	
	<tr>
		<td>Upstream DNS Server #2</td>
		<td><input type="text" name="upstream_dns2" value="<%= data.upstream_dns2%>" size="25"></td>
	</tr>

	<tr>
		<td>Upstream DNS Server #3</td>
		<td><input type="text" name="upstream_dns3" value="<%= data.upstream_dns3%>" size="25"></td>
	</tr>
	
	<tr>
		<td>Upstream DNS Query Timeout</td>
		<td><input type="text" name="upstream_timeout" size="2" maxlength="2" value="<%= data.upstream_timeout%>"> seconds, 1 ~ 20</td>
	</tr>

	<tr>
		<td>Upstream DNS Load Balance</td>
		<td><input type="checkbox" class="no_border"
			name="upstream_load_balance" <%if(data.upstream_load_balance){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Max Client Cache TTL</td>
		<td><input type="text" name="clt_cache_ttl" size="5" maxlength="5"
			value="<%= data.clt_cache_ttl%>"> seconds, 60 ~ 86400, 0 = bypass</td>
	</tr>

	<tr>
		<td>Response Cache Size</td>
		<td><input type="text" name="resp_cache_size" size="7" maxlength="7"
			value="<%= data.resp_cache_size%>"> 100,000 ~ 2,000,000</td>
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
<div class="title">Local DNS</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Local DNS Server</td>
		<td><input type="text" name="local_dns" value="<%= data.local_dns%>" size="25"></td>
	</tr>

	<tr>
		<td>Local Domain</td>
		<td><input type="text" name="local_domain" value="<%= data.local_domain%>" size="50"></td>
	</tr>
	
	<tr>
		<td>Local DNS Query Timeout</td>
		<td><input type="text" name="local_timeout" size="2" maxlength="2" value="<%= data.local_timeout%>"> seconds, 1 ~ 20</td>
	</tr>

	<tr>
		<td>Local DNS Load Balance</td>
		<td><input type="checkbox" class="no_border"
			name="local_load_balance" <%if(data.local_load_balance){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Use Local DNS</td>
		<td><input type="checkbox" class="no_border"
			name="use_local_dns" <%if(data.use_local_dns){out.print("checked");}%>></td>
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
<div class="title">Dynamic DNS</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Dynamic DNS Domain</td>
		<td><input type="text" name="dynamic_dns_domain" value="<%= data.dynamic_dns_domain%>" size="25"></td>
	</tr>

	<tr>
		<td>Dynamic DNS TTL</td>
		<td><input type="text" name="dynamic_dns_ttl" size="5" maxlength="5"
			value="<%= data.dynamic_dns_ttl%>"> seconds, 60 ~ 86400</td>
	</tr>

	<tr>
		<td>Enable Dynamic DNS</td>
		<td><input type="checkbox" class="no_border"
			name="enable_dynamic_dns" <%if(data.enable_dynamic_dns){out.print("checked");}%>></td>
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
