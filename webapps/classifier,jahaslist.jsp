<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(JahaslistDao dao){
	JahaslistData data = new JahaslistData();
	data.domain = param_str("domain");
	data.category_id = param_int("category_id");

	// Param validation.
	if(is_empty(data.domain)){
		return;
	}

    if(data.category_id == 0){
		err_list.add("Invalid category!");
		return;
	}

	String[] arr = data.domain.split("\\s+");
	for (String domain : arr) {
		domain = domain.trim();

		if (!is_valid_domain(domain)) {
			err_list.add("Invalid domain! - " + domain);
			return;
		}
	}

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(JahaslistDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete_all(JahaslistDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	if(dao.delete_all()){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void restore_default(JahaslistDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	if(dao.restore_default()){
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
JahaslistDao dao = new JahaslistDao();
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
if(action_flag.equals("delete_all")){
	delete_all(dao);
}
if(action_flag.equals("restore_default")){
	restore_default(dao);
}
if(action_flag.equals("export")){
	String filename = "jahaslist_" + strftime("yyyyMMddHHmm") + ".txt";

	if(dao.export_file(filename)){
		response.sendRedirect("download.jsp?filename=" + filename + "&content_type=text/plain");
		return;
	}
	else{
		err_list.add("Couldn't write the file!");
	}
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
function action_export(){
	var form = document.go_form;
	form.action_flag.value = "export";
	form.submit();
}

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
function action_delete_all(){
	if(!confirm("Delete all?")){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete_all";
	form.submit();
}

//-----------------------------------------------
function action_restore_default(){
	if(!confirm("Restore default?")){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "restore_default";
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
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Jahaslist</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="200">Domain</td>
		<td>
			You can add mutiple domains separated by spaces.<br>
			<textarea name="domain" cols="80" rows="2" class="my_textarea"></textarea>
		</td>
	</tr>

	<tr>
		<td>Category</td>
		<td>
<select name="category_id">
<option value="0">Select a category
<%
Map<Integer,String> jahas_category_map = dao.get_jahas_category_map();
for(Map.Entry<Integer,String> entry : jahas_category_map.entrySet()){
	int category_id = entry.getKey();
	String category_name = entry.getValue();
	printf("<option value='%s'>%s", category_id, category_name);
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
<input type="button" value="DELETE-ALL" onclick="javascript:action_delete_all();">
<input type="button" value="RESTORE-DEFAULT" onclick="javascript:action_restore_default();">
<input type="button" value="EXPORT" onclick="javascript:action_export();">
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
	<tr class="line"><td colspan="3"></td></tr>
	<tr class="head">
		<td width="400">Domain</td>
		<td width="">Category</td>
		<td width="100"></td>
	</tr>
	<tr class="line"><td colspan="3"></td></tr>

<%
List<JahaslistData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='3' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	JahaslistData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='3'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.domain%></td>
		<td><%= data.category_name%></td>
		<td align="right">
			<input type="button" class="listbutton" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.domain%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="3"></td></tr>
</table>

<table border="0" width="100%">
	<tr>
		<td align="center"><%= get_pagination(g_count, g_limit, g_page)%></td>
	</tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="page" value="<%= g_page%>">
<input type="hidden" name="kw" value="<%= g_kw%>">
<input type="hidden" name="id" value="">
<input type="hidden" name="domain" value="">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
