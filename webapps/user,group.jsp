<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(GroupDao dao){
	GroupData data = new GroupData();
	data.name = param_str("name");
	data.description = param_str("description");

	// Param validation.
	if(!ParamTest.is_valid_name_len(data.name)){
		err_list.add(ParamTest.ERR_NAME_LEN);
		return;
	}
	
	if(!ParamTest.is_valid_username_char(data.name)){
		err_list.add(ParamTest.ERR_NAME_CHAR);
		return;
	}

	if (ParamTest.is_dup_group(data.name)) {
		err_list.add("Group already exists!");
		return;
	}

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(GroupDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

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
GroupDao dao = new GroupDao();
dao.limit = 30;
dao.page = param_int("page", 1);
dao.add_kw(param_str("kw"));

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
int g_page = dao.page;
int g_limit = dao.limit;
String g_kw = param_str("kw");
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, name){
	if(!confirm("Deleting group : " + name)){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function go_page(page){
	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.page.value = page;
	form.submit();
}

//-----------------------------------------------
function go_search(kw){
	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.kw.value = document.all("search_kw").value;
	form.page.value = "1";
	form.submit();
}

//-----------------------------------------------
function go_edit(id){
	var form = document.go_form;
	form.action = "user,group_edit.jsp";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Group</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Name</td>
		<td>
			<input type="text" name="name" size="25">
		</td>
	</tr>

	<tr>
		<td>Description</td>
		<td>
			<input type="text" name="description" size="50">
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
		<td width="50%">
			Count : <%= g_count%> / Page : <%= g_page%>
		</td>
		<td align="right">
			<input type="text" name="search_kw" size="25" value="<%= g_kw%>"
				onkeypress="javascript:if(event.keyCode == 13){go_search(); return;}">
			<input type="button" value="SEARCH" onclick="javascript:go_search()">
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="6"></td></tr>
	<tr class="head">
		<td width="200">Name</td>
		<td width="100" align="center">LDAP</td>
		<td width="250">Policy</td>
		<td width="300">User</td>
		<td width="">Description</td>
		<td width="150"></td>
	</tr>
	<tr class="line"><td colspan="6"></td></tr>

<%
List<GroupData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='6' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	GroupData data = data_list.get(i);

	String user_line = data.get_user_line();
	if(user_line.length() > 40){
		user_line = user_line.substring(0, 40);
	}

	// Add free-time policy.
	if(!is_empty(data.ft_policy_name)){
		data.policy_name += " / " + data.ft_policy_name;
	}

	if(i > 0){
		out.println("<tr class='line2'><td colspan='6'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.name%></td>
		<td align="center"><%= data.get_ldap_yn()%></td>
		<td><%= data.policy_name%></td>
		<td><%= user_line%></td>
		<td><%= data.description%></td>
		<td align="right">
		<input type="button" value="EDIT" onclick="javascript:go_edit(<%= data.id%>)">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.name%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="6"></td></tr>
</table>
</div>
<!-- /list -->

<table border="0" width="100%">
	<tr>
		<td align="center"><%= get_pagination(g_count, g_limit, g_page)%></td>
	</tr>
</table>

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="page" value="<%= g_page%>">
<input type="hidden" name="kw" value="<%= g_kw%>">
<input type="hidden" name="id" value="">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
