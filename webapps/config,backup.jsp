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
ConfigDao dao = new ConfigDao();

// Action.
String action_flag = param_str("action_flag");
if(!demo_flag && action_flag.equals("backup")){
	String filename = dao.backup();
	if(is_not_empty(filename)){
		response.sendRedirect("download.jsp?filename=" + filename);
		return;
	}
}
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="backup">

<div class="title">Backup</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
By clicking the button below, you will be downloading a zip file containig the backup for your configuration. When you restore your configuration<br>
from the backup file stop NxFilter and copy and overwrite 'config.h2.db' from the archive into '/nxfilter/db' directory.
		</td>
	</tr>

	<tr height="30">
		<td>&nbsp;&nbsp;<input type="button" value="Make a backup for current configuration"
			onclick="javascript:this.form.submit()"></td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
