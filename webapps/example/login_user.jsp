<%@include file="../include/lib.jsp"%>
<%
/*
You can call this page using the following url.

  http://localhost/example/login_user.jsp?ip=192.168.0.100&uname=jinhee

It's limited to localhost for security reason but you can change it according
to your network environment.
*/

// Only localhost access allowed.
if(!request.getRemoteAddr().startsWith("127.0.0.1")){
	out.println(request.getRemoteAddr());
	return;
}

// Get params.
String ip = param_str("ip");
String uname = param_str("uname");

/*
If you think there's a possibility of IP spoofing from your users then you'd better
get the IP address from the HTTP connection itself.

String ip = request.getRemoteAddr();
String uname = param_str("uname");
*/

UserLoginDao dao = new UserLoginDao(request);
if(dao.create_ip_session(ip, uname)){
	out.println("Login success.");
}
else{
	out.println("Login error!");
}
%>