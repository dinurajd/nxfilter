<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(GroupDao dao){
	GroupData data = new GroupData();
	data.id = param_int("id");
	data.policy_id = param_int("policy_id");
	data.ft_policy_id = param_int("ft_policy_id");
	data.description = param_str("description");

	String stime_hh = param_str("stime_hh");
	String stime_mm = param_str("stime_mm");
	String etime_hh = param_str("etime_hh");
	String etime_mm = param_str("etime_mm");

	data.ft_stime = stime_hh + stime_mm;
	data.ft_etime = etime_hh + etime_mm;

	if(dao.update(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void move_user(GroupDao dao){
	if(dao.move_user(param_int("id"), param_str("user_id_line"))){
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
GroupDao dao = new GroupDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}
if(action_flag.equals("move_user")){
	move_user(dao);
}

// Global.
GroupData data = dao.select_one(param_int("id"));

// Get policy list.
List<PolicyData> g_policy_list = new PolicyDao().select_list();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_move_user(form){
	form.action_flag.value = "move_user";
	form.user_id_line.value = listbox_get_all_values("dst_box");
	form.submit();
}

//-----------------------------------------------
function listbox_get_all_values(listID){
	var listbox = document.getElementById(listID);

	var id_line = "";
	for(var i = 0; i < listbox.options.length; i++) {
		if(i > 0){
			id_line += ",";
		}
		id_line += listbox.options[i].value;
	}
	return id_line;
}

//-----------------------------------------------
function listbox_move_across(sourceID, destID){
	var src = document.getElementById(sourceID);
	var dest = document.getElementById(destID);

	for(var count = 0; count < src.options.length; count++){
		if(src.options[count].selected == true){
			var option = src.options[count];

			var newOption = document.createElement("option");
			newOption.value = option.value;
			newOption.text = option.text;
			newOption.selected = true;
			try{
				dest.add(newOption, null); //Standard
				src.remove(count, null);
			}
			catch(error){
				dest.add(newOption); // IE only
				src.remove(count);
			}
			count--;
		}
	}
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">
<input type="hidden" name="id" value="<%= data.id%>">
<input type="hidden" name="user_id_line" value="">

<!--  -->
<div class="title">Group</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Name</td>
		<td>
			<%= data.name%>
		</td>
	</tr>

	<tr>
		<td>Work-time Policy</td>
		<td>
<select name="policy_id">
<%
for(PolicyData pd : g_policy_list){
	if(pd.id == data.policy_id){
		printf("<option value='%s' selected>%s</option>\n", pd.id, pd.name);
	}
	else{
		printf("<option value='%s'>%s</option>\n", pd.id, pd.name);
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
		printf("<option value='%s' selected>%s</option>\n", pd.id, pd.name);
	}
	else{
		printf("<option value='%s'>%s</option>\n", pd.id, pd.name);
	}
}
%>
</select>
		</td>
	</tr>

	<tr>
		<td>Group Specific Free-time</td>
		<td>
		
<%
List<String> hh_list = get_hh_list();
List<String> mm_list = get_mm_list();
%>
<select name="stime_hh">
<%
for(String hh : hh_list){
	if(data.ft_stime.startsWith(hh)){
		printf("<option value='%s' selected>%s", hh, hh);
	}
	else{
		printf("<option value='%s'>%s", hh, hh);
	}
}
%>
</select>

<select name="stime_mm">
<%
for(String mm : mm_list){
	if(data.ft_stime.endsWith(mm)){
		printf("<option value='%s' selected>%s", mm, mm);
	}
	else{
		printf("<option value='%s'>%s", mm, mm);
	}
}
%>
</select>
 ~
<select name="etime_hh">
<%
for(String hh : hh_list){
	if(data.ft_etime.startsWith(hh)){
		printf("<option value='%s' selected>%s", hh, hh);
	}
	else{
		printf("<option value='%s'>%s", hh, hh);
	}
}
%>
</select>

<select name="etime_mm">
<%
for(String mm : mm_list){
	if(data.ft_etime.endsWith(mm)){
		printf("<option value='%s' selected>%s", mm, mm);
	}
	else{
		printf("<option value='%s'>%s", mm, mm);
	}
}
%>
</select>
		
		</td>
	</tr>

	<tr>
		<td>Description</td>
		<td><input type="text" name="description" size="50" value="<%= data.description%>"></td>
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

<%if(!data.is_ldap_group()){%>

<!--  -->
<div class="title">Move user</div>

<!-- user group move -->
<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

<tr>
	<td width="200">
	<div style="margin-bottom:5px;">All User:</div>
<select id="src_box" size="25" multiple style="width: 200px;">
<%
for(GroupUserRelationData rd : data.group_user_relation_list){
	printf("<option value='%s'>%s", rd.user_id, rd.to_str());
}
%>
</select>
	</td>
	
	<td width="50">
<div style="margin-left: 5px; margin-right: 5px; margin-bottom: 5px;">
<input type="button" value="&nbsp;>>&nbsp;" onclick="javascript:listbox_move_across('src_box', 'dst_box')">
</div>
<div style="margin-left: 5px; margin-right: 5px; margin-bottom: 5px;">
<input type="button" value="&nbsp;<<&nbsp;" onclick="javascript:listbox_move_across('dst_box', 'src_box')">
</div>
	</td>
	
	<td>
	<div style="margin-bottom:5px;">Member User:</div>
<select id="dst_box" size="25" multiple style="width: 200px;">
<%
for(UserData ud : data.user_list){
	printf("<option value='%s'>%s", ud.id, ud.name);
}
%>
</select>
	</td>
</tr>

	<tr height="30">
		<td></td>
		<td colspan="2">
<input type="button" value="move user" onclick="javascript:action_move_user(this.form);">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

<%}%>

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
