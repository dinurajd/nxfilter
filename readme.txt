*****************************************************************
NxFilter v3.4.4
  Author : Jinhee Lee
  Homepage : http://www.nxfilter.org
  Contact : support@nxfilter.org
*****************************************************************

NxFilter is a property of Jahastech.


2016/10/02, v3.4.4
- 'queue_full_exit' option on cfg.properties added.
- Connection error count from DB not being reset bug fixed.
- Connection timeout and socket timeout for sending an email have been
  increased to 6 seconds.
- 'nxd.policy' package added.
- 'nxd.dns' package added.
- 'nxd.phome' package added.
- 'nxd.filter' package added.
- Adjustable query cache TTL introduced for proxy clients.


2016/09/19, v3.4.3
- Not refreshing expired CNAME cache on LookupHandler bug fixed.
- CSV log exportation limit incresed to 100,000.
- 'common_edge.css' has been removed.
- PrefixDic is not a Thread anymore.
- 'nxd.alert' package added.
- Path not allowed in IE proxy bypass.


2016/08/22, v3.4.2
- 'drop_empty_response' option added on cfg.properties.
- NodeTalkie doesn't try to connect when master node down.
- BlockPage gets a default NxError when master node down.
- Login to slave GUI when master node down allowed.
- Interval for finding the last error on BlockDao adjusted to 50.
- LogWriter flush interval to master node adjusted to 5 seconds.


2016/08/12, v3.4.1
- Redundant bootstrap directory has been removed.
- We don't load data on DynUpdate when we find a blank domain.
- License file sharing between cluster nodes bug fixed.


2016/08/06, v3.4.0
- Improved DataBase, RowSet classes applied.
- BlockDomainResolver returns '127.0.0.1' when there is no block
  redirection IP loaded on a slave node.
- Filtering still works on a slave node having master node down.
- Blacklist license update on GUI added.
- License policy changed.
- New authoritative DNS server module applied.
- URLBlacklist support has been removed.


2016/07/06, v3.3.4
- Client password for remote filtering agent added.
- Block by window title has been removed from application control.
- MS DNS IP validation removed for adding secondary DNS IP on Active
  Directory importation setup.
- Remove protocol from reclassification request.
- Bug for '172.16.x.x' with LibNet.is_private_ip method fixed.
- Authoritative flag unset from block redirection.
- LDAP importation bug in 'LdapUpdater.delete_user' fixed.


2016/06/14, v3.3.1
- New domain validation function applied for allowing the domains
  not having dot.
- Support for NxUpdate v1.x, NxClient v1.x stopped.
- Using standard DNS protocol for NxUpdate and NxClient signals and
  queries.
- Send error message to NxClient when authentication disabled.
- Remove duplicated username on the dropdown list on 'Report > Daily'.
- Keep LDAP DN for an LDAP imported user for LDAP login.
- 'nxd.ldap' package added.
- Add auth_drop_cnt instead of auth_redi_cnt when authentication not
  enabled.
- Set 'false' for 'follow_referral' on LDAP login.
- Version query signal added.
- Cache DNS response only when it has at least one A record.
- Removed redundant checking for empty message from response cache.
- UTF-8 support for Jahaslist remote repository text file.
- Not sending DNS response after caching bug from v3.3.0 fixed.
- LDAP import excluded keyword size increased to 2,000 bytes.


2016/05/22, v3.2.0
- NxClassifier ruleset type for HTML text added.
- 'Keep HTML Text' option added on 'NxClassifier > Setup'.
- Domain validation for whitelist has been removed.
- Drop packet when there is a response message having no record from
  an upstream server.


2016/05/07, v3.1.9
- Remove respawn option from Systemd script.
- 'enable_auto_update' flag removed from NxClassifier.
- Not to share login session when master node down.
- 'is_queue_full' flag removed from MasterCheck.
- 'IE Proxy Bypass' added on 'Policy > Proxy Filtering'.
- Typo on 'Config > Redirection' fixed.
- NxClassifier DNS checking bug fixed.


2016/04/28, v3.1.8
- Error message for upstream DNS query timeout added.
- DnsStats class added.
- Updating Jahaslist through remote repository added.
- Importing Jahaslist uses lesser memory.


2016/04/20, v3.1.7
- 'HTTP_RECAT_MAX_LINE' has been increased to 100000.
- Don't merge custom classified domains when it's not on Jahaslist.
- Remote update for NxClassifier ruleset disabled.
- 'IMPORT RULESET' on 'NxClassifier > Setup' changed to 'REPLACE RULESET'.
- Jahaslist can be updated without any existing data.
- 'recatlist.txt' in '/nxfilter/jahaslist'has been removed.
- Use 'img/pix.png' to express a horizontal line on GUI.
- Reading file line by line when it imports Jahaslist.
- 'Web Hosting' category added on Komodia mapping.
- Systemd auto-start script added on 'deb' package.
- 'Disable Auto Update' on 'NxClassifier > Setup' removed.
- 'Enable Auto Update' on 'NxClassifier > Setup' added.


2016/04/10, v3.1.6
- Set host IP only once for Syslog setup with system startup.
- Checking for empty DNS answer from cache added.
- 'Log Retention Days' length limit on GUI increased to 3.
- Separator for 'Slave IP' on 'config,cluster.jsp' changed to a comma.


2016/03/24, v3.1.5-p1
- Local DNS setup menu added on GUI.
- MS DNS setup menu added on GUI.
- Upstream DNS server load balancing option introduced.
- 'local_dns' and 'local_domain' disabled on cfg.properties.
- DNS level safe-search enforcing for Bing added.
- AD domain resolver not loaded bug fixed.


2016/03/08, v3.1.4-p2
- Use get_real_uname, instead of accessing real_uname directly.
- 'Log retention days' increased to 400.
- System domains bypassed for proxy filtering.
- Waiting for the block reason populated for 100 milliseconds.
- Lib.system_output gets string array as its parameter.
- Response cache returns null when it's type A record bug fixed.
- New TTL calculation with the elapsed time bug in response cache fixed.
- Google safe-search domain not updated on response cache bug fixed.


2016/02/16, v3.1.3
- Bypassing Active Directory domain to MS DNS server for unauthenticated
  users.
- 'Follow Referral' option added for Active Directory importation.
- '#{nx_name}' not populated on 'block,chrome.jsp' bug fixed.
- Active Directory DNS bypassing comes before zone file search.
- Zone trasfer search comes after zone file search.
- Zone Transfer option on Active Directory importation removed.
- New algorithm for calculating the remaining TTL of a cached record to setup
  the TTL for each record separately.
- 'bypass_cache_domain_list' param removed from cfg.propertis.


2016/02/08, v3.1.2
- Dynamic domain loaded with zero mtime bug fixed.
- Shallalist not including 'education/schools' bug fixed.
- Report on domain, user, client IP number missing bug fixed.


2016/02/04, v3.1.1-p1
- Dynamic DNS support added.
- Whitelist applied on safe-search.
- Delete temporary zone files nightly.
- Warning message for not enabling authentication on IP association
  to user.
- Reclassified domain being deleted bug fixed.


2016/01/23, v3.1.0-p2
- 'gob.xx' classified into government category.
- Authority DNS server feature added.
- DNS setup menu on GUI separated.
- Different CSS applied on MS browser.
- Wildcard lookup allowed on zone transfer.
- Bypass DNS query against '*.ip6.arpa '.
- 'block-time' on policy not reset bug fixed.
- 'clt_cache_ttl' column moved into 'dns_setup' table.


2016/01/04, v3.0.9
- 'reset_pw.bat' resets admin name to 'admin'.
- Set 'Config.admin_pw' from admin table.
- Recategorization requires to keep it for 3 days.
- Redirection works on total bypass and master node down.
- 'recatlist.ver' -> 'recatlist_ver.txt'.
- 'CDN' added for domain pattern dictionary.


2015/12/18, v3.0.8
- Minimum idle connection for DB pool changed to 10.
- Maximum idle connection for DB pool changed to 30.
- Sorting whitelist domains for NxClient.
- Remote update for Jahaslist when NxFilter starts.
- Bypass remote update when there's no data in Jahaslist.
- Possible connection leak from RecatMan fixed.
- Delete recategorization data before submitting.


2015/12/05, v3.0.7
- Safe-search redirection applied to 'youtubei.googleapis.com' and
  'www.youtube-nocookie.com'.
- Auto-update for NxClassifier ruleset added.
- Update count for NxClassifier ruleset introduced for auto-update.
- Policy based block-time added.


2015/11/19, v3.0.6
- Safe-search redirection applied to 'm.youtube.com'.
- Jahaslist auto-update disabled when domain pattern dictionary disabled.
- Case sensitivity problem with username for bandwidth control fixed.
- Bandwidth control, 2000MB for a user limit removed.


2015/11/04, v3.0.5
- HTML code input on 'GET/POST' requests blocked for preventing 'CSRF'
  attack.
- Javascript error for deleting custom categories fixed.
- Alert categories added on 'Config > Alert'.


2015/10/21, v3.0.4
- Remote Jahaslist recategorization list update added.
- DomainPatternDic updated.
- 1,000 user limit for user selectbox on report removed.
- 'RESTORE-DEFAULT' button added on 'NxClassifier > Ruleset' and
  'NxClassifier > Jahaslist'
- Unclassified domain cache removed.
- Remove admin session data when admin logout.
- admin.jsp?action=logout -> admin.jsp?action_flag=logout.
- On log-view, hovering on category will show all the categories if there
  are multiple categories.


2015/10/04, v3.0.3
- Domain process queue size for NxClassifier adjusted to 10000.
- Internal lookup_map size for domain process queue of NxClassifier adjusted
  to 1000.
- SQL error for 'is_already_classified()' fixed.


2015/10/03, v3.0.2
- InvaludContentTypeException class readded.
- Missing Lib.chop_subdomain() restored.
- Excluded list added for NxClassifier.
- Max redirection count for NxClassifier increased to 5.
- Unclassified cache bypassed for Jahaslist and Shallalist.


2015/10/02, v3.0.1-p1
- ShallaUpdate, BlacklistUpdate classes moved into 'nxd.util' package.
- Remove 'www.' from reclassification request.
- Jahaslist added.
- Auto-classification by NxClassifier added.
- Multi-bytes character support for block-page added.
- 'TEST' button added for alert email setup.
- Use ParamTest instead of ParamValidator.
- Ciphers defined for Tomcat to solve 'ERR_SSL_WEAK_SERVER_EPHEMERAL_DH_KEY'
  error on Chrome.
- Not being able to select Shallalist on 'Category > System' bug fixed.


2015/08/27, v2.8.7
- New responsive login form template added.
- 'webapps/lib/jquery-1.11.3.min.js' added.
- 'webapps/lib/jquery.cookie.js' added.
- 'webapps/lib/bootstrap.min.css' added.
- CSS and Javascript file inclusion moved into 'top.jsp'.
- Preview script on 'Config > Block Page' changed to use 'document.write()'.


2015/08/20, v2.8.6
- Keep logging for request IP address for admin login.
- New parsing algorithm for DomainPatternDic added.
- Tracker domain separated from Ads domain for DomainPatternDic.
- Missing data sanitization on WhitelistDao.update() added.
- Only one category for a custom categorized domain allowed.
- Domain reclassification popup on log-view added.
- Bypass LDAP synch when there's read timeout error.
- AutoCloseable DataBase and RowSet classes added.


2015/08/07, v2.8.5
- Recategorization request criteria activated.
- Log data not showing bug when you update from pre-v2.6.6 fixed.
- Block page size limit increased to 100 KB on validation.
- 'oem.properties' introduced.
- Update notification via alert email added.
- 'alert_email.ftl' template added.
- CNAME caching bug for safe-search fixed.


2015/08/01, v2.8.4
- Block page size limit increased to 100 KB.
- Bypassing 'Client Cache TTL' not working bug fixed.
- Response cache applied on DNS response having additional section.
- Use is_cached_once() instead of find() on DomainDic.
- 'moment.js' library removed from logging,*.jsp pages.


2015/07/24, v2.8.3
- 'EDIT' on 'Category > System' changed to 'ADD-DOMAIN'.
- Tomcat compilerSourceVM and compilerTargetVM set to 1.7.
- UserTestDao.find_user() method restored.


2015/07/16, v2.8.2
- PhishDao removed.
- DaoUtil introduced for simplifying GUI customization.
- 'use_phishtank' field from ConfigData removed.
- Domain validation blocking for IDN bug fixed.
- Single category preference applied for 'Download'.
- Use 'ParamValidator.ERR_USERNAME_CHAR' for username checking.
- Ambiguous action target bug for 'category,system.jsp' fixed.
- has_new_message() and get_popup() methods have been removed from
  AdminLoginDao.
- Javascript date calculation bug on report fixed.


2015/07/07, v2.8.1
- '/nxfilter/conf/prefix.txt' added for dynamic classification.
- '/nxfilter/conf/suffix.txt' added for dynamic classification.
- Datetime picker not selecting the days of last month bug fixed.
- Database connection hang on 'Policy > policy' problem fixed.
- CategoryData.get_domain_list() method for lazy loading added.
- 'moment.js' library removed.


2015/07/01, v2.8.0
- Adding domain into system category became possible.
- Dynamic classification based on domain pattern applied for Shallalist.
- Duplicated map data for traffic DB on cluster bug fixed.


2015/06/19, v2.7.9
- Special domain detection function added for Komodia.
- Single category preference applied for 'Home/Gardening'.
- Remove 'www' for Komodia query.
- User IP listing format applied.


2015/06/16, v2.7.8
- DynUpdate host checking obsoleted.
- Local domain excluded from Komodia query.
- Komodia query cache retention period increased to 7 days.
- Table name 'cache' changed to 'komodia'.
- Goverment category comes first when there are multi-categories for
  Komodia mapping.


2015/06/11, v2.7.6
- IPv6 redirection IP setup added.
- prunsrv.exe updated to v1.0.15.
- Zone transfer checkbox removed from new Active Directory importation
  setup.
- First login check for login through NodeListener.
- Bypass filtering for queue full error on slave node.
- Bypass domain existence checking for queue full error.


2015/05/10, v2.7.5
- 'no_share_session' option for cfg.properties added.
- 'Max domain length check' on policy bypassed at default.
- 'Block covert channel' on policy is off at default.
- 'Block mailer worm' on policy is off at default.
- 'Block DNS rebinding' on policy is off at default.


2015/04/26, v2.7.4
- Pre-cache bug with CNAME record fixed.


2015/04/20, v2.7.3
- Dropdown menu added.
- config,config.jsp -> config,setup.jsp.
- main,dashboard.jsp -> dashboard.jsp.
- CSS validated.
- /conf/komodia.map updated to fix some typo.


2015/04/09, v2.7.2
- 'show_netflow' option for cfg.properties added.
- Daily trend chart interval corrected to 3600.
- User traffic trend duplicated in report_cache bug fixed.
- User traffic trend only 23 hours display bug fixed.
- Domain, user, client-ip count on weekly report to show MAX value.
- 'chart3div' tag removed from report GUI.
- Minimum response cache size increased to 100,000.
- Maximum response cache size increased to 2000,000.
- Reset whitelist when it lose the last parent policy.
- chk_new_message() not to add blank line.
- Well known site list size increased to 100,000.


2015/03/30, v2.7.1
- Null data return for daily report bug fixed.
- Single category only for Komodia categories applied.


2015/03/27, v2.7.0
- Custom category domain limit increased to 100,000.
- daily_stats table added.
- request_traffic_5m, request_traffic_1h, real_user_count removed.
- 'syslog_only' flag added into cfg.properties.
- Authentication error with LDAP username having space allowed.
- Default data for empty trend chart added.
- LibDate.strftime_arr bug fixed.
- log_view, signal_view, netflow_view, hh24, category_count_5m removed.
- Daily report and weekly report being generated based on start date.
- Datetime picker added for log-view and report.
- Report caching structure redesigned.
- Delete old data on 02:00.
- Generating report cache for daily, weekly report on 03:00.
- 'stop_auto_report' option for cfg.properties added.
- 'ldap_conn_timeout' option for cfg.properties added.
- 'ldap_read_timeout' option for cfg.properties added.
- Swimsuit/Underwear category on Komodia map merged into Fashion/Beauty.
- h2-1.3.176.jar added.


2015/03/10, v2.6.5
- 'log_flush_limit' option for cfg.properties added.
- Komodia query only for existing domain.
- 'most_permissive' option for cfg.properties for multi-category permit.
- MIN_TTL set to 5 seconds for a response cache.


2015/03/03, v2.6.4
- DB_CLOSE_ON_EXIT=FALSE added in JDBC URL.
- cluster_monitor missing colummn bug fixed.
- Phishing related option for cfg.properties removed.
- report_server_ip option for cfg.properties for separating reporting
  DB added.
- Komodia 'Misc' mapping bug fixed.


2015/02/27, v2.6.3
- Syslog format changed to have 'NXFILTER' prefix.
- ShallalistUpdate to be using system DNS.
- Downloading the backup file from 'Config > backup'.


2015/02/11, v2.6.2
- License share between cluster nodes added.
- keystore_file, keystore_pass option added on cfg.properties for
  custom SSL certification.
- Multi-level domain chopping with Shallalist bug fixed.


2015/02/06, v2.6.1
- alert_email.ftl removed.
- Komodia dynamic classification not added into cache.
- Most specific IP range comes first rule for user association added.
- '/conf/komodia.map' updated to having 69 categories.


2015/02/01, v2.6.0
- Domain test protocol changed.
- Komodia cloud blacklist option added.
- URLBlacklist option on GUI removed.


2015/01/10, v2.5.3
- Quota reset not synchronized over cluster bug fixed.
- localhost excluded from DNS ACL for WebSoket.
- Chrome block-page not showing on HTTPS bug fixed.
- Proxy level redirection added.
- Bypass authentication doesn't apply on authenticated user.


2015/12/30, v2.5.2
- install_time added into config table.
- New block-page and login-page set added.
- Chrome agent support added.
- Wildcard, '*' support for whitelist keyword added.
- DNS level Youtube safe-search enforcing added.


2014/12/05, v2.5.1
- Only allows IP address for AD/LDAP host.
- Embedded Tomcat updated to v7.0.57.
- Proxy level domain redirection added.
- Bypassing IP host from forwarding query.
- Custom query parsing bug fixed.
- Java mail API updated to v1.5.1.


2014/11/27, v2.5.0
- Group account concept introduced.
- NxClient v4.0 support added.
- Showing real username from NxClient.
- no-usr, no-grp -> anon-user, anon-grp.
- Proxy log not display correctly with IDN bug fixed.
- zvelo_timeout option added into cfg.properties.
- Proxy blocked reason not display bug fixed.
- 'local_resolver_port' option added into cfg.properties.
- real_user_cnt table added for counting distinct logged-in username.
- Version check for agent added.


2014/11/12, v2.4.5
- Time format on 'Report > usage' changed.
- Log filename changed to 'nxfilter.log'.
- PTR record bypassed from 'Block unclassified' option.


2014/11/07, v2.4.4
- DNS level safe-search enforcing implemented.
- Safe-search option became policy specific.
- bypass_empty_domain option added into cfg.properties.


2014/10/30, v2.4.3
- Alert email showing detailed reason for proxy block.
- Usage report for recent 30 days added.


2014/10/20, v2.4.2
- is_valid_domain, is_valid_email moved into lib.jsp.
- Group specific free-time not updated bug fixed.
- Redirection domain timeout error fixed.
- Zvelo license alert email bug fixed.


2014/10/13, v2.4.0-p1
- Admin domain and DDNS domain bypassed from filtering.
- Reverse lookup domain added into DDNS domain lookup table.
- 'max_slave_num' variable added into cfg.properties.
- traffic_trend_5m -> request_trend_5m.
- Report cache file extension changed from 'xml' to 'txt'.
- Zvelo cloud option for blacklist added.
- Minimum length for name adjusted to 1.
- Phishing DB removed.
- 'www_dir' param introduced for easier customization of GUI.
- Default HTTPS port changed to 443.
- Temp direcotry under webapps moved into tmp/www.
- TCP port checking added into Windows setup.
- Checking blacklist_type disparity among cluster nodes.


2014/09/24, v2.3.0
- Faster startup time by reducing local port checking timeout.
- Performance increased by introducing thread safe map.
- Domain cache and unclassified cache introduced.
- Fusion chart compatibility removed.
- Locking algorithm redesigned for PhishiDic.
- ResponseCache redesigned using thread safe map.
- Default response cache size increased to 200,000.
- err_list removed from DAO.
- OpenLDAP import supports 'memberOf' attribute.


2014/09/02, v2.2.8
- STOP signal added for NxClient and NxUpdate.
- SWITCH signal removed.
- Default block page not showing bug with IE fixed.


2014/08/25, v2.2.7-p1
- IP session synchronize for login_policy only.
- StatsMaker thread bypassed for a slave node.
- Bypass cache if there's an authority or additional record.
- Slave node request count added into 'Config > cluster'.
- Javascript added for hiding embedded block-page.
- upstream_dns option added into cfg.properties.
- Sending rf_block_ip to local user bug fixed.
- Duplicated custom category name check added.
- Custom query support added.
- Single IP association comes before IP session.


2014/08/15, v2.2.6
- Slash relaced to back-slash on NxPath.
- Checking AD DNS server availability.
- use_local_dns param not used bug fixed.
- IPUPDATE signal ingnored if it comes from a static IP.
- Proxy, application error count added into report.
- tomcat.ks -> nxfilter.jks.
- dump_domain option for cfg.properties added.
- bypass_cache_domain option for cfg.properties added.


2014/07/22, v2.2.5
- Local DB initial copy routine at startup added.
- block_redi_ip, rf_block_redi_ip length adjusted to 100.
- Logout signal added.


2014/07/14, v2.2.4
- 'Request' -> 'User' on header of 'Logging > request' list.
- Array index overflow bug on logging across clustering nodes fixed.
- Load balancing for block reason added.
- Admin domain redirection rule added for clustering.
- top_nomenu.jsp, bottom_nocopy.jsp, action_info_nomenu.jsp removed.
- FusionCharts.js link removed from top.jsp.
- Program icon changed.


2014/07/01, v2.2.3
- Windows installer preserves previous config files with the introduction
  of default config files.
- Back-slash in NxPath replaced to slash.
- Regex removed from whitelist map.
- True bypass concept introduced.
- Login through NxLogon to slave node synchronized with master node.
- Adjust resolving order to prevent socket connection error on NxLogon.
- Bulk insert for custom category bug fixed.
- Load balancing for login, block redirection.
- Local cache DB added for load balancing.
- '/extra' directory and 'nxlogon.exe' removed for preventing false positives
  from some virus detection program.


2014/06/26, v2.2.2
- Forcing safe-search option through NxClient, NxLogon V2 added.
- URL keyword filtering through NxClient, NxLogon V2 added.
- Application control through NxClient, NxLogon V2 added.
- CharacterSet encoding removed from NxParam as a redundancy.
- Request object removed from AdminLoginDao.
- javax.naming.PartialResultException ignored by LdapAgent.
- '+' in application control rule changed to '*'.
- Minimum length(4) introduced for application control keyword.
- Empty record check for finding response cache added.
- application -> policy_application.
- Domain to domain redirection added.
- block_domain introduced.
- Fash-flux detection removed.
- IP based ACL for login redirection added.
- err_detail -> reason_detail.
- System domain concept removed.
- Log only applied to proxy policy.
- Whitelist domain, keyword for bypass filtering applied to proxy policy.
- Block IP host added to proxy policy.
- Using DynUpdate for AD domain resolving.
- Block other browser option added for proxy policy.
- Default number of request handler became 4.
- Default value for 'Log retention days' changed to 30.
- Timeout applied to TCP port checking at startup.
- Application block execution interval introduced.
- Included NxLogon updated to v1.5 having application blocking removed.
- Agent policy update period added on 'Config > config'.
- SMTP port reset bug on GUI fixed.
- Google chart not displaying for IE bug fixed.
- 'overflow: hidden' on 'div.hr' added into block-page template.


2014/05/18, v2.1.0
- Application control added.
- New NxLogon for killing UltraSurf and Tor processes.
- NxMapper for AD single sign-on support added.
- Per-user basis sum view added for 'Log > bandwidth'.
- '#{user}' variable supported on welcome page.
- Bordering spaces allowed in exclude keyword for LDAP import.
- Make a temporary copy for the request parameter map.
- Empty password for LDAP import allowed.
- '0:0:0:0:0:0:0:1' check for GUI restriction restored.
- Block, login, welcome page removed from GUI IP restriction.
- FusionChart library removed.


2014/04/28, v2.0.6
- Login redirection bug fixed.


2014/04/27, v2.0.5
- Login API through HTTP added for custom login script.
- Top 5 chart by client-ip added into daily and weekly report.
- Group or user exclusion by keyword for LDAP import added.
- Request, Response, Wonfig for GUI removed.
- Group specific free-time added.
- Free-time policy added on user, group list GUI view.
- User, group, policy, category variables added into block-page.
- Phishing host converted to lower case.
- Not selecting 'Same as work-time policy' for user-edit bug fixed.
- Free-time flag added in user-test view.
- 24:00 added for free-time setup.


2014/04/14, v2.0.4
- Logout-domain not working bug fixed.
- Correct cluster node downtime added into alert email.
- Slave node monitor added on 'Config > cluster'.
- Connection check from slave node startup readded.
- Action info missing on user,ldap_edit.jsp fixed.
- 'overflow: hidden' added for IE compatibility.
- Blocked IP for DNS added on 'Config > allowed-ip'.
- Concurrency bug with NxParam fixed.


2014/04/08, v2.0.3
- Report statistics cache added for faster report generation.
- NxClient signals removed from DNS packet.


2014/04/02, v2.0.2
- Netflow size format changed to human readable format.
- OpenLDAP support restored by user request.
- Cluster mode warning message added.
- Custom category not showing on policy bug fixed.
- Custom category domain limit bug fixed.
- Quota time not reset on midnight bug fixed.
- 'Duplicate headers returned by the server' on Chrome bug fixed.


2014/04/01, v2.0.1
- Whitelist keyword not realoading bug fixed.
- Null pointer exception from version check fixed.
- Bandwith synch bug when a cluster node died fixed.
- Block redirection not working on SSL bug fixed.


2014/03/30, v2.0.0
- New GUI component layer for easy customization applied.
- Google chart introduced for dashboard and report.
- Weekly report added.
- Block-page edit, preview on GUI supported.
- 'Config > alert' menu separated.
- Alert period introduced.
- Detailed statstics with request-count, request-sum and ip-count.
- no-user, no-grp introduced for default user and group name.
- Login redirection using login domain.
- Admin name introduced.
- 'Config > admin-pw' -> 'Config > admin'.
- user_ip index added.
- history_retention_period -> log_retention_period
- history -> log.
- OpenLDAP, eDirectory support removed.
- Variable names in access_violation.ftl changed.
- Use update button to change login-token.
- LDAP period caculation algorithm changed.
- div.hr class replacing hr tag for IE compatibility.
- Row highlight for list introduced.


2014/03/10, v1.7.6
- Alert interval changed to 5 minutes.
- Include SRV record for category lookup.
- RecordSet not closing bug from config, report fixed.
- Embedded Tomcat updated to v7.0.52.
- max_domain_len adjusted to between 0 and 1000.


2014/02/10, v1.7.5
- Alert email sender changed to admin email.
- Zone-transfer test button added.
- reset_acl util script added.
- table.view class added into common.css.
- log_blocked_only option added into cfg.properties.
- PTR record excluded from domain length checking.
- DB connection not closing bug after bandwidth data loading fixed.


2014/01/06, v1.7.4
- IE, Chrome compatibility enhanced for HR tag color.
- Stops on binding error for UDP 53 port.
- Zone-transfer interval adjusted to 5 seconds.
- Bypassing DDNS update message for Active Directory.
- File not close bug fixed on Logging > request.
- admin_pw removed from Config, Wonfig.


2013/12/20, v1.7.3-p1
- 'RF token' changed to 'Login token'.
- 'RF block redirection IP' changed to 'External redirection IP'.
- preferIPv4Stack option enabled for Tomcat.
- Time difference between user report and global report fixed.
- Policy specific ad-remove option added.
- Top 5 category chart added into dashboard.
- User specific top 5 category chart added into 24 hour report.
- Active Directory connection timeout changed to 5 seconds.
- Active Directory read timeout changed to 20 seconds.
- delete_old applied to signal and netflow data.
- Traffic column not updating for reducing update time.


2013/11/14, v1.7.2
- Changed several menu names, history -> logging or request.
- Fast-flux detection not disabled bug fixed.
- Domain lookup speed improved with new caching algorithm.
- Firewall rule added for TCP 80 port on Windows installer.


2013/10/27, v1.7.1
- Tutorial link added into the top menu.
- 'Response cache size' option moved into 'Config > config > DNS setup'.
- Connection pool leak on 'Config > config' fixed.
- SRV query excluded from domain name length filtering.
- GUI design layout changed.


2013/10/14, v1.7.0
- GUI view layer changed to JSP.
- Changing GUI template directory made to be possible.
- 'ad-remove' category introduced for removing embedded adverts.
- Initial password information added to admin login-page.
- 'Config > config' not updating bug fixed.


2013/10/09, v1.6.2
- Uncaught exception handler added for worker threads.
- Pagination HTML tag bug fixed.
- Admin domain added for accessing GUI using domain.


2013/10/05, v1.6.1
- local_dns, local_domain options added for bypassing NxFilter.


2013/09/22, v1.6.0
- Shallalist support added.
- Auto-backup retention period added.
- User select box error with IE, Chrome on report page fixed.
- Checking for URL insertion on whitelist by domain added.
- DB Query timeout applied for GUI.
- Script name changed, update-bl.bat to update_bl.bat.


2013/09/15, v1.5.4
- Bandwidth control added.
- Duplicated TTL manipulating routine removed.
- AD/LDAP login-page username changed to case-insensitive.
- Policy update error with empty category bug fixed.
- Username not found exception on per-user report fixed.


2013/08/29, v1.5.3
- User identification by ip-session comes before IP based user.
- Communication for history in clustering works asynchronous way.
- IP binding with local connection bug fixed.


2013/08/26 v1.5.2
- IP binding added.
- One to many relationship applied for whitelist and policy.
- Default list size of history, signal search changed to 200.
- CSV file export added for history.
- User, group relation not deleted on AD import bug fixed.


2013/08/19, v1.5.1
- OpenLDAP integration support added.
- Novell eDirectory integration support added.
- Client IP shown on user selection for per-user basis report.
- Clear button added in 'History > history' and 'History > signal'.
- Admin password reset util script added.


2013/08/10, v1.5.0
- Category top 5 chart added.
- Setting 'Max domain length' in policy not to 0 fixed.
- List order in GUI changed to ignore the case.
- Concurrency issue with block-page fixed.


2013/07/27, v1.4.9
- 'Block unclassified' option added into policy.
- DB connection not return bug on 'User > active-directory > import' fixed.
- Empty group allowed from AD import.


2013/07/21, v1.4.8
- User specific report added.
- User, Client IP linked in 'History > signal'.
- Exact matching keyword introduced into history search.


2013/07/14, v1.4.7
- Auto-backup for config DB added.
- Typo on 'Response cache size' removed.
- User, group, policy search option link on 'History > history'.
- Initial DB connection will be tried for 1 minute until it gets connected.
- http_port, https_port parameter added into cfg.properties.
- Group filter missing after navigation in history search fixed.


2013/07/07, v1.4.6
- IP based ACL for cluster node applied to database connection.
- Sending success message to NxUpdate.
- Bypassing AD update when it gets an empty data set.


2013/06/29, v1.4.5
- Dynamic IP update for client added.
- bypass_filter on per-policy whitelist enabled.
- Duplicated domain, keyword on whitelist allowed.
- Expiration-date display bug fixed.
- Quota reset bug fixed.


2013/06/25, v1.4.4
- Zone-transfer on AD import bug fixed.


2013/06/23, v1.4.3
- Per-policy whitelist/blacklist added.
- Response cache size option added.
- AD importation of computer account bug fixed.
- Default value for 'Max domain length' changed to 64.


2013/06/13, v1.4.2
- Zone transfer function added.
- Admin password reloading bug fixed.


2013/06/08, v1.4.1
- SPF record detection moved into 'covert channel'.
- Covert channel detection on CNAME, SRV response record added.


2013/06/01, v1.4.0
- Malware/Botnet detection added.
- Inspection on response packet added.
- DNS record type added in history, syslog exportation.
- Domain property added to active directory data.
- User move bug in group edit fixed.


2013/05/17, v1.3.1
- Alert mailing system revised.
- Time format changed in access violation email.
- Clustering node down alert email added.
- Whitelist overrides phishing protection.
- Simpler management for phishing protection.


2013/05/06, v1.3.0
- Load-balancing and fail-safe with clustering added.
- Login to multiple server function for nxlogon added.
- Opening Windows firewall port from the installer.
- prunsrv.exe for AMD64, IA64 removed from the package.
- NxClient separated from the package.


2013/04/22, v1.2.0
- Remote filtering client added.
- Auto-detection for 'NX_HOME' added.


2013/04/07, v1.1.5
- Expiration date for user account added.
- Checking JRE version from the Windows installer.
- Installing service option from the Windows installer.
- Bug fixed, user password update bug fixed.
- Bug fixed, ignore the DNS resolvers not responding.
- Bug fixed, logout not closing socket connection fixed.


2013/03/19, v1.1.4
- SRV record excluded from local DNS cache.
- Logoff script added for Active Directory.
- IP based ACL replaced to simpler one.
- IP based ACL for admin GUI added.
- Bug fixed, apply custom categories against IDN.


2013/03/12, v1.1.3
- Phishing protection overrides 'log_only' option in policy.
- 'admin_block' in whitelist overrides 'log_only' option in policy.
- Using '*' for including subdomains in whitelist and custom category.
- Summary statistics added in dashboard and report.


2013/03/07, v1.1.2
- System categories will not be appeared in policy-edit before populated.
- Bug fixed, Multi-category bug fixed.
- Bug fixed, default data for lunch-time bug fixed.


2013/03/01, v1.1.1
- Phishing DB update bug fixed.
- History search bug fixed.


2013/02/25, v1.1
- Phishing protection added.
- link to domain in history added.
- Bug fixed, free-time bug fixed.
- Bug fixed, group member assignment bug fixed.


2013/02/12, v1.0
- Single sign-on with Active Directory added.
- Dual policy setup, You can have work-time policy and free-time policy
  for user and group.
- Template for new policy creation added.
- 'Quota all' option for applying quota to all domain added.
- Javascript confirm message added for deleting data.
- IE compatibility improved.


2013/01/30, v0.91
- Mass toggle for blocked categories added.
- Syslog exportation added.
- Quota time added.
- Bug fixed, history, report custom date bug fixed.
- Bug fixed, possible deadlock in internal socket fixed.
