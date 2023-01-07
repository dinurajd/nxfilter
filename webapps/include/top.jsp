<%@include file="lib.jsp"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Expires" content="-1"> 
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="no-cache">
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="/lib/common.css">
<link rel="stylesheet" type="text/css" href="/lib/xdpick/jquery.datetimepicker.css"/>
<link rel="stylesheet" type="text/css" href="/lib/magnific/magnific-popup.css"/>
<script type="text/javascript" src="/lib/common.js"></script>
<script type="text/javascript" src="/lib/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/lib/xdpick/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/lib/magnific/jquery.magnific-popup.js"></script>
<title><%= GlobalDao.get_nx_name()%> v<%= GlobalDao.get_nx_version()%></title>
</head>

<body>

<table width="98%" cellspacing="0" cellpadding="1">
<tr>
	<td width="400">
<span style="font:2em impact; color: black;"><%= GlobalDao.get_nx_name()%></span>&nbsp;&nbsp;v<%= GlobalDao.get_nx_version()%>
, logged in as <%= get_admin_name()%>
	</td>
</tr>
</table>

<div class="menu_wrap">
<ul class="nx_menu" style="width:99%">
	<li class="nx_menui"><a class="nx_menui" href="dashboard.jsp">Dashboard</a></li>
	<li class="nx_menui"><a class="nx_menui" href="config,setup.jsp">Config</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="config,setup.jsp">Setup</a></li>
			<li class="nx_menui"><a class="nx_menui" href="config,admin.jsp">Admin</a></li>
			<li class="nx_menui"><a class="nx_menui" href="config,alert.jsp">Alert</a></li>
			<li class="nx_menui"><a class="nx_menui" href="config,allowed_ip.jsp">Allowed IP</a></li>
			<li class="nx_menui"><a class="nx_menui" href="config,backup.jsp">Backup</a></li>
			<li class="nx_menui"><a class="nx_menui" href="config,block_page.jsp">Block Page</a></li>
			<li class="nx_menui"><a class="nx_menui" href="config,cluster.jsp">Cluster</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="dns,setup.jsp">DNS</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="dns,setup.jsp">Setup</a></li>
			<li class="nx_menui"><a class="nx_menui" href="dns,zone_file.jsp">Zone File</a></li>
			<li class="nx_menui"><a class="nx_menui" href="dns,zone_transfer.jsp">Zone Transfer</a></li>
			<li class="nx_menui"><a class="nx_menui" href="dns,redirection.jsp">Redirection</a></li>
			<li class="nx_menui"><a class="nx_menui" href="dns,dynamic_domain.jsp">Dynamic Domain</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="user,user.jsp">User & Group</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="user,user.jsp">User</a></li>
			<li class="nx_menui"><a class="nx_menui" href="user,group.jsp">Group</a></li>
			<li class="nx_menui"><a class="nx_menui" href="user,adap.jsp">Active Directory</a></li>
			<li class="nx_menui"><a class="nx_menui" href="user,ldap.jsp">OpenLDAP</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="policy,policy.jsp">Policy & Rule</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="policy,policy.jsp">Policy</a></li>
			<li class="nx_menui"><a class="nx_menui" href="policy,free_time.jsp">Free Time</a></li>
			<li class="nx_menui"><a class="nx_menui" href="policy,application.jsp">Application Control</a></li>
			<li class="nx_menui"><a class="nx_menui" href="policy,proxy.jsp">Proxy Filtering</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="category,system.jsp">Category</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="category,system.jsp">System</a></li>
			<li class="nx_menui"><a class="nx_menui" href="category,custom.jsp">Custom</a></li>
			<li class="nx_menui"><a class="nx_menui" href="category,domain_test.jsp">Domain Test</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="classifier,setup.jsp">NxClassifier</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="classifier,setup.jsp">Setup</a></li>
			<li class="nx_menui"><a class="nx_menui" href="classifier,ruleset.jsp">Ruleset</a></li>
			<li class="nx_menui"><a class="nx_menui" href="classifier,classified.jsp">Classified</a></li>
			<li class="nx_menui"><a class="nx_menui" href="classifier,excluded.jsp">Excluded</a></li>
			<li class="nx_menui"><a class="nx_menui" href="classifier,jahaslist.jsp">Jahaslist</a></li>
			<li class="nx_menui"><a class="nx_menui" href="classifier,test_run.jsp">Test Run</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="whitelist,domain.jsp">Whitelist</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="whitelist,domain.jsp">Domain</a></li>
			<li class="nx_menui"><a class="nx_menui" href="whitelist,keyword.jsp">Keyword</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="logging,request.jsp">Logging</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="logging,request.jsp">Request</a></li>
			<li class="nx_menui"><a class="nx_menui" href="logging,signal.jsp">Signal</a></li>
			<li class="nx_menui"><a class="nx_menui" href="logging,netflow.jsp">NetFlow</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" href="report,daily.jsp">Report</a>
		<ul>
			<li class="nx_menui"><a class="nx_menui" href="report,daily.jsp">Daily</a></li>
			<li class="nx_menui"><a class="nx_menui" href="report,weekly.jsp">Weekly</a></li>
			<li class="nx_menui"><a class="nx_menui" href="report,usage.jsp">Usage</a></li>
		</ul>
	</li>
	<li class="nx_menui"><a class="nx_menui" target="_blank" href="<%= GlobalDao.get_nx_tutorial()%>">Tutorial</a></li>
	<li class="nx_menui"><a class="nx_menui" target="_blank" href="<%= GlobalDao.get_nx_forum()%>">Forum</a></li>
	<li class="nx_menui"><a class="nx_menui" href="admin.jsp?action_flag=logout">Logout</a></li>
</ul>
</div>
