<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void delete(ClassifiedDao dao){
	if(dao.delete(param_int("id"))){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete_all(ClassifiedDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	if(dao.delete_all()){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void reclassify_all(ClassifiedDao dao){
	if(dao.reclassify_all()){
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
ClassifiedDao dao = new ClassifiedDao();
dao.page = param_int("page", 1);
dao.add_kw(param_str("kw"));

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("delete")){
	delete(dao);
}
if(action_flag.equals("delete_all")){
	delete_all(dao);
}
if(action_flag.equals("reclassify_all")){
	reclassify_all(dao);
}

// Global.
int g_count = dao.select_count();
int g_page = dao.page;
int g_limit = dao.limit;
String g_kw = param_str("kw");
ClassifiedStatsData stats = dao.get_stats();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_delete(id, domain){
	if(!confirm("Deleting data : " + domain)){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function action_reclassify_all(){
	if(!confirm("Reclassify all?")){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "reclassify_all";
	form.submit();
}

//-----------------------------------------------
function action_delete_all(){
	if(!confirm("Delete all?")){
		return;
	}

	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.action_flag.value = "delete_all";
	form.submit();
}

//-----------------------------------------------
function go_page(page){
	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.page.value = page;
	form.submit();
}

//-----------------------------------------------
function go_search(kw){
	var form = document.go_form;
	form.action = "<%= get_page_name()%>";
	form.kw.value = document.all("search_kw").value;
	form.page.value = "1";
	form.submit();
}

//-----------------------------------------------
function go_view(id){
	var form = document.go_form;
	form.action = "classifier,classified_view.jsp";
	form.id.value = id;
	form.submit();
}

//-----------------------------------------------
function go_test(domain){
	var form = document.go_form;
	form.action = "classifier,test_run.jsp";
	form.domain.value = domain;
	form.submit();
}

//-----------------------------------------------
function set_popup_form(domain){
	document.popup_form.domain.value = domain;
	document.popup_form.id.value = 0;
	document.popup_form.chk_subdomain.checked = false;
	$("#popup_result").empty();
}
</script>

<!-- view -->
<div class="title">Classified</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td>
When you want to perform reclassification against the already classified data, click 'RECLASSIFY-ALL'. It will take sometime<br>
if you have many classified data.
		</td>
	</tr>

	<tr>
		<td>
		&nbsp;&nbsp;<input type="button" value="RECLASSIFY-ALL"
			onclick="javascript:action_reclassify_all()">
		<input type="button" value="DELETE-ALL"
			onclick="javascript:action_delete_all()">
		</td>
	</tr>

	<tr>
		<td>
		Statistics since <%= stats.get_ctime()%>,<br>
		Total = <%= stats.total_count%>
		, Classified = <%= stats.classified_count%>
		, Unclassified = <%= stats.unclassified_count%>
		, Error = <%= stats.error_count%>
		, Hit = <%= stats.hit_percentage%>%
		</td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">
<!-- /view -->
<p>

<!-- list -->
<div class="list">
<table width="100%">
	<tr>
		<td width="50%">
			Count : <%= g_count%> / Page : <%= g_page%>
		</td>
		<td align="right">
			<input type="text" name="search_kw" size="25" value="<%= g_kw%>"
				onkeypress="javascript:if(event.keyCode == 13){go_search(); return;}">
			<input type="button" value="SEARCH" onclick="javascript:go_search()">
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="6"></td></tr>
	<tr class="head">
		<td width="100">Time</td>
		<td width="250">Domain</td>
		<td width="">Title</td>
		<td width="150">Category</td>
		<td width="400">Reason</td>
		<td width="150"></td>
	</tr>
	<tr class="line"><td colspan="6"></td></tr>

<%
List<ClassifiedData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='6' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	ClassifiedData data = data_list.get(i);

	String reason_line = data.reason;
	if(reason_line.length() > 100){
		reason_line = safe_substring(reason_line, 100) + "..";
	}

	if(i > 0){
		out.println("<tr class='line2'><td colspan='6'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= data.get_ctime()%></td>
		<td title="Click for reclassification"><a href="#recat-popup" class="open-popup-link"
			onclick="javascript:set_popup_form('<%= data.domain%>')"><%= data.domain%></a></td>
		<td><%= data.title%></td>
		<td title="Click for reclassification"><a href="#recat-popup" class="open-popup-link"
			onclick="javascript:set_popup_form('<%= data.domain%>')"><%= data.category_name%></a></td>
		<td><%= reason_line%></td>
		<td align="right">
			<input type="button" value="TEST" onclick="javascript:go_test('<%= data.domain%>')">
			<input type="button" value="VIEW" onclick="javascript:go_view(<%= data.id%>)">
			<input type="button" value="DEL" onclick="javascript:action_delete(<%= data.id%>, '<%= data.domain%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="6"></td></tr>
</table>

<table border="0" width="100%">
	<tr>
		<td align="center"><%= get_pagination(g_count, g_limit, g_page)%></td>
	</tr>
</table>
</div>
<!-- /list -->

<!-- go_form -->
<form action="<%= get_page_name()%>" name="go_form" method="get">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="page" value="<%= g_page%>">
<input type="hidden" name="kw" value="<%= g_kw%>">
<input type="hidden" name="id" value="">
<input type="hidden" name="domain" value="">
</form>
<!-- /go_form -->

<!-- popup_form -->
<div id="recat-popup" class="xrecat-popup mfp-hide">
	Add domain into a new category.
	</p>

	<form id="popup_form" name="popup_form" method="post" action="category,system_edit.jsp">
	<input type="hidden" name="action_flag" value="add_domain">
	<table width="100%" cellpadding="2">

		<tr>
			<td>
			<input id="popup_form_domain" type="text" name="domain" size="50"/><br>
			</td>
		</tr>

		<tr>
			<td>
			<select name="id">
			<option value="0"> Select a category to move in
<%
List<CategoryData> cat_list = new CategorySystemDao().select_list();
for(CategoryData data : cat_list){
	printf("<option value='%s'> %s", data.id, data.name);
}
%>
			</select>
			</td>
		</tr>

		<tr>
			<td>
			Include subdomains <input id="popup_form_chk_subdomain" name="chk_subdomain" type="checkbox"/><br>
			</td>
		</tr>

		<tr>
			<td>
				<input type="submit" value="SUBMIT">
				<input type="button" value="CLOSE" onclick="javascript:$.magnificPopup.close();">
			</td>
		</tr>

	</table>

	</p>
	<div id="popup_result" class="succ_msg"></div>
</div>
<!-- /popup_form -->

<%@include file="include/bottom.jsp"%>

<!-- Popup -->
<script type="text/javascript">
//-----------------------------------------------
$(".open-popup-link").magnificPopup({
	type:"inline",
	midClick: true
});

//-----------------------------------------------
$("#popup_form").submit(function(event){
	event.preventDefault();
 
	// Get form values.
	var form = $(this);
	var url = form.attr("action");

	var data = {};
	form.find("[name]").each(function(i , v){
		var input = $(this),
		name = input.attr("name"),
		value = input.val();
		data[name] = value;
	});

	if(data["id"] == 0){
		return;
	}

	$.post(url, data);
	$("#popup_result").empty().append("Submitted.");
});

//-----------------------------------------------
var prev_domain = "";
$("#popup_form_chk_subdomain").change(function(){
	if($(this).is(":checked")){
		var domain = $("#popup_form_domain").val();
		if(domain.indexOf("*.") != 0){
			prev_domain = domain;
		}

		domain = domain.replace(/^www\./, "");
		domain = "*." + domain;

		$("#popup_form_domain").val(domain);
		return;
	}
	$("#popup_form_domain").val(prev_domain);
});
</script>
