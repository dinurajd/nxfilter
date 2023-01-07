<%@include file="../include/lib.jsp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
int max_size  = 1024 * 1024 * 10;
String upload_path = GlobalDao.get_www_tmp_path();
try{
	MultipartRequest mreq = new MultipartRequest(request, upload_path, max_size, "UTF-8", new DefaultFileRenamePolicy());

	// File name.
	String file1 = mreq.getFilesystemName("file1");

	// If we have an uploaded file.
	if(is_not_empty(file1)){

		// Full path to the file.
		String filepath = GlobalDao.get_www_tmp_path() + "/" + file1;
		out.println(filepath);
	}
}
catch(Exception e){
//	e.printStackTrace();
}
%>
<html>
<body>
 <form action='<%= get_page_name()%>' method='post' enctype='multipart/form-data'>
	<input type='file' name='file1'><br>
	<input type='submit'>
</form>
</body>
</html>
