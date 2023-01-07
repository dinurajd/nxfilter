<%@include file="../include/lib.jsp"%>
<%
// Only localhost access allowed.
if(!request.getRemoteAddr().startsWith("127.0.0.1")){
	out.println(request.getRemoteAddr());
	return;
}

// Get params.
String ip = param_str("ip");

UserLoginDao dao = new UserLoginDao(request);

String uname = dao.find_user(ip);
out.println(uname);
%>