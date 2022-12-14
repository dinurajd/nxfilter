<%@include file="include/lib.jsp"%>
<%
//-----------------------------------------------
// Create data access object.
UserLoginDao dao = new UserLoginDao(request);

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("logout")){
	dao.logout();
}
if(action_flag.equals("login")){
	if(dao.login(param_str("uname"), param_str("passwd"))){
		response.sendRedirect("block,welcome.jsp");
		return;
	}
	else{
		err_list.add("Login error!");
	}
}

// Get login-page.
BlockPageDao bp_dao = new BlockPageDao();
BlockPageData data = bp_dao.select_one_local();
String login_page = data.login_page;

// nx_name.
login_page = login_page.replaceAll("#\\{nx_name\\}", GlobalDao.get_nx_name());

out.print(login_page);
%>