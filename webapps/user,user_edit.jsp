<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
boolean chk_param(UserData data){
	// Check password only if there's a password updated.
	if (!is_empty(data.passwd) && !is_sha1hex(data.passwd)) {
		if (!ParamTest.is_valid_passwd_len(data.passwd)) {
			err_list.add(ParamTest.ERR_PASSWD_LEN);
			return false;
		}

		if (!ParamTest.is_valid_passwd_char(data.passwd)) {
			err_list.add(ParamTest.ERR_PASSWD_CHAR);
			return false;
		}
	}

	// token.
	if (!is_empty(data.token) && !ParamTest.is_valid_token(data.token)) {
		err_list.add(ParamTest.ERR_TOKEN_INVALID);
		return false;
	}

	return true;
}

//-----------------------------------------------
void update(UserDao dao){
	UserData data = new UserData();
	data.id = param_int("id");
	data.passwd = param_str("passwd");
	data.policy_id = param_int("policy_id");
	data.ft_policy_id = param_int("ft_policy_id");
	data.exp_date = param_str("exp_date");
	data.token = param_str("token");
	data.description = param_str("description");

	// Validate and update it.
	if(chk_param(data) && dao.update(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void new_token(UserDao dao){
	UserData data = new UserData();
	data.id = param_int("id");
	data.token = param_str("token");

	if(dao.new_token(data.id)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void add_ip(UserDao dao){
	UserIpData data = new UserIpData();
	data.user_id = param_int("id");
	data.start_ip = param_str("start_ip");
	data.end_ip = param_str("end_ip");

	// Param validation.
	if (!is_valid_ip(data.start_ip)) {
		err_list.add("Invalid start IP!");
		return;
	}

	if (is_not_empty(data.end_ip) && !is_valid_ip(data.end_ip)) {
		err_list.add("Invalid end IP!");
		return;
	}

	if(dao.add_ip(data)){
		succ_list.add("Data updated!");

		if(!new ConfigDao().select_one().enable_login){
			succ_list.add("Authentication needs to be enabled!");
		}
	}
}

//-----------------------------------------------
void delete_ip(UserDao dao){
	if(dao.delete_ip(param_int("ip_id"))){
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
UserDao dao = new UserDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}
if(action_flag.equals("new_token")){
	new_token(dao);
}
if(action_flag.equals("add_ip")){
	add_ip(dao);
}
if(action_flag.equals("delete_ip")){
	delete_ip(dao);
}

// Global.
UserData data = dao.select_one(param_int("id"));

// Get policy list.
List<PolicyData> g_policy_list = new PolicyDao().select_list();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_new_token(form){
	form.action_flag.value = "new_token";
	form.submit();
}

//-----------------------------------------------
function action_update(form){
	form.action_flag.value = "update";
	form.submit();
}

//-----------------------------------------------
function action_add_ip(form){
	form.action_flag.value = "add_ip";
	form.submit();
}

//-----------------------------------------------
function action_delete_ip(ip_id){
	form = document.all("user_edit_form");
	form.action_flag.value = "delete_ip";
	form.ip_id.value = ip_id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post" name="user_edit_form">
<input type="hidden" name="action_flag" value="EDIT">
<input type="hidden" name="id" value="<%= data.id%>">
<input type="hidden" name="ip_id" value="">

<!--  -->
<div class="title">User</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Name</td>
		<td>
			<%= data.name%>
		</td>
	</tr>

	<tr>
		<td>Password</td>
		<td><input type="password" name="passwd" size="25" maxlength="12" value="<%= data.passwd%>"></td>
	</tr>

	<tr>
		<td>Work-time Policy</td>
		<td>
<select name="policy_id">
<%
for(PolicyData pd : g_policy_list){
	if(pd.id == data.policy_id){
		printf("<option value='%s' selected>%s\n", pd.id, pd.name);
	}
	else{
		printf("<option value='%s'>%s\n", pd.id, pd.name);
	}
}
%>
</select>
		</td>
	</tr>

	<tr>
		<td>Free-time Policy</td>
		<td>
<select name="ft_policy_id">
	<option value="0">Same as work-time policy
<%
for(PolicyData pd : g_policy_list){
	if(pd.id == data.ft_policy_id){
		printf("<option value='%s' selected>%s\n", pd.id, pd.name);
	}
	else{
		printf("<option value='%s'>%s\n", pd.id, pd.name);
	}
}
%>
</select>
		</td>
	</tr>

	<tr>
		<td>Expiration Date</td>
		<td>
		<input id="exp_date" type="text" name="exp_date" value="<%= data.get_exp_date()%>" size="12">
		<input type="button" value="CLEAR" onclick="javascript:this.form.exp_date.value='';">
		</td>
	</tr>

	<tr>
		<td>Login Token</td>
		<td>
		<input type="text" name="token" size="8" maxlength="8" value="<%= data.token%>">
		<input type="button" value="NEW-TOKEN" onclick="javascript:action_new_token(this.form)">
		</td>
	</tr>

	<tr>
		<td>Group, Member of</td>
		<td><%= data.get_group_line()%></td>
	</tr>

	<tr>
		<td>Description</td>
		<td><input type="text" name="description" size="50" value="<%= data.description%>"></td>
	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:action_update(this.form);">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

<!--  -->
<div class="title">Add IP</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
<div style="line-height:20px;">
You can associate a user to an IP address or an IP address range. A user having an associated<br>
IP address will be authenticated based on IP address. If it is a single IP association, add 'Start IP' only.
</div>
		</td>
	</tr>

	<tr>
		<td colspan="2">
		</td>
	</tr>

	<tr>
		<td width="100">Start IP</td>
		<td>
		<input type="text" name="start_ip" size="25">
		<input type="button" value="ADD" onclick="javascript:action_add_ip(this.form)">
		</td>
	</tr>
	<tr>
		<td>End IP</td>
		<td>
		<input type="text" name="end_ip" size="25">
		</td>
	</tr>

	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<tr>
		<td colspan="2">
<%
for(int i = 0; i < data.ip_list.size(); i++){
	UserIpData uip = data.ip_list.get(i);

	if(i > 0 && i % 4 == 0){
		out.print("<br>");
	}

	printf("<span class='domain_item'><a href='javascript:action_delete_ip(%s)'>[x]</a> %s</span>", uip.id, uip.to_str());
}
%>
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>

<!-- Datetime picker -->
<script type="text/javascript">
//-----------------------------------------------
var dateToDisable = new Date();

//-----------------------------------------------
jQuery("#exp_date").datetimepicker({
	format: "Y/m/d H:i",
	step: 1,
	beforeShowDay: function(date) {
		if (date.getMonth() > dateToDisable.getMonth()) {
			return [false, ""]
		}

		return [true, ""];
	}
});
</script>
