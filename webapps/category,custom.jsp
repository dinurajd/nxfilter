<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(CategoryCustomDao dao){
	CategoryData data = new CategoryData();
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

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(CategoryCustomDao dao){
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
CategoryCustomDao dao = new CategoryCustomDao();

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
function action_delete(id, name){
	if(!confirm("Deleting category: " + name)){
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
	form.action = "category,custom_edit.jsp";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Custom Category</div>

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
		<td><input type="text" name="description" size="50", maxlength="50"></td>
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
		<td width="200">Name</td>
		<td width="300">Description</td>
		<td width="">Domain</td>
		<td width="100"></td>
	</tr>
	<tr class="line"><td colspan="4"></td></tr>

<%
List<CategoryData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='4' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	CategoryData data = data_list.get(i);

	String name = data.name;
	if(data.system_flag){
		name = "*" + name;
	}

	int domain_cnt = data.get_domain_count();
	if(domain_cnt > 0){
		name = name + " - " + domain_cnt;
	}

	String domain_line = data.get_domain_line();
	if(domain_line.length() > 100){
		domain_line = domain_line.substring(0, 100) + "..";
	}

	if(i > 0){
		out.println("<tr class='line2'><td colspan='4'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= name%></td>
		<td><%= data.description%></td>
		<td><%= domain_line%></td>

		<td align="right">
		<input type="button" value="EDIT" onclick="javascript:go_edit(<%= data.id%>)">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.name%>')">
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
