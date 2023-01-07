<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(PolicyDao dao){
	PolicyData data = new PolicyData();
	data.name = param_str("name");
	data.description = param_str("description");
	data.copy_id = param_int("copy_id");

	// Param validation.
	if(!ParamTest.is_valid_name_len(data.name)){
		err_list.add(ParamTest.ERR_NAME_LEN);
		return;
	}
	
	if(!ParamTest.is_valid_username_char(data.name)){
		err_list.add(ParamTest.ERR_NAME_CHAR);
		return;
	}

	if (ParamTest.is_dup_policy(data.name)) {
		err_list.add("Policy already exists!");
		return;
	}

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(PolicyDao dao){
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
PolicyDao dao = new PolicyDao();

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

// Get policy list.
List<PolicyData> g_policy_list = dao.select_list();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, name){
	if(!confirm("Deleting policy: " + name)){
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
	form.action = "policy,policy_edit.jsp";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Policy</div>

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
		<td><input type="text" name="description" size="50"></td>
	</tr>

	<tr>
		<td>Template Policy</td>
		<td>
<select name="copy_id">
	<option value="0">Select a policy
<%
for(PolicyData data : g_policy_list){
	printf("<option value='%s'>%s", data.id, data.name);
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
	<tr class="line"><td colspan="5"></td></tr>
	<tr class="head">
		<td width="200">Name</td>
		<td width="100" align="right">Priority Points</td>
		<td width="100"></td>
		<td width="">Description</td>
		<td width="100"></td>
	</tr>
	<tr class="line"><td colspan="5"></td></tr>

<%
for(int i = 0; i < g_policy_list.size(); i++){
	PolicyData data = g_policy_list.get(i);

	String name = data.name;
	if(data.system_flag){
		name = "*" + name;
	}

	if(i > 0){
		out.println("<tr class='line2'><td colspan='5'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= name%></td>
		<td align="right"><%= data.points%></td>
		<td></td>
		<td><%= data.description%></td>
		<td align="right">
		<input type="button" value="EDIT" onclick="javascript:go_edit(<%= data.id%>)">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.name%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="5"></td></tr>
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
