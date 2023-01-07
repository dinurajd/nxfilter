<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<style>
/* a */
a:link{color: #111111; text-decoration: none;}
a:active{color: #111111; text-decoration: none;}
a:visited{color: #111111; text-decoration: none;}
a:hover{color: #111111; text-decoration: underline;}

/* body */
body{
	min-width:800px;
	font-family: arial;
	font-size: 10pt;
	color: #111111;
	background: #FFFFFF;
}

/* table */
table{
	font-family: arial;
	font-size: 10pt;
	color: #111111;
}

tr.head{
	height: 22px;
	background: #F4F4F4;
	color:#111111;
	font-family: times;
	font-weight: bold;
}

tr.line{
	height: 1px;
	background: #111111;
}

tr.line2{
	height: 1px;
	background: #919191;
}
</style>

</head>

<body>

<b>Access Violation</b>

<p>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr class="line"><td colspan="8"></td></tr>
	<tr class="head">
		<td width="100">Time</td>
		<td width="50" align="center">Count</td>
		<td width="50" align="center">Type</td>
		<td width="220">Domain</td>
		<td width="100">User</td>
		<td width="100">Policy</td>
		<td width="150">Category</td>
		<td width="">Reason</td>
	</tr>
	<tr class="line"><td colspan="8"></td></tr>

<#list data_list as dm>
	<#assign dm_ctime = dm["ctime"]>
	<#assign dm_cnt = dm["cnt"]>
	<#assign dm_type = dm["type"]>
	<#assign dm_domain = dm["domain"]>
	<#assign dm_user = dm["user"]>

	<#assign dm_policy = dm["policy"]>
	<#assign dm_category_line = dm["category_line"]>
	<#assign dm_reason = dm["reason"]>

	<#if (dm_index > 0)>
		<tr class="line2"><td colspan="8"></td></tr>
	</#if>

	<tr height="24">
		<td>${dm_ctime}</td>
		<td align="right">${dm_cnt}&nbsp;&nbsp;</td>
		<td align="center">${dm_type}</td>
		<td><a target="_blank" href="http://${dm_domain}">${dm_domain}</a></td>
		<td>${dm_user}</td>
	
		<td>${dm_policy}</td>
		<td>${dm_category_line}</td>
		<td>${dm_reason}</td>
	</tr>
</#list>

	<tr class="line"><td colspan="8"></td></tr>
</form>
</table>

</body>
</html>