<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(WhitelistKeywordDao dao){
	WhitelistData data = new WhitelistData();
	data.id = param_int("id");
	data.bypass_auth = param_bool("bypass_auth");
	data.bypass_filter = param_bool("bypass_filter");
	data.bypass_log = param_bool("bypass_log");
	data.admin_block = param_bool("admin_block");
	data.applied_policy_arr = param_arr("applied_policy_arr");

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
WhitelistKeywordDao dao = new WhitelistKeywordDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
WhitelistData data = dao.select_one(param_int("id"));

// Get policy list.
List<PolicyData> g_policy_list = new PolicyDao().select_list();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_update(form){
	form.action_flag.value = "update";
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="id" value="<%= data.id%>">

<!--  -->
<div class="title">Whitelist by Keyword</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Keyword</td>
		<td><%= data.keyword%></td>
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
		<td>Admin Block</td>
		<td>
			<input type="checkbox" class="no_border" name="admin_block" <%if(data.admin_block){out.print("checked");}%>>
		</td>
	</tr>

	<tr>
		<td valign="top">Applied Policy</td>
		<td>
If there's no applied policy it becomes a global whitelist.
<br>

<%
for(PolicyData pd : g_policy_list){
%>
<input type="checkbox" class="no_border"
	name="applied_policy_arr" value="<%= pd.id%>" <%if(data.is_applied_policy(pd.id)){out.print("checked");}%>><%= pd.name%>
<br>
<%}%>
		</td>
	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:action_update(this.form)">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
