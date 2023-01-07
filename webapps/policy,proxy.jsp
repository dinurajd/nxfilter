<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(PolicyProxyDao dao){
	PolicyProxyData data = new PolicyProxyData();
	data.enable_proxy = param_bool("enable_proxy");
	data.block_https = param_bool("block_https");
	data.block_ip_host = param_bool("block_ip_host");
	data.block_other_browser = param_bool("block_other_browser");
	data.blocked_keyword = param_str("blocked_keyword");
	data.ie_proxy_bypass = param_str("ie_proxy_bypass");
	data.cache_ttl = param_int("cache_ttl");

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
PolicyProxyDao dao = new PolicyProxyDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
PolicyProxyData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<div class="title">Proxy Filtering</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	</tr>

	<tr>
		<td width="200">Enable Filtering</td>
		<td>
		<input type="checkbox" class="no_border" name="enable_proxy"
			<%if(data.enable_proxy){out.print("checked");}%>>
			Proxy filtering requires NxClient or NxBlock running on user PC.
			</td>
	</tr>

	<tr>
		<td>Block HTTPS</td>
		<td><input type="checkbox" class="no_border" name="block_https"
			<%if(data.block_https){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Block IP Host</td>
		<td><input type="checkbox" class="no_border" name="block_ip_host"
			<%if(data.block_ip_host){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Block Other Browser</td>
		<td>
		<input type="checkbox" class="no_border" name="block_other_browser"
			<%if(data.block_other_browser){out.print("checked");}%>>
			Block any program making direct HTTP connection to the Internet.
			</td>
	</tr>

	<tr>
		<td>Blocked Keyword in URL</td>
		<td>
			You can block URL for browser requests using a keyword in URL. When you add multiple keywords<br>
			separate them by spaces.<br>
			&nbsp;&nbsp;ex) game image movie<br>
			<textarea name="blocked_keyword" cols="80" rows="6" class="my_textarea"><%= data.blocked_keyword%></textarea>
		</td>
	</tr>

	<tr>
		<td>IE Proxy Bypass</td>
		<td>
			This is for bypassing NxClient on Windows. You can add multiple domains separated by semicolons.<br>
			&nbsp;&nbsp;ex) https://*.google.com;http://www.nxfilter.org:8080<br>
			<textarea name="ie_proxy_bypass" cols="80" rows="6" class="my_textarea"><%= data.ie_proxy_bypass%></textarea>
		</td>
	</tr>

	<tr>
		<td>Query Cache TTL</td>
		<td><input type="text" name="cache_ttl" value="<%= data.cache_ttl%>" size="2"> seconds, 60 ~ 3600</td>
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
