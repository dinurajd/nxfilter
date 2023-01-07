<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(WhitelistDomainDao dao){
	WhitelistData data = new WhitelistData();
	data.domain = param_str("domain");
	data.bypass_auth = param_bool("bypass_auth");
	data.bypass_filter = param_bool("bypass_filter");
	data.bypass_log = param_bool("bypass_log");
	data.admin_block = param_bool("admin_block");

	// Param validation.
	if(!is_valid_domain(data.domain)){
		err_list.add("Invalid domain!");
		return;
	}
	
	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(WhitelistDomainDao dao){
	if(dao.delete(param_int("id"))){
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
WhitelistDomainDao dao = new WhitelistDomainDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("insert")){
	insert(dao);
}
if(action_flag.equals("delete")){
	delete(dao);
}

// Global.
int g_count = dao.select_count();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, domain){
	if(!confirm("Deleting domain : " + domain)){
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
	form.action = "whitelist,domain_edit.jsp";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Whitelist by Domain</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Domain</td>
		<td>
<div style="line-height:20px;">
To include subdomains use asterisk.<br>
ex) *.nxfilter.org
</div>
			<input type="text" name="domain" size="25">
		</td>
	</tr>

	<tr>
		<td>Bypass Authentication</td>
		<td>
			<input type="checkbox" class="no_border" name="bypass_auth">
		</td>
	</tr>

	<tr>
		<td>Bypass Filtering</td>
		<td>
			<input type="checkbox" class="no_border" name="bypass_filter">
		</td>
	</tr>

	<tr>
		<td>Bypass Logging</td>
		<td>
			<input type="checkbox" class="no_border" name="bypass_log">
		</td>
	</tr>

	<tr>
		<td>Admin Block</td>
		<td>
			<input type="checkbox" class="no_border" name="admin_block">
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
	<tr class="line"><td colspan="4"></td></tr>
	<tr class="head">
		<td width="200">Domain</td>
		<td width="400">Flags</td>
		<td width="500">Applied Policy</td>
		<td width=""></td>
	</tr>
	<tr class="line"><td colspan="4"></td></tr>

<%
List<WhitelistData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='4' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	WhitelistData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='4'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.domain%></td>
		<td><%= data.get_flag_line()%></td>
		<td><%= data.get_applied_policy_line()%></td>
		<td align="right">
			<input type="button" value="EDIT" onclick="javascript:go_edit(<%= data.id%>)">
			<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.domain%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="4"></td></tr>
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
