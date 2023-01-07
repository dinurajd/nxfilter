<%@include file="include/top.jsp"%>
<%@include file="include/action_info.jsp"%>

<div style='width: 99%'>
	<table id="example" class="display" cellspacing="0" width="100%">
		<thead>
			<tr>
				<th>Name</th>
				<th>Position</th>
				<th>Office</th>
				<th>Age</th>
				<th>Start date</th>
				<th>Salary</th>
			</tr>
		</thead>
 
		<tbody>
			<tr>
				<td>Tiger Nixon</td>
				<td>System Architect</td>
				<td>Edinburgh</td>
				<td>61</td>
				<td>2011/04/25</td>
				<td>$320,800</td>
			</tr>
		</tbody>
	</table>
</div>

<%@include file="include/bottom.jsp"%>

<!-- datatables -->
<link rel="stylesheet" type="text/css" href="/lib/datatables/jquery.dataTables.css">
<link rel="stylesheet" type="text/css" href="/lib/datatables/shCore.css">
<link rel="stylesheet" type="text/css" href="/lib/datatables/demo.css">
<script type="text/javascript" language="javascript" src="/lib/datatables/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/lib/datatables/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="/lib/datatables/shCore.js"></script>
<script type="text/javascript" language="javascript" src="/lib/datatables/demo.js"></script>
<script>
$(document).ready(function(){
	$('#example').DataTable({
		"paging": true,
		"lengthMenu": [[25], [25]],
		"bLengthChange" : false,
		"dom": '<"top"if>rt<"bottom"p><"clear">'
	});
});
</script>
