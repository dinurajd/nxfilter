<%@include file="include/lib.jsp"%>
<%
// Create data access object.
AdminLoginDao dao = new AdminLoginDao(request);

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("logout")){
	dao.logout();
}
if(action_flag.equals("login")){
	if(dao.login(param_str("uname"), param_str("passwd"))){
		// Start page for admin.
		response.sendRedirect("dashboard.jsp");
		return;
	}
}
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Expires" content="-1"> 
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="no-cache"> 
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/lib/login.css">
<title><%= GlobalDao.get_nx_name()%> v<%= GlobalDao.get_nx_version()%></title>
</head>

<body>

<center>
<div style="margin-top: 100"></div>

<!-- view -->
<form method="post" action="<%= get_page_name()%>" class="login">
<input type="hidden" name="action_flag" value="login">
	<p>
	<label for="uname">Name:</label>
	<input type="text" name="uname" id="uname">
	</p>

	<p>
	<label for="passwd">Password:</label>
	<input type="password" name="passwd" id="passwd">
	</p>

	<p class="login-submit">
		<button type="submit" class="login-button">Login</button>
	</p>
</form>

  <section class="about">
    <p class="about-links">
      <a target="_blank" href="<%= GlobalDao.get_nx_tutorial()%>" target="_parent">View Tutorial</a>
      <a target="_blank" href="<%= GlobalDao.get_nx_download()%>" target="_parent">Download</a>
    </p>
    <p class="about-author">
      &copy; 2013&ndash;2016 <a target="_blank" href="<%= GlobalDao.get_nx_homepage()%>" target="_blank"><%= GlobalDao.get_nx_company()%></a><br>
	  You are about to login to <a target="_blank" href="<%= GlobalDao.get_nx_homepage()%>" target="_blank"><%= GlobalDao.get_nx_name()%></a> admin page.
  </section>

<%if(dao.is_first_login()){%>
<!-- login info -->
<table width="500" cellpadding="4">
<tr>
<td width="80">
</td>

<td>

<font color="#00DD00">* The initial admin name and password is 'admin' and 'admin'.</font>

</td>
</tr>
</table>
<%}%>

</center>

</body>
<html>
