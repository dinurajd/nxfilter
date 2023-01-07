<%@include file="../include/lib.jsp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
//-----------------------------------------------
// Set permission for this page.
permission.add_admin();

//Check permission.
if(!check_permission()){
	return;
}

//-----------------------------------------------
int max_size  = 1024 * 1024 * 100;
String upload_path = GlobalDao.get_www_tmp_path();
try{
	MultipartRequest mreq = new MultipartRequest(request, upload_path, max_size, "UTF-8", new DefaultFileRenamePolicy());

	String action_flag = null2str(mreq.getParameter("action_flag"));
	String origin_page = null2str(mreq.getParameter("origin_page"));

	// File name.
	String file1 = mreq.getFilesystemName("file1");

	// If we have an uploaded file.
	int import_count = 0;
	if(is_not_empty(file1)){

		// Full path to the file.
		String filepath = GlobalDao.get_www_tmp_path() + "/" + file1;

		if(action_flag.equals("ruleset")){
			import_count = new ClassifierRulesetDao().import_file(filepath);
		}
		else if(action_flag.equals("jahaslist")){
			import_count = new JahaslistDao().import_file(filepath);
		}
	}

	response.sendRedirect(origin_page + "?import_count=" + import_count + "&action_flag=" + action_flag);
}
catch(Exception e){
//	e.printStackTrace();
}
%>
