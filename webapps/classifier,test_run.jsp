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
ClassifierTestDao dao = new ClassifierTestDao();

// Global.
ClassifiedData data = dao.test(param_str("domain"));
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">

<div class="title">Test Run</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
		Test run for NxClassifier and its ruleset.
		</td>
	</tr>
	<tr>
		<td width="200">Domain</td>
		<td>
			<input type="text" name="domain" size="25" value="<%= data.domain%>">
			<input type="button" value="TEST" onclick="javascript:this.form.submit();">
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

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
