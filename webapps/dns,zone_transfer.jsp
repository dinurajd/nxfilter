<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void insert(ZoneTransferDao dao){
	ZoneTransferData data = new ZoneTransferData();
	data.id = param_int("id");
	data.domain = param_str("domain");
	data.ip = param_str("ip");

	if (is_empty(data.domain)) {
		err_list.add("Domain missing!");
		return;
	}

	if (!is_valid_ip(data.ip)) {
		err_list.add("Invalid DNS server IP!");
		return;
	}

	if(dao.insert(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete(ZoneTransferDao dao){
	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void test(ZoneTransferDao dao){
	try{
		dao.test(param_int("id"));
		succ_list.add("It worked!");
	}
	catch(Exception e){
		err_list.add(e.toString());
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
ZoneTransferDao dao = new ZoneTransferDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("insert")){
	insert(dao);
}
if(action_flag.equals("delete")){
	delete(dao);
}
if(action_flag.equals("test")){
	test(dao);
}

// Global.
int g_count = dao.select_count();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, domain){
	if(!confirm("Deleting zone : " + domain)){
		return;
	}

	var form = document.go_form;
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function go_test(id){
	var form = document.go_form;
	form.action_flag.value = "test";
	form.id.value = id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="insert">

<div class="title">Zone Transfer</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Domain</td>
		<td>
			<input type="text" name="domain" size="25"> ex) nxfilter.local
		</td>
	</tr>

	<tr>
		<td>DNS Server IP</td>
		<td>
			<input type="text" name="ip" size="25">
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
<!-- /view -->
<p>

<!-- list -->
<div class="list">
<table width="100%">
	<tr>
		<td>
			Count : <%= g_count%>
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="3"></td></tr>
	<tr class="head">
		<td width="300">Domain</td>
		<td width="">DNS Server IP</td>
		<td width="100"></td>
	</tr>
	<tr class="line"><td colspan="3"></td></tr>

<%
List<ZoneTransferData> data_list = dao.select_list();

if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='3' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	ZoneTransferData data = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='3'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.domain%></td>
		<td><%= data.ip%></td>
		<td align="right">
		<input type="button" value="TEST" onclick="javascript:go_test(<%= data.id%>)">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.domain%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="3"></td></tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="id" value="">
</form>
<!-- /go_form -->

<%@include file="include/bottom.jsp"%>
