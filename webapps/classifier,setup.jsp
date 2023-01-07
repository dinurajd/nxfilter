<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(ClassifierSetupDao dao){
	ClassifierSetupData data = new ClassifierSetupData();

	data.dns_test_timeout = param_int("dns_test_timeout");
	data.http_conn_timeout = param_int("http_conn_timeout");
	data.http_read_timeout = param_int("http_read_timeout");
	data.classified_retention_days = param_int("classified_retention_days");
	data.keep_html_text = param_bool("keep_html_text");
	data.disable_domain_pattern_dic = param_bool("disable_domain_pattern_dic");
	data.disable_classification = param_bool("disable_classification");

	data.repository_url = param_str("repository_url");
	data.enable_auto_update = param_bool("enable_auto_update");

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
ClassifierSetupDao dao = new ClassifierSetupDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}

// If it's about importation.
int import_count = param_int("import_count");
if(import_count > 0){
	if(action_flag.equals("ruleset")){
		succ_list.add(import_count + " classification rules imported.");
	}
	else{
		succ_list.add(import_count + " domains imported.");
	}
}

// Global.
ClassifierSetupData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!--  -->
<div class="title">Classifier Setup</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="210">DNS Test Timeout</td>
		<td><input type="text" name="dns_test_timeout" value="<%= data.dns_test_timeout%>" size="2" maxlength="2"></td>
	</tr>

	<tr>
		<td>HTTP Connection Timeout</td>
		<td><input type="text" name="http_conn_timeout" value="<%= data.http_conn_timeout%>" size="2" maxlength="2"></td>
	</tr>

	<tr>
		<td>HTTP Read Timeout</td>
		<td><input type="text" name="http_read_timeout" value="<%= data.http_read_timeout%>" size="2"></td>
	</tr>

	<tr>
		<td>Classified Log Retention Days</td>
		<td><input type="text" name="classified_retention_days" value="<%= data.classified_retention_days%>" size="2"></td>
	</tr>

	<tr>
		<td>Keep HTML Text</td>
		<td><input type="checkbox" class="no_border"
			name="keep_html_text" <%if(data.keep_html_text){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Disable Domain Pattern Dictionary</td>
		<td><input type="checkbox" class="no_border"
			name="disable_domain_pattern_dic" <%if(data.disable_domain_pattern_dic){out.print("checked");}%>></td>
	</tr>

	<tr>
		<td>Disable Classification</td>
		<td><input type="checkbox" class="no_border"
			name="disable_classification" <%if(data.disable_classification){out.print("checked");}%>></td>
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
<div class="title">Jahaslist Repository</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Repository URL</td>
		<td>
			You can add multiple URLs separated by newlines.<br>
			<textarea name="repository_url" cols="80" rows="4" class="my_textarea"><%= data.repository_url%></textarea>
		</td>
	</tr>

	<tr>
		<td>Enable Auto Update</td>
		<td><input type="checkbox" class="no_border"
			name="enable_auto_update" <%if(data.enable_auto_update){out.print("checked");}%>></td>
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

<!--  -->
<form action="import.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="action_flag" value="ruleset">
<input type="hidden" name="origin_page" value="<%= get_page_name()%>">

<div class="title">Mass Import</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
		You can import classification ruleset or Jahaslist data from the files exported from the other NxFilter installations.<br>
		When you import data from a file and there is a conflict with an existing data it overwrites the existing data.
		</td>
	</tr>

	<tr>
		<td width="200"></td>
		<td>
<div class="div_upload">
<button class="button_upload">Select a file...</button>
<input type="file" name="file1">
</div>
<input type="button" value="REPLACE RULESET" onclick="javascript:this.form.submit();">
<input type="button" value="IMPORT JAHASLIST" onclick="this.form.action_flag.value='jahaslist';javascript:this.form.submit();">
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">

</form>

<%@include file="include/bottom.jsp"%>
