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
RequestDao dao = new RequestDao();

// Set filtering option.
dao.limit = 100;
dao.page = param_int("page", 1);
dao.stime = param_str("stime");
dao.etime = param_str("etime");

dao.domain = param_str("domain");
dao.user = param_str("user");
dao.grp = param_str("grp");

dao.clt_ip = param_str("clt_ip");
dao.policy = param_str("policy");
dao.category = param_str("category");
dao.block_flag = param_bool("block_flag");

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("csv")){
	String filename = "logging_request.csv";

	// Don't make it too big.
	dao.limit = 100000;
	if(dao.write_csv_file(filename)){
		response.sendRedirect("download.jsp?filename=" + filename + "&content_type=text/csv");
		return;
	}
	else{
		err_list.add("Couldn't write the file!");
	}
}

// Global.
int g_count = dao.select_count();
int g_page = dao.page;
int g_limit = dao.limit;
String g_time_option = param_str("time_option", "2h");
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_csv(){
	var form = document.go_form;
	form.action_flag.value = "csv";
	form.submit();
}

//-----------------------------------------------
function go_page(page){
	var form = document.go_form;
	form.page.value = page;
	form.submit();
}

//-----------------------------------------------
function set_userdef(form){
	form.time_option[0].checked = true;
}

//-----------------------------------------------
function set_period(form){
	var opt = radio_get_value(form.time_option);
	if(opt == "userdef"){
		return;
	}

	var stime = '<%= strftime_add("yyyy/MM/dd HH:mm", -3600 * 2)%>';
	var etime = '<%= strftime("yyyy/MM/dd HH:mm")%>';

	if(opt == "24h"){
		stime = '<%= strftime_add("yyyy/MM/dd HH:mm", -3600 * 24)%>';
	}

	if(opt == "48h"){
		stime = '<%= strftime_add("yyyy/MM/dd HH:mm", -3600 * 48)%>';
	}

	form.stime.value = stime;
	form.etime.value = etime;
	form.stime.disabled = false;
	form.etime.disabled = false;
}

//-----------------------------------------------
function set_period2(form){
	if(!radio_is_checked(form.time_option) || form.time_option[0].checked){
		return;
	}
	set_period(form);
}

//-----------------------------------------------
function clear_search_form(){
	document.search_form.domain.value = "";
	document.search_form.user.value = "";
	document.search_form.clt_ip.value = "";
	document.search_form.grp.value = "";

	document.search_form.policy.value = "";
	document.search_form.category.value = "";
	document.search_form.block_flag.checked = false;
}

//-----------------------------------------------
function search_by_user(user){
	clear_search_form();
	document.search_form.user.value = user;
	document.search_form.submit();
}

//-----------------------------------------------
function search_by_clt_ip(clt_ip){
	clear_search_form();
	document.search_form.clt_ip.value = clt_ip;
	document.search_form.submit();
}

//-----------------------------------------------
function search_by_grp(grp){
	clear_search_form();
	document.search_form.grp.value = grp;
	document.search_form.submit();
}

//-----------------------------------------------
function search_by_policy(policy){
	clear_search_form();
	document.search_form.policy.value = policy;
	document.search_form.submit();
}

//-----------------------------------------------
function search_by_category(category){
	clear_search_form();
	document.search_form.category.value = category;
	document.search_form.submit();
}

//-----------------------------------------------
function set_popup_form(domain){
	document.popup_form.domain.value = domain;
	document.popup_form.id.value = 0;
	document.popup_form.chk_subdomain.checked = false;
	$("#popup_result").empty();
}
</script>

<!-- view -->
<form name="search_form" action="<%= get_page_name()%>" method="get">
<input type="hidden" name="action_flag" value="">
<div class="title">Request</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

	<tr>
		<td width="100" align="right">Time :</td>
		<td colspan="7">
			<input id="stime" type="text" name="stime" value="<%= dao.get_stime()%>" size="12" onchange="javascript:set_userdef(this.form)">
				~ <input id="etime" type="text" name="etime" value="<%= dao.get_etime()%>" size="12" onchange="javascript:set_userdef(this.form)">
			
			<div style="display: none;">
				<input type="radio" class="no_border" name="time_option" value="userdef" onclick="javascript:set_period(this.form)"
					<%if(g_time_option.equals("userdef")){out.print("checked");}%>> User defined
			</div>

			<input type="radio" class="no_border" name="time_option" value="2h" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("2h")){out.print("checked");}%>> Last 2 hours
			<input type="radio" class="no_border" name="time_option" value="24h" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("24h")){out.print("checked");}%>> Last 24 hours
			<input type="radio" class="no_border" name="time_option" value="48h" onclick="javascript:set_period(this.form)"
				<%if(g_time_option.equals("48h")){out.print("checked");}%>> Last 48 hours
		</td>
	</tr>

	<tr>
		<td width="100" align="right">Domain :</td>
		<td width="100"><input type="text" name="domain" value="<%= dao.domain%>" size="25"></td>
		
		<td width="100" align="right">User :</td>
		<td width="100"><input type="text" name="user" value="<%= dao.user%>" size="25"></td>

		<td width="100" align="right">Client IP :</td>
		<td width="100"><input type="text" name="clt_ip" value="<%= dao.clt_ip%>" size="25"></td>
		
		<td width="60"></td>
		<td ></td>
	</tr>

	<tr>
		<td align="right">Group :</td>
		<td><input type="text" name="grp" value="<%= dao.grp%>" size="25"></td>

		<td align="right">Policy :</td>
		<td><input type="text" name="policy" value="<%= dao.policy%>" size="25"></td>

		<td align="right">Category :</td>
		<td><input type="text" name="category" value="<%= dao.category%>" size="25"></td>
		
		<td align="right">Block :</td>
		<td><input type="checkbox" class="no_border" name="block_flag" <%if(dao.block_flag){out.print("checked");}%>></td>
	</tr>

	<tr height="30">
		<td></td>
		<td></td>
		<td></td>
		<td colspan="5">
<input type="button" value="SUBMIT" onclick="javascript:set_period2(this.form);this.form.action_flag.value='';this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
<input type="button" value="CLEAR" onclick="javascript:clear_search_form();">
<input type="button" value="CSV-EXPORT" onclick="javascript:action_csv();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<p>

<!-- list -->
<div class="list">
<table width="100%">
	<tr>
		<td>
			Count : <%= g_count%> / Page : <%= dao.page%>
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="11"></td></tr>
	<tr class="head">
		<td width="90">Time</td>
		<td width="50">Block</td>
		<td width="50" align="center">Count</td>
		<td width="60" align="center">Type</td>
		<td width="250">Domain</td>
		<td width="120">User</td>
		<td width="120">Client IP</td>
		<td width="120">Group</td>
		<td width="120">Policy</td>
		<td width="200">Category</td>
		<td width="">Reason</td>
	</tr>
	<tr class="line"><td colspan="11"></td></tr>
<%
List<RequestData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='11' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	RequestData data = data_list.get(i);

	String category_line = data.category;
	if(category_line.length() > 30){
		category_line = safe_substring(category_line, 30) + "..";
	}

	String grp_line = data.grp.replaceFirst(",.*", "");

	if(i > 0){
		out.println("<tr class='line2'><td colspan='11'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.get_ctime()%></td>
		<td align="center"><%= data.get_block_yn()%></td>
		<td align="right"><%= data.cnt%>&nbsp;&nbsp;</td>
		<td align="center"><%= data.get_type_code()%></td>
		<td><a href="#recat-popup" class="open-popup-link" title="Click for reclassification"
			onclick="javascript:set_popup_form('<%= data.domain%>')"><%= data.domain%></a></td>
		<td><a href="javascript:search_by_user('<%= data.user%>')"><%= data.user%></a></td>
		<td><a href="javascript:search_by_clt_ip('<%= data.clt_ip%>')"><%= data.clt_ip%></a></td>
		<td title="<%= data.grp%>"><a href="javascript:search_by_grp('<%= data.get_first_grp()%>')"><%= grp_line%></a></td>
		<td><a href="javascript:search_by_policy('<%= data.policy%>')"><%= data.policy%></a></td>
		<td title='<%= data.category%>'><%= category_line%></td>
		<td><%= data.get_reason()%></td>
	</tr>
<%}%>

	<tr class="line"><td colspan="11"></td></tr>
</table>

<table border="0" width="100%">
	<tr>
		<td align="center"><%= get_pagination(g_count, g_limit, g_page)%></td>
	</tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="page" value="<%= g_page%>">
<input type="hidden" name="time_option" value="<%= g_time_option%>">
<input type="hidden" name="stime" value="<%= dao.stime%>">
<input type="hidden" name="etime" value="<%= dao.etime%>">
<input type="hidden" name="domain" value="<%= dao.domain%>">
<input type="hidden" name="user" value="<%= dao.user%>">
<input type="hidden" name="grp" value="<%= dao.grp%>">
<input type="hidden" name="clt_ip" value="<%= dao.clt_ip%>">
<input type="hidden" name="policy" value="<%= dao.policy%>">
<input type="hidden" name="category" value="<%= dao.category%>">
<input type="hidden" name="block_flag" value="<%= dao.block_flag%>">
</form>
<!-- /go_form -->

<!-- popup_form -->
<div id="recat-popup" class="xrecat-popup mfp-hide">
	Add domain into a new category.
	</p>

	<form id="popup_form" name="popup_form" method="post" action="category,system_edit.jsp">
	<input type="hidden" name="action_flag" value="add_domain">
	<table width="100%" cellpadding="2">

		<tr>
			<td>
			<input id="popup_form_domain" type="text" name="domain" size="50"/><br>
			</td>
		</tr>

		<tr>
			<td>
			<select name="id">
			<option value="0"> Select a category to move in
<%
List<CategoryData> cat_list = new CategorySystemDao().select_list();
for(CategoryData data : cat_list){
	printf("<option value='%s'> %s", data.id, data.name);
}
%>
			</select>
			</td>
		</tr>

		<tr>
			<td>
			Include subdomains <input id="popup_form_chk_subdomain" name="chk_subdomain" type="checkbox"/><br>
			</td>
		</tr>

		<tr>
			<td>
				<input type="submit" value="SUBMIT">
				<input type="button" value="CLOSE" onclick="javascript:$.magnificPopup.close();">
			</td>
		</tr>

	</table>

	</p>
	<div id="popup_result" class="succ_msg"></div>
</div>
<!-- /popup_form -->

<%@include file="include/bottom.jsp"%>

<!-- Datetime picker -->
<script type="text/javascript">
//-----------------------------------------------
var dateToDisable = new Date();

//-----------------------------------------------
jQuery("#stime").datetimepicker({
	format: "Y/m/d H:i",
	step: 1,
	beforeShowDay: function(date) {
		if (date.getMonth() > dateToDisable.getMonth()) {
			return [false, ""]
		}

		return [true, ""];
	}
});

//-----------------------------------------------
jQuery("#etime").datetimepicker({
	format: "Y/m/d H:i",
	step: 1,
	beforeShowDay: function(date) {
		if (date.getMonth() > dateToDisable.getMonth()) {
			return [false, ""]
		}

		return [true, ""];
	}
});

//-----------------------------------------------
$(".open-popup-link").magnificPopup({
	type:"inline",
	midClick: true
});

//-----------------------------------------------
$("#popup_form").submit(function(event){
	event.preventDefault();
 
	// Get form values.
	var form = $(this);
	var url = form.attr("action");

	var data = {};
	form.find("[name]").each(function(i , v){
		var input = $(this),
		name = input.attr("name"),
		value = input.val();
		data[name] = value;
	});

	if(data["id"] == 0){
		return;
	}

	$.post(url, data);
	$("#popup_result").empty().append("Submitted.");
});

//-----------------------------------------------
var prev_domain = "";
$("#popup_form_chk_subdomain").change(function(){
	if($(this).is(":checked")){
		var domain = $("#popup_form_domain").val();
		if(domain.indexOf("*.") != 0){
			prev_domain = domain;
		}

		domain = domain.replace(/^www\./, "");
		domain = "*." + domain;

		$("#popup_form_domain").val(domain);
		return;
	}
	$("#popup_form_domain").val(prev_domain);
});
</script>
