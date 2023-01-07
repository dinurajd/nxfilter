<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(AdapDao dao){
	LdapData data = new LdapData();
	data.host = param_str("host");
	data.admin = param_str("admin");
	data.passwd = param_str("passwd");
	data.basedn = param_str("basedn");
	data.domain = param_str("domain");
	data.period = param_int("period");

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

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(AdapDao dao){
	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void test(AdapDao dao){
	try{
		dao.test(param_int("id"));
		succ_list.add("LDAP connection succeeded!");
	}
	catch(Exception e){
		err_list.add(e.toString());
	}
}

//-----------------------------------------------
void import_ldap(AdapDao dao){
	String res = dao.import_ldap(param_int("id"));
	if(res == null){
		err_list.add("LDAP import failed!");
	}
	else{
		succ_list.add("LDAP imported!");
		succ_list.add(res);
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
if(action_flag.equals("insert")){
	insert(dao);
}
if(action_flag.equals("delete")){
	delete(dao);
}
if(action_flag.equals("test")){
	test(dao);
}
if(action_flag.equals("import_ldap")){
	import_ldap(dao);
}

// Global.
int g_count = dao.select_count();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, host){
	if(!confirm("Deleting host : " + host
		+ "\nAll the users and groups associated to the host will be lost.")){

		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function go_edit(id){
	var form = document.go_form;
	form.action = "user,adap_edit.jsp";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function action_test(id){
	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "test";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function action_import(id){
	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "import_ldap";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Active Directory</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="200">Host</td>
		<td>
			<input type="text" name="host" size="25"> ex) 192.168.0.100
		</td>
	</tr>

	<tr>
		<td>Admin</td>
		<td>
			<input type="text" name="admin" size="25"> ex) Administrator@nxfilter.local
		</td>
	</tr>

	<tr>
		<td>Password</td>
		<td>
			<input type="password" name="passwd" size="25">
		</td>
	</tr>


	<tr>
		<td>Base DN</td>
		<td>
			<input type="text" name="basedn" size="40"> ex) cn=users,dc=nxfilter,dc=local
		</td>
	</tr>

	<tr>
		<td>Domain</td>
		<td>
			<input type="text" name="domain" size="40"> ex) nxfilter.local
		</td>
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

	printf("<option value='%s'>%s", key, val);
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
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>

<!-- view -->

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
	<tr class="line"><td colspan="7"></td></tr>
	<tr class="head">
		<td width="120">Host</td>
		<td width="250">Admin</td>
		<td width="300">Base DN</td>
		<td width="120">Domain</td>
		<td width="150" align="center">Follow Referral</td>
		<td width="120">Auto-sync</td>
		<td width=""></td>
	</tr>
	<tr class="line"><td colspan="7"></td></tr>

<%
List<LdapData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='7' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	LdapData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='7'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.host%></td>
		<td><%= data.admin%></td>
		<td><%= data.basedn%></td>
		<td><%= data.domain%></td>
		<td align="center"><%= data.get_follow_referral_yn()%></td>
		<td><%= get_ldap_period_string(data.period)%></td>
		<td align="right">
		<input type="button" value="IMPORT" onclick="javascript:action_import(<%= data.id%>)">
		<input type="button" value="TEST" onclick="javascript:action_test(<%= data.id%>)">
		<input type="button" value="EDIT" onclick="javascript:go_edit(<%= data.id%>)">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.host%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="7"></td></tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="id" value="">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
