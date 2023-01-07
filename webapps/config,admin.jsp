<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update_name(AdminDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	AdminData data = new AdminData();
	data.name = param_str("admin_name");

	// Param validation.
	if(!ParamTest.is_valid_name_len(data.name)){
		err_list.add(ParamTest.ERR_NAME_LEN);
		return;
	}
	
	if(!ParamTest.is_valid_name_char(data.name)){
		err_list.add(ParamTest.ERR_NAME_CHAR);
		return;
	}

	if(dao.update(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void update_admin_pw(AdminDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	String new_pw = param_str("new_pw");
	String new_pw2 = param_str("new_pw2");
	String admin_pw = param_str("admin_pw");

	// Validate and update it.
	if(!ParamTest.is_valid_passwd_len(new_pw)){
		err_list.add("Password length must be between 4 and 16!");
		return;
	}
	
	if(!ParamTest.is_valid_passwd_char(new_pw)){
		err_list.add("Only ascii character allowed in password!");
		return;
	}

	if(!dao.is_admin_pw(admin_pw)){
		err_list.add("Wrong password!");
		return;
	}

	if(!new_pw.equals(new_pw2)){
		err_list.add("Confirm password different!");
		return;
	}

	if(dao.update_admin_pw(new_pw)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void update_client_pw(AdminDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	String client_pw = param_str("client_pw");

	// Validate and update it.
	if(!ParamTest.is_valid_passwd_len(client_pw)){
		err_list.add("Password length must be between 4 and 16!");
		return;
	}
	
	if(!ParamTest.is_valid_passwd_char(client_pw)){
		err_list.add("Only ascii character allowed in password!");
		return;
	}

	if(dao.update_client_pw(client_pw)){
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
AdminDao dao = new AdminDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update_name(dao);
}
if(action_flag.equals("admin_pw")){
	update_admin_pw(dao);
}
if(action_flag.equals("client_pw")){
	update_client_pw(dao);
}

// Global.
AdminData data = dao.select_one();
%>
<%@include file="include/action_info.jsp"%>

<!-- Admin name -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<div class="title">Admin Name</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Admin Name</td>
		<td><input type="text" name="admin_name" value="<%= data.name%>" size="25"></td>
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
<!-- / -->

<!-- Admin password -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="admin_pw">

<div class="title">Admin Password</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">New Password</td>
		<td><input type="password" name="new_pw" size="25"></td>
	</tr>

	<tr>
		<td>Confirm Password</td>
		<td><input type="password" name="new_pw2" size="25"></td>
	</tr>

	<tr>
		<td>Admin Password</td>
		<td><input type="password" name="admin_pw" size="25"></td>
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
<!-- / -->

<!-- Client password -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="client_pw">

<div class="title">Client Password</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Password</td>
		<td>
		Password for remote filtering client setup.<br>
		<input type="password" name="client_pw" value="<%= data.client_pw%>" size="25"
			onclick="javascript:this.type='text';" onblur="javascript:this.type='password';">
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
<!-- / -->

<%@include file="include/bottom.jsp"%>
