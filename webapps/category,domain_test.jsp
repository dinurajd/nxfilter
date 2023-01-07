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
DomainTestDao dao = new DomainTestDao();

// Global.
DomainTestData data = dao.test(param_str("domain"));
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">

<div class="title">Domain Test</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
		Finding categories for a domain.
		</td>
	</tr>
	<tr>
		<td width="200">Domain</td>
		<td>
			<input type="text" name="domain" size="25" value="<%= data.domain%>">
		</td>
	</tr>
<%if(data.category.length() > 0){%>
	<tr>
		<td>Category</td>
		<td><%= data.category%></td>
	</tr>
<%}%>

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

<%@include file="include/bottom.jsp"%>
