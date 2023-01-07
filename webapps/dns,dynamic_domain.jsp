<%@include file="include/top.jsp"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

// Create data access object.
DynamicDomainDao dao = new DynamicDomainDao();
dao.limit = 100;
dao.page = param_int("page", 1);
dao.add_kw(param_str("kw"));

// Global.
int g_count = dao.select_count();
int g_page = dao.page;
int g_limit = dao.limit;
String g_kw = param_str("kw");
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
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

<div class="title">Dynamic Domain</div>
<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
This is the list of dynamic domains being serviced.
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
		<td width="300">Domain</td>
		<td width="300">IP</td>
		<td width="">Last Update</td>
	</tr>
	<tr class="line"><td colspan="3"></td></tr>

<%
List<DynamicDomainData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='3' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	DynamicDomainData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='3'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.domain%></td>
		<td><%= data.ip%></td>
		<td><%= data.get_mtime()%></td>
	</tr>
<%}%>

	<tr class="line"><td colspan="3"></td></tr>
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
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
