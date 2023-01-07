<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void delete(ExcludedDao dao){
	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete_all(ExcludedDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	if(dao.delete_all()){
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
ExcludedDao dao = new ExcludedDao();
dao.page = param_int("page", 1);
dao.add_kw(param_str("kw"));

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("delete")){
	delete(dao);
}
if(action_flag.equals("delete_all")){
	delete_all(dao);
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
function action_delete(id, domain){
	if(!confirm("Deleting data : " + domain)){
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
function set_popup_form(domain){
	document.popup_form.domain.value = domain;
	document.popup_form.id.value = 0;
	document.popup_form.chk_subdomain.checked = false;
	$("#popup_result").empty();
}
</script>

<!-- view -->
<div class="title">Excluded</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
This is the excluded domains from classification for having critial errors. NxClassifier doesn't do classification
against any domain in this list.
		</td>
	</tr>

	<tr>
		<td>
		&nbsp;&nbsp;<input type="button" value="DELETE-ALL"
			onclick="javascript:action_delete_all()">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">
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
	<tr class="line"><td colspan="4"></td></tr>
	<tr class="head">
		<td width="100">Time</td>
		<td width="250">Domain</td>
		<td width="">Reason</td>
		<td width="150"></td>
	</tr>
	<tr class="line"><td colspan="4"></td></tr>

<%
List<ExcludedData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='4' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	ExcludedData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='4'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.get_ctime()%></td>
		<td><%= data.domain%></td>
		<td><%= data.reason%></td>
		<td align="right">
			<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.domain%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="4"></td></tr>
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
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
