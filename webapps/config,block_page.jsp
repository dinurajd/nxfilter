<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(BlockPageDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	BlockPageData data = new BlockPageData();

	// We use request_str here to preserve all the special characters.
	data.block_page = request_str("block_page");
	data.login_page = request_str("login_page");
	data.welcome_page = request_str("welcome_page");

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
BlockPageDao dao = new BlockPageDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}
if(action_flag.equals("restore")){
	if(dao.restore_default()){
		succ_list.add("Data updated!");
	}
}

// Global.
BlockPageData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function preview(text){
	var w = window.open("", "preview_window", "width=1024,height=600");
	w.document.open();
	w.document.write(text);
	w.document.close();
}

//-----------------------------------------------
function restore_default(form){
	form.action_flag.value = "restore";
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<div class="title">Block Page</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td colspan="2">
<div style="line-height:20px;">
You can edit your block-page, login-page, welcome-page here.<br>
When you edit these pages do not touch the template variable between '\#{' and '}'.<br>
&nbsp;&nbsp;ex) \#{domain}, \#{reason}
</div>
		</td>
	</tr>

	<tr>
		<td colspan="2">
&nbsp;
		</td>
	</tr>

	<tr>
		<td width="200">Block Page</td>
		<td>
			<textarea name="block_page" cols="80" rows="8" class="my_textarea"><%= escape_html(data.block_page)%></textarea>
			<input type="button" value="PREVIEW" onclick="javascript:preview(this.form.block_page.value);">
		</td>
	</tr>

	<tr>
		<td colspan="2">
		</td>
	</tr>

	<tr>
		<td>Login Page</td>
		<td>
			<textarea name="login_page" cols="80" rows="8" class="my_textarea"><%= escape_html(data.login_page)%></textarea>
			<input type="button" value="PREVIEW" onclick="javascript:preview(this.form.login_page.value);">
		</td>
	</tr>

	<tr>
		<td colspan="2">
		</td>
	</tr>

	<tr>
		<td>Welcome Page</td>
		<td>
			<textarea name="welcome_page" cols="80" rows="8" class="my_textarea"><%= escape_html(data.welcome_page)%></textarea>
			<input type="button" value="PREVIEW" onclick="javascript:preview(this.form.welcome_page.value);">
		</td>
	</tr>

	<tr height="30">
		<td></td>
		<td>
<input type="button" value="SUBMIT" onclick="javascript:this.form.submit();">
<input type="button" value="RESET" onclick="javascript:this.form.reset();">
<input type="button" value="RESTORE-DEFAULT" onclick="javascript:restore_default(this.form);">
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
