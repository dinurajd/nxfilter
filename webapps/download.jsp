<%@page import="java.io.*,nxd.dao.*"%><%
String filename = request.getParameter("filename");
String content_type = request.getParameter("content_type");

if(content_type == null || content_type.length() == 0){
	content_type = "application/octet-stream";
}

if(filename == null){
	out.println("Invalid filename!");
}
else{
	// Remove directory part for preventing illegal access.
	filename = filename.replaceAll(".*/", "");

	response.setContentType(content_type);
	response.setHeader("content-disposition","attachment; filename=\"" + filename + "\"");

	OutputStream outx = response.getOutputStream();
	FileInputStream fis = new FileInputStream(GlobalDao.get_www_tmp_path() + "/" + filename);
	int i = 0;
	while((i = fis.read()) != -1){
		outx.write(i);
	} 
	fis.close();
}
%>