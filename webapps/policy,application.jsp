<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(PolicyApplicationDao dao){
	PolicyApplicationData data = new PolicyApplicationData();
	data.enable_control = param_bool("enable_control");
	data.execution_interval = param_int("execution_interval");
	data.block_ultrasurf = param_bool("block_ultrasurf");
	data.block_tor = param_bool("block_tor");
	data.pname = param_str("pname");
	data.exclude = param_str("exclude");

	// Param validation.
	String kw = dao.find_invalid_kw(data.pname);
	if (is_not_empty(kw)) {
		err_list.add("Invalid keyword for blocked process name, minimum length = 4! - " + kw);
		return;
	}

	if(dao.update(data)){
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
PolicyApplicationDao dao = new PolicyApplicationDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
PolicyApplicationData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<div class="title">Application Control</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	</tr>

	<tr>
		<td width="200">Enable Control</td>
		<td>
		<input type="checkbox" class="no_border" name="enable_control"
			<%if(data.enable_control){out.print("checked");}%>>
			Application control requires NxLogon or NxClient running on client PC.
			</td>
	</tr>

	<tr>
		<td>Execution Interval</td>
		<td><input type="text" name="execution_interval" size="4" maxlength="4"
			value="<%= data.execution_interval%>"> seconds, 15 ~ 300</td>
	</tr>

	<tr>
		<td>Block UltraSurf</td>
		<td><input type="checkbox" class="no_border" name="block_ultrasurf"
			<%if(data.block_ultrasurf){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Block Tor</td>
		<td><input type="checkbox" class="no_border" name="block_tor"
			<%if(data.block_tor){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Blocked Process Name</td>
		<td>
			NxFilter tries to find and kill processes based on keyword matching against<br>
			process name. You can add keywords separated by spaces. For exact matching use square brackets.<br>
			&nbsp;&nbsp;ex) Skype [uTorrent.exe] Dropbox<br>
			<textarea name="pname" cols="80" rows="6" class="my_textarea"><%= data.pname%></textarea>
		</td>
	</tr>

	<tr>
		<td>Excluded Keywords</td>
		<td>
			When you try to kill a program based on its process name you might have some<br>
			false positives. You can bypass these programs with the keywords here<br>
			&nbsp;&nbsp;ex) explorer firefox<br>
			<textarea name="exclude" cols="80" rows="6" class="my_textarea"><%= data.exclude%></textarea>
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

<%@include file="include/bottom.jsp"%>
