<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void add_domain(CategorySystemDao dao){
	CategoryDomainData data = new CategoryDomainData();
	data.category_id = param_int("id");
	data.domain = param_str("domain");

	// Param validation.
	if(is_empty(data.domain)){
		return;
	}

	String[] arr = data.domain.split("\\s+");
	for (String domain : arr) {
		domain = domain.trim();

		if (!is_valid_domain(domain)) {
			err_list.add("Invalid domain! - " + domain);
			return;
		}
	}

	if(dao.add_domain(data)){
		succ_list.add("Data updated!");
	}
}

//-----------------------------------------------
void delete_domain(CategorySystemDao dao){
	if(dao.delete_domain(param_int("domain_id"))){
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
//-----------------------------------------------
CategorySystemDao dao = new CategorySystemDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("add_domain")){
	add_domain(dao);
}
if(action_flag.equals("delete_domain")){
	delete_domain(dao);
}

// Global.
CategoryData data = dao.select_one(param_int("id"));
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function action_add_domain(form){
	form.action_flag.value = "add_domain";
	form.submit();
}

//-----------------------------------------------
function action_delete_domain(domain_id){
	form = document.all("category_edit_form");
	form.action_flag.value = "delete_domain";
	form.domain_id.value = domain_id;
	form.submit();
}
</script>

<!-- view -->
<form action="<%= get_page_name()%>" method="post" name="category_edit_form">
<input type="hidden" name="action_flag" value="">
<input type="hidden" name="id" value="<%= data.id%>">
<input type="hidden" name="domain_id" value="">

<!--  -->
<div class="title">System Category</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Name</td>
		<td><%= data.name%></td>
	</tr>

	<tr>
		<td>Description</td>
		<td><%= data.description%></td>
	</tr>

</table>
<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">

<!--  -->
<div class="title">Add domain</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="80">Domain</td>
		<td>
<div style="line-height:20px;">
You can add domains separated by spaces to a category.<br>
To include subdomains use asterisk.<br>
ex) *.nxfilter.org
</div>
		<textarea name="domain" cols="80" rows="4" class="my_textarea"></textarea>
		<div style="height: 1;"></div>
		<input type="button" value="ADD-DOMAIN" onclick="javascript:action_add_domain(this.form)">
		</td>
	</tr>

	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<tr>
		<td colspan="2">
<%
List<CategoryDomainData> domain_list = data.get_domain_list();
for(int i = 0; i < domain_list.size(); i++){
	CategoryDomainData cd = domain_list.get(i);

	if(i > 0 && i % 4 == 0){
		out.print("<br>");
	}

	printf("<span class='domain_item'><a href='javascript:action_delete_domain(%s)'>[x]</a> %s</span>", cd.id, cd.domain);
}
%>
		</td>
	</tr>
</table>
<img src="img/pix.png" height="1" width="100%">

</form>
<!-- /view -->

<%@include file="include/bottom.jsp"%>
