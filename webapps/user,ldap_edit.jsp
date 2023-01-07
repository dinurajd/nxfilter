<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(LdapDao dao){
	LdapData data = new LdapData();
	data.id = param_int("id");
	data.host = param_str("host");
	data.admin = param_str("admin");
	data.passwd = param_str("passwd");
	data.basedn = param_str("basedn");
	data.ldap_type = LdapData.TYPE_LD;
	data.period = param_int("period");
	data.exclude_keyword = param_str("exclude_keyword");

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
<%@include file="include/action_info.jsp"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// Create data access object.
LdapDao dao = new LdapDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
LdapData data = dao.select_one(param_int("id"));
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">
<input type="hidden" name="id" value="<%= data.id%>">

<div class="title">OpenLDAP</div>

<hr size="1">
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
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>

</table>
<hr size="1">

</form>

<!-- view -->

<%@include file="include/bottom.jsp"%>
