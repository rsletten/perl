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
	'dtcollectorv42-silas' => 
	{
		'stringMatch' => '-name dtcollectorv42-silas',
                'startupScript' => 'cd /opt/dynatrace/dynatrace-4.2.0/init.d ; ./dynaTraceCollector-dtcollectorv42-Silas start',
		'stopScript' => 'cd /opt/dynatrace/dynatrace-4.2.0/init.d ; ./dynaTraceCollector-dtcollectorv42-Silas stop',
                'LOGS' => 'Log files in /opt/dynatrace/dynatrace-4.2.0/log/collector/dtcollectorv42-silas/dtcollectorv42-silas.0.0.log'

	},
	'dynatrace-server-v5' => 
        {
		'stringMatch' => '/opt/dynatrace/dynatrace-5.0.0/dtserver',
		'startupScript' => 'cd /opt/dynatrace/dynatrace-5.0.0 ; ./dynaTraceServer start',
		'stopScript' => 'cd /opt/dynatrace/dynatrace-5.0.0 ; ./dynaTraceServer stop',
		'NOTES' => "Database: mcib3iiid002.cibana.msds.wachovia.net INSTANCE:DYNADEV PORT:11000 Database:Dynatrace5
                DBA Primary: brian.nall\@wellsfargo.com\n\t\tGroup Email: G=WDAI-IAMS-MSSQL,Pac2k Group: WHLSTECHDBASQLSrvrManagedSrvcs",
                'LOGS' => '/opt/dynatrace/dynatrace-5.0.0/log/server/Server.0.0.log'
	},
	'dynatrace-analysisServer-v5' => 
        {
		'stringMatch' => '/opt/dynatrace/dynatrace-5.0.0/dtanalysisserver',
		'startupScript' => '/opt/dynatrace/dynatrace-5.0.0/init.d/dynaTraceAnalysis start',
		'stopScript' => '/opt/dynatrace/dynatrace-5.0.0/init.d/dynaTraceAnalysis stop',
                'LOGS' => '/opt/dynatrace/dynatrace-5.0.0/log/analysisserver/analysisserver.0.0.log'
	},
	 'dynatrace-analysisServer-v42' =>
        {
                'stringMatch' => '/opt/dynatrace/dynatrace-4.2.0/dtanalysisserver',
                'startupScript' => '/opt/dynatrace/dynatrace-4.2.0/init.d/dynaTraceAnalysis start',
                'stopScript' => '/opt/dynatrace/dynatrace-4.2.0/init.d/dynaTraceAnalysis stop',
                'LOGS' => '/opt/dynatrace/dynatrace-4.2.0/log/analysisserver/analysisserver.0.0.log'
        },

        'dynatrace-server-v42' =>
        {
                'stringMatch' => '/opt/dynatrace/dynatrace-4.2.0/dtserver',
                'startupScript' => 'cd /opt/dynatrace/dynatrace-4.2.0/init.d ; ./dynaTraceServer start',
                'stopScript' => 'cd /opt/dynatrace/dynatrace-4.2.0 ; ./dynaTraceServer stop',
                'NOTES' => "Database: mcib3iiid002.cibana.msds.wachovia.net INSTANCE:DYNADEV PORT:11000 Database:Dynatrace42
                DBA Primary: brian.nall\@wellsfargo.com\n\t\tGroup Email: G=WDAI-IAMS-MSSQL,Pac2k Group: WHLSTECHDBASQLSrvrManagedSrvcs",
                'LOGS' => '/opt/dynatrace/dynatrace-4.2.0/log/server/Server.0.0.log'
        },

        'dtcollectorv50-silas' =>
        {
                'stringMatch' => '-name dtcollectorv50-silas',
                'startupScript' => 'cd /opt/dynatrace/dynatrace-5.0.0 ; ./dynaTraceCollector-dtcollectorv50-Silas start',
                'stopScript' => 'cd /opt/dynatrace/dynatrace-5.0.0 ; ./dynaTraceCollector-dtcollectorv50-Silas stop',
                'LOGS' => 'Log files in /opt/dynatrace/dynatrace-5.0.0/log/collector/dtcollectorv50-silas/dtcollectorv50-silas.0.0.log'

        }

);

