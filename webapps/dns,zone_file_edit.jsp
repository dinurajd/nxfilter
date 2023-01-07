<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(ZoneFileDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	ZoneFileData data = new ZoneFileData();
	data.id = param_int("id");
	data.zone = param_str("zone");
	data.bypass_auth = param_bool("bypass_auth");
	data.bypass_filter = param_bool("bypass_filter");
	data.bypass_log = param_bool("bypass_log");
	data.description = param_str("description");

	try{
		dao.test_zone(data);
	}
	catch(Exception e){
		err_list.add(e.toString());
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
ZoneFileDao dao = new ZoneFileDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
ZoneFileData data = dao.select_one(param_int("id"));
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">
<input type="hidden" name="id" value="<%= data.id%>">

<!--  -->
<div class="title">Zone File</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Domain</td>
		<td>
			<%= data.domain%>
		</td>
	</tr>

	<tr>
		<td>Bypass Authentication</td>
		<td>
			<input type="checkbox" class="no_border" name="bypass_auth" <%if(data.bypass_auth){out.print("checked");}%>>
		</td>
	</tr>

	<tr>
		<td>Bypass Filtering</td>
		<td>
			<input type="checkbox" class="no_border" name="bypass_filter" <%if(data.bypass_filter){out.print("checked");}%>>
		</td>
	</tr>

	<tr>
		<td>Bypass Logging</td>
		<td>
			<input type="checkbox" class="no_border" name="bypass_log" <%if(data.bypass_log){out.print("checked");}%>>
		</td>
	</tr>

	<tr>
		<td>Description</td>
		<td><input type="text" name="description" size="50" value="<%= data.description%>"></td>
	</tr>

	<tr>
		<td>Zone</td>
		<td>
			<textarea name="zone" cols="80" rows="30" class="my_textarea"><%= data.zone%></textarea>
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
