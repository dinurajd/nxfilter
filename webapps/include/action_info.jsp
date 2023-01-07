<%@page import="java.util.*"%>
<%
// Error message.
if(!err_list.isEmpty()){
	out.println("<div class='action_info'>");

	for(String err : err_list){
		out.println("<div class='err_msg'>" + err + "</div>");
	}

	out.println("</div>");
}

// Success message.
if(!succ_list.isEmpty()){
	out.println("<div class='action_info'>");

	for(String succ : succ_list){
		out.println("<div class='succ_msg'>" + succ + "</div>");
	}

	out.println("</div>");
}
%>
