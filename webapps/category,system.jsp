<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void delete(CategorySystemDao dao){
	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete_all(CategorySystemDao dao){
	if(dao.delete_all()){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void update(CategorySystemDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	// License update.
	String license_key = param_str("license_key");
	if(is_not_empty(license_key)){
		LicenseDao lic_dao = new LicenseDao();

		if(!lic_dao.is_valid_license_key(license_key)){
			err_list.add("Invalid license key!");
			return;
		}
		
		if(lic_dao.is_expired_license_key(license_key)){
			err_list.add("Expired license key!");
			return;
		}

		if(new LicenseDao().update_license_key(license_key)){
			succ_list.add("Data updated.");
			succ_list.add("Restarting needed to apply the change.");
		}
		else{
			err_list.add("Invalid license key!");
		}
		return;
	}

	// Change blacklist type.
	int blacklist_type = param_int("blacklist_type");
	if(blacklist_type == 4 && !dao.has_komodia_license()){
		err_list.add("Cloudlist license required!");
		return;
	}

	if(dao.update_blacklist_type(blacklist_type)){
        succ_list.add("Data updated.");
        succ_list.add("Restarting needed to apply the change.");
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
CategorySystemDao dao = new CategorySystemDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}
if(action_flag.equals("delete")){
	delete(dao);
}
if(action_flag.equals("delete_all")){
	delete_all(dao);
}

// Global.
int g_count = dao.select_count();

// 1 = Shallalist, 4 = Cloudlist.
int g_blacklist_type = dao.get_blacklist_type();
String g_license_end_date = dao.get_license_end_date();
int g_license_max_user = dao.get_license_max_user();

// Check if it's imported.
if(g_blacklist_type < 3 && !dao.is_blacklist_imported()
	&& succ_list.size() == 0 && err_list.size() == 0){

	err_list.add("No blacklist imported yet!");
}
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, name){
	if(!confirm("Deleting custom classified domains from " + name)){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function action_delete_all(){
	if(!confirm("Deleting all the custom classified domains.")){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete_all";
	form.submit();
}

//-----------------------------------------------
function go_edit(id){
	var form = document.go_form;
	form.action = "category,system_edit.jsp";
	form.id.value = id;
	form.submit();
}
</script>

<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!-- view -->
<div class="title">System Category</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
<div style="line-height: 20px">
NxFilter supports several blacklists. To find out more about these blacklist options and how to import them read our online tutorial.
</div>
		</td>
	</tr>

	<tr>
		<td width="200">Blacklist Type</td>
		<td>
			<input type="radio" class="no_border" name="blacklist_type" value="5" <%if(g_blacklist_type == 5){out.print("checked");}%>>
			Jahaslist - Auto-classification with NxClassifier.
			<%if(g_blacklist_type == 5){%>
				<div class="tab">
				- End date = <%= g_license_end_date%>
				<br>
				- Max user = <%= g_license_max_user%>
				</div>
			<%}%>
		</td>
	</tr>

	<tr>
		<td></td>
		<td>
			<input type="radio" class="no_border" name="blacklist_type" value="4" <%if(g_blacklist_type == 4){out.print("checked");}%>>
			Cloudlist - Cloud based blacklist service.
			<%if(g_blacklist_type == 4){%>
				<div class="tab">
				- End date = <%= g_license_end_date%>
				<br>
				- Max user = <%= g_license_max_user%>
				</div>
			<%}%>
		</td>
	</tr>

	<tr>
		<td></td>
		<td>
			<input type="radio" class="no_border" name="blacklist_type" value="1" <%if(g_blacklist_type == 1){out.print("checked");}%>>
			Shallalist - Free for non-commercial use only.
		</td>
	</tr>

	<tr>
		<td>License Key</td>
		<td>
			<input type="text" name="license_key" size="50">
		</td>
	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
<input type="button" value="DEL-DOMAIN-ALL" onclick="javascript:action_delete_all();">
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
			Count : <%= g_count%>
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="3"></td></tr>

<%
List<CategoryData> data_list = dao.select_list();
for(int i = 0; i < data_list.size(); i++){
	CategoryData data = data_list.get(i);

	String name = data.name;
	int domain_cnt = data.get_domain_count();
	if(domain_cnt > 0){
		name = name + " - " + domain_cnt;
	}

	if(i > 0){
		out.println("<tr class='line2'><td colspan='3'></td></tr>");
	}
%>
	<tr class="row">
		<td width="200"><%= name%></td>
		<td><%= data.description%></td>

		<td width="200" align="right">
		<input type="button" value="ADD-DOMAIN" onclick="javascript:go_edit(<%= data.id%>)">
		<input type="button" value="DEL-DOMAIN" onclick="javascript:action_delete(<%= data.id%>, '<%= data.name%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="3"></td></tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="id" value="">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
