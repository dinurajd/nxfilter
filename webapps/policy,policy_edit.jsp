<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(PolicyDao dao){
	PolicyData data = new PolicyData();

	data.id = param_int("id");
	data.points = param_int("points");
	data.description = param_str("description");
	data.enable_filter = param_bool("enable_filter");

	data.block_all = param_bool("block_all");
	data.block_unclass = param_bool("block_unclass");
	data.ad_remove = param_bool("ad_remove");
	data.max_domain_len = param_int("max_domain_len");

	data.block_covert_chan = param_bool("block_covert_chan");
	data.block_mailer_worm = param_bool("block_mailer_worm");
	data.block_dns_rebinding = param_bool("block_dns_rebinding");

	data.a_record_only = param_bool("a_record_only");
	data.quota = param_int("quota");
	data.quota_all = param_bool("quota_all");
	data.bwdt_limit = param_long("bwdt_limit");

	data.safe_search = param_bool("safe_search");
	data.disable_application_control = param_bool("disable_application_control");
	data.disable_proxy = param_bool("disable_proxy");
	data.log_only = param_bool("log_only");

	data.block_category_arr = param_arr("block_category_arr");
	data.quota_category_arr = param_arr("quota_category_arr");

	String stime_hh = param_str("stime_hh");
	String stime_mm = param_str("stime_mm");
	String etime_hh = param_str("etime_hh");
	String etime_mm = param_str("etime_mm");

	data.bt_stime = stime_hh + stime_mm;
	data.bt_etime = etime_hh + etime_mm;

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
PolicyDao dao = new PolicyDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// Global.
PolicyData data = dao.select_one(param_int("id"));
%>
<%@include file="include/action_info.jsp"%>

<!-- view -->
<form action="<%= get_page_name()%>" method="post" name="policy_form">
<input type="hidden" name="action_flag" value="update">
<input type="hidden" name="id" value="<%= data.id%>">

<!--  -->
<div class="title">Policy</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Name</td>
		<td><%= data.name%></td>
	</tr>

	<tr>
		<td>Priority Points</td>
		<td>
		<div style="margin-bottom:5px;">When a user has multiple policies the policy having highest points will be applied.</div>
			<input type="text" name="points" value="<%= data.points%>" size="3"> 0 ~ 1000
		</td>
	</tr>

	<tr>
		<td>Description</td>
		<td>
		<input type="text" name="description" value="<%= data.description%>" size="50">
		</td>
	</tr>

	<tr>
		<td>Enable Filter</td>
		<td><input type="checkbox" class="no_border" name="enable_filter"
			<%if(data.enable_filter){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Block All</td>
		<td><input type="checkbox" class="no_border" name="block_all" <%if(data.block_all){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Block Unclassified</td>
		<td><input type="checkbox" class="no_border" name="block_unclass" <%if(data.block_unclass){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Ad-remove</td>
		<td>
		<input type="checkbox" name="ad_remove" <%if(data.ad_remove){out.print("checked");}%>>
		Block adware with blank-page.
		</td>
	</tr>

	<tr>
		<td>Max Domain Length</td>
		<td>
		NxFilter doesn't apply 'Max domain length' against 30,000 most well known domains.<br>
		<input type="text" name="max_domain_len" value="<%= data.max_domain_len%>" size="3">
		0 ~ 1000, 0 = bypass
		</td>
	</tr>

	<tr>
		<td>Block Covert Channel</td>
		<td>
		<input type="checkbox" name="block_covert_chan" <%if(data.block_covert_chan){out.print("checked");}%>>
		Detecting hidden communication.
		</td>
	</tr>

	<tr>
		<td>Block Mailer Worm</td>
		<td>
		<input type="checkbox" name="block_mailer_worm" <%if(data.block_mailer_worm){out.print("checked");}%>>
		MX record will be blocked.
		</td>
	</tr>

	<tr>
		<td>Block DNS Rebinding</td>
		<td>
		<input type="checkbox" name="block_dns_rebinding" <%if(data.block_dns_rebinding){out.print("checked");}%>>
		DNS response with private IP will be blocked.
		</td>
	</tr>

	<tr>
		<td>Allow 'A' Record Only</td>
		<td>
		<input type="checkbox" name="a_record_only" <%if(data.a_record_only){out.print("checked");}%>>
		Block all except A, AAAA, PTR, CNAME records.
		</td>
	</tr>

	<tr>
		<td>Quota</td>
		<td>
		<div style="line-height:20px;">
		You can allow users to use 'Quotaed Categories' for specific amount of time.<br>
		When there's no remaining quota for a user 'Quotaed Categories' will be working in the same way as 'Blocked Categories'.
		</div>
			<input type="text" name="quota" value="<%= data.quota%>" size="3"> 0 ~ 1440 minutes
		</td>
	</tr>

	<tr>
		<td>Quota All</td>
		<td>
		<input type="checkbox" class="no_border" name="quota_all" <%if(data.quota_all){out.print("checked");}%>>
		Quota will be applied for all domains including unclassified domains.
		</td>
	</tr>

	<tr>
		<td>Bandwidth Limit</td>
		<td>
		<div style="margin-bottom:5px;">You need to run netflow collector to use bandwidth control.</div>
			<input type="text" name="bwdt_limit" value="<%= data.bwdt_limit%>" size="3"> MB, 0 = bypass
		</td>
	</tr>

	<tr>
		<td>Safe-search</td>
		<td><input type="checkbox" class="no_border" name="safe_search" <%if(data.safe_search){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Block-time</td>
		<td>
		
<%
List<String> hh_list = get_hh_list();
List<String> mm_list = get_mm_list();
%>
<select name="stime_hh">
<%
for(String hh : hh_list){
	if(data.bt_stime.startsWith(hh)){
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
	if(data.bt_stime.endsWith(mm)){
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
	if(data.bt_etime.startsWith(hh)){
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
	if(data.bt_etime.endsWith(mm)){
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
		<td>Disable Application Control</td>
		<td><input type="checkbox" class="no_border" name="disable_application_control" <%if(data.disable_application_control){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Disable Proxy Filtering</td>
		<td><input type="checkbox" class="no_border" name="disable_proxy" <%if(data.disable_proxy){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Logging Only</td>
		<td><input type="checkbox" class="no_border" name="log_only" <%if(data.log_only){out.print("checked");}%>></td>
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

<!--  -->
<div class="title">Blocked Categories</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
<input type="button" value="TOGGLE-ALL" onclick="javascript:checkbox_toggle_all3('block_category_arr');">
	<br>

<%
for(int i = 0; i < data.block_category_list.size(); i++){
	CategoryData cd = data.block_category_list.get(i);

	String chk = "";
	if(cd.check_flag){
		chk = "checked";	
	}

	if(i > 0 && i % 6 == 0){
		out.println("<br>");
	}
%>
	<span class="category_item">
<input type="checkbox" class="no_border"
	name="block_category_arr" value="<%= cd.id%>" <%= chk%>><%= cd.name%>
	</span>
<%}%>

		</td>
	</tr>

	<tr height="30">
		<td align="center">
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

<!--  -->
<div class="title">Quotaed Categories</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
<input type="button" value="TOGGLE-ALL" onclick="javascript:checkbox_toggle_all3('quota_category_arr');">
	<br>

<%
for(int i = 0; i < data.quota_category_list.size(); i++){
	CategoryData cd = data.quota_category_list.get(i);

	String chk = "";
	if(cd.check_flag){
		chk = "checked";	
	}

	if(i > 0 && i % 6 == 0){
		out.println("<br>");
	}
%>
	<span class="category_item">
		<input type="checkbox" class="no_border" name="quota_category_arr" value="<%= cd.id%>" <%= chk%>><%= cd.name%>
	</span>
<%}%>

		</td>
	</tr>

	<tr height="30">
		<td align="center">
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
