# Configuration for Components that should be running on this server
#
# Instructions for this file:
# 1) The first option is the identifier of the service, just a descriptive name, such as optier-cftools
# 2) stringMatch is the string to match in the ps output
# 3) startupScript is the startup script for the service
# 3) stopScript is the stop script for the service
# 4) NOTES is an optional value to give some additional info about the service
#
# 20111027 - eli.rodriguez@optier.com - initial creation
#
%configuration = (
	'optier-cftools' => 
	{
		'stringMatch' => 'com.optier.corefirst.plugin.j2ee.extension.administration.TEAdminAutomatic',
                'startupScript' => 'cd /opt/optiercf/optier-cftools/cf-tools/bin ; ./run_call_teAdminAuto.sh',
		'stopScript' => 'To stop, ps -elfa|grep TEAdminAutomatic and kill the process id',
		'LOGS' => '/opt/optiercf/optier-cftools/corefirst/logs/cf-TEAdminAutomatic.log',
	},
	'BTM-Analysis' => 
        {
		'stringMatch' => ' analysis',
		'startupScript' => '/opt/optiercf/optier-server/corefirst/bin/start-analysis.sh',
		'stopScript' => '/opt/optiercf/optier-server/corefirst/bin/stop-analysis.sh',
		'NOTES' => 'Database: wppra00a0090.wellsfargo.com (w802p1.wellsfargo.com) SID: w802p1',
                'LOGS' => '/opt/optiercf/optier-server/corefirst/logs/analysis/cf-server.log'
	},
	'BTM-UI' => 
        {
		'stringMatch' => ' profiler',
		'startupScript' => '/opt/optiercf/optier-server/corefirst/bin/start-ui.sh',
		'stopScript' => '/opt/optiercf/optier-server/corefirst/bin/stop-ui.sh',
		'NOTES' => 'Database: wppra00a0090.wellsfargo.com (w802p1.wellsfargo.com) SID: w802p1',
                'LOGS' => '/opt/optiercf/optier-server/corefirst/logs/ui/cf-server.log'
	},
       'OracleDB' =>
        {
                'stringMatch' => ' ora_pmon_w802p1',
                'startupScript' => "Contact DBA
                DBA Primary: taipei.chen\@wellsfargo.com, Secondary: vinay.madasu\@wellsfargo.com\n\t\tGroup Email: G=WDAI-IAMS-ORACLE,Pac2k Group: WHLSTECHDBAOracleManagedSrvcs",
                'stopScript' => 'Contact DBA',
                'NOTES' => 'SID: w802p1'
        },
	'Oracle Listener' => 
	{
		'stringMatch' => ' LISTENER_W802P1| listener_| listener | LISTENER  ',
                'startupScript' => "Contact DBA
                DBA Primary: taipei.chen\@wellsfargo.com, Secondary: vinay.madasu\@wellsfargo.com\n\t\tGroup Email: G=WDAI-IAMS-ORACLE,Pac2k Group: WHLSTECHDBAOracleManagedSrvcs",
                'stopScript' => 'Contact DBA',
                'NOTES' => 'SID: w802p1'
	},
        'BDA-Cassandra-node'=>
        {
                'stringMatch' => ' org.apache.cassandra.service.CassandraDaemon',
                'startupScript' => '/opt/optiercf/optier-cassandra/cassandra/bin/cassandra',
                'stopScript' => '/opt/optiercf/optier-cassandra/cassandra/bin/stop-server',
                'NOTES' => "Data written to: /opt/optiercf/optier-cassandra/var/lib/cassandra\n\tClustered with: wppra00a0091,wupra00a0052",
                'LOGS' => "/opt/optiercf/optier-cassandra/var/log/cassandra/system.log",
        },

);

