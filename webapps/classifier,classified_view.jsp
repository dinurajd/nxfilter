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
ClassifiedDao dao = new ClassifiedDao();

// Global.
ClassifiedData data = dao.select_one(param_int("id"));
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<div class="title">Classified</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Domain</td>
		<td>
			<%= data.domain%>
		</td>
	</tr>
	<tr>
		<td>Last URL</td>
		<td>
			<%= data.last_url%>
		</td>
	</tr>
	<tr>
		<td>Character Set</td>
		<td>
			<%= data.charset%>
		</td>
	</tr>
	<tr>
		<td>Title</td>
		<td>
			<%= data.title%>
		</td>
	</tr>
	<tr>
		<td>Description</td>
		<td>
			<%= data.description%>
		</td>
	</tr>
	<tr>
		<td>Text</td>
		<td>
			<%= data.body_text%>
		</td>
	</tr>
	<tr>
		<td>Category</td>
		<td>
			<%= data.category_name%>
		</td>
	</tr>
	<tr>
		<td valign="top">Reason</td>
		<td>
			<%= data.reason.replaceAll("[\n;]", "<br>\n&nbsp;&nbsp;")%>
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">
<!-- /view -->

<%@include file="include/bottom.jsp"%>
