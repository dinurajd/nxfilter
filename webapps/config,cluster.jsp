<%@include file="include/top.jsp"%>
<%!
//-----------------------------------------------
void update(ClusterDao dao){
	if(demo_flag){
		err_list.add("Not allowed on demo site!");
		return;
	}

	ClusterData data = new ClusterData();
	data.cluster_mode = param_int("cluster_mode");
	data.master_ip = param_str("master_ip");
	data.slave_ip = param_str("slave_ip");

	if(dao.update(data)){
		succ_list.add("Restarting needed to apply new settings.");
	}
}

//-----------------------------------------------
void delete(ClusterDao dao){
	if(dao.delete(param_int("id"))){
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
ClusterDao dao = new ClusterDao();

// Action.
String action_flag = param_str("action_flag");
if(action_flag.equals("update")){
	update(dao);
}
if(action_flag.equals("delete")){
	delete(dao);
}

// Global.
ClusterData data = dao.select_one();
int g_node_count = dao.select_count();
%>
<%@include file="include/action_info.jsp"%>
<script type="text/javascript">
//-----------------------------------------------
function set_cluster_mode(form){
	var val = radio_get_value(form.cluster_mode);

	if(val == 0){
		form.master_ip.value = "";
		form.master_ip.disabled = true;

		form.slave_ip.value = "";
		form.slave_ip.disabled = true;
	}
	else if(val == 1){
		form.master_ip.value = "";
		form.master_ip.disabled = true;

		form.slave_ip.disabled = false;
	}
	else if(val == 2){
		form.slave_ip.value = "";
		form.slave_ip.disabled = true;

		form.master_ip.disabled = false;
	}
}

//-----------------------------------------------
function action_delete(id, node_ip){
	if(!confirm("Deleting node state-info : " + node_ip)){
		return;
	}

	var form = document.go_form;
	form.action_flag.value = "delete";
	form.id.value = id;
	form.submit();
}
</script>

<form action="<%= get_page_name()%>" method="post">
<input type="hidden" name="action_flag" value="update">

<!--  -->
<div class="title">Cluster</div>

<img src="img/pix.png" height="1" width="100%">
<table width="100%" cellpadding="4" class="view">
	<tr>
		<td width="200">Mode</td>
		<td>
			<input type="radio" class="no_border" name="cluster_mode" value="0" onclick="javascript:set_cluster_mode(this.form)"
				<%if(data.cluster_mode == 0){out.print("checked");}%>> None
			<input type="radio" class="no_border" name="cluster_mode" value="1" onclick="javascript:set_cluster_mode(this.form)"
				<%if(data.cluster_mode == 1){out.print("checked");}%>> Master
			<input type="radio" class="no_border" name="cluster_mode" value="2" onclick="javascript:set_cluster_mode(this.form)"
				<%if(data.cluster_mode == 2){out.print("checked");}%>> Slave
		</td>
	</tr>

	<tr>
		<td>Master IP</td>
		<td>
			If it is a slave node it needs to have a master node.<br>
			<input type="text" name="master_ip" value="<%= data.master_ip%>" size="25">
		</td>
	</tr>

	<tr>
		<td>Slave IP</td>
		<td>
			If you add slave IP addresses here only the registered slave IP addresses allowed for clustering.<br>
			You can add up to 4 slave node IP addresses separated by commas.<br>
			<input type="text" name="slave_ip" value="<%= data.slave_ip%>" size="60">
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

<script type="text/javascript">
set_cluster_mode(document.forms[0]);
</script>

<!-- list -->
<div class="list">
<table width="100%">
	<tr>
		<td>
			Count : <%= g_node_count%>
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="7"></td></tr>
	<tr class="head">
		<td width="200">Node</td>
		<td width="200">Last Contact</td>
		<td width="100">Request</td>
		<td width="100">Block</td>
		<td width="100">User</td>
		<td width="">Client IP</td>
		<td width="100"></td>
	</tr>
	<tr class="line"><td colspan="7"></td></tr>

<%
List<NodeData> data_list = dao.select_list();
if(data_list.isEmpty()){
	out.println("<tr class='row'>");
	out.println("<td colspan='7' align='center'>No data</td>");
	out.println("</tr>");
}

for(int i = 0; i < data_list.size(); i++){
	NodeData nd = data_list.get(i);

	if(i > 0){
		out.println("<tr class='line2'><td colspan='7'></td></tr>");
	}
%>
	<tr class="row">
		<td><%= nd.node_ip%></td>
		<td><%= nd.get_atime()%></td>
		<td><%= nd.req_cnt%></td>
		<td><%= nd.block_cnt%></td>
		<td><%= nd.user_cnt%></td>
		<td><%= nd.clt_ip_cnt%></td>
		<td align="right">
		<input type="button" value="DEL" onclick="javascript:action_delete(<%= nd.id%>, '<%= nd.node_ip%>')">
		</td>
	</tr>
<%}%>

	<tr class="line"><td colspan="7"></td></tr>
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
