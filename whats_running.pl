#!/usr/bin/perl -w
#
#
#
# 20111027 - eli.rodriguez@optier.com - Display OpTier CoreFirst component status, start/stop script, and other info
#					It is NOT a health check, just a process check.


# Configuration file containing components to check
$componentsConfigFile = "/opt/optiercf/OPTIER_COMPONENTS.pl";
#my $componentsConfigFile = "testcfg.cfg";

#require "$componentsConfigFile";
use Getopt::Std;
use Safe;
use Data::Dumper;

#my %hash =();
my $line;
my %options=();

# Parse command line options
getopts("hvsxnl",\%options);
usage() if (defined($options{h}));

# Get our configuration information
if (my $err = ReadCfg($componentsConfigFile)) {
    print(STDERR $err, "\n");
    exit(1);
}

#print Data::Dumper::Dumper(%CFG::configuration);

#foreach my $key (keys %CFG::configuration) {
#	print "key: $key\n";
#	print "\tStringMatch: $CFG::configuration{$key}->{stringMatch}\n";
#}
#exit(0);


# Reset all configured components to not found
foreach my $key (keys %CFG::configuration) {
	$CFG::configuration{$key}->{found}=0;
}

# ps outputs PID, START TIME and ARGS to parse and compare against.
my $psCommand = "ps -eo pid,start_time,args";
open(PIN,"$psCommand|") || die "ERROR: Cannot run $psCommand : $!\n";
while(<PIN>) {
	# Check if the component is running
	foreach my $key (keys %CFG::configuration) {
		if (/$CFG::configuration{$key}->{stringMatch}/) {
			
#			print "LINE: $_\n";
			$CFG::configuration{$key}{found} = 1;
			#($CFG::configuration{$key}{pid}, $CFG::configuration{$key}{started}) = (split(/\s+/))[3,11];
			($CFG::configuration{$key}{pid}, $CFG::configuration{$key}{started}) = getPIDStartTime($_);
			#$hash{$key}{started} = (split(/ /))[12];
		}
	}
}

# Display results
foreach my $key (sort keys %CFG::configuration) {
	# Service not found running.
	if ($CFG::configuration{$key}{found} == 0 ) {
		print "\nWARN: $key service is not running\n";
		print "\tStartup: $CFG::configuration{$key}{startupScript}\n";
		print "\tLOGS: $CFG::configuration{$key}{LOGS}\n" if ($CFG::configuration{$key}{LOGS});
		# specified stop script or verbose on command line
		if ( defined($options{x}) || defined($options{v}) ) {
			print "\tStop: $CFG::configuration{$key}{stopScript}\n";
		}
		# Show notes when not running
		if ($CFG::configuration{$key}{NOTES}) {
			print "\tNOTES: $CFG::configuration{$key}{NOTES}\n";
		}

	# Service running.
	} else {
		print "\nINFO: $key service is running under PID $CFG::configuration{$key}{pid} started on $CFG::configuration{$key}{started}\n";
		# specified start script or verbose on command line
		if ( defined($options{s}) || defined($options{v}) ) {
			print "\tStartup: $CFG::configuration{$key}{startupScript}\n";
		}
		# specified stop script or verbose on command line
		if ( defined($options{x}) || defined($options{v}) ) {
			print "\tStop: $CFG::configuration{$key}{stopScript}\n";
		}
		# specified notes or verbose on command line
		if ( defined($options{v}) || defined($options{n}) ) {
			if ($CFG::configuration{$key}{NOTES}) {
				print "\tNOTES: $CFG::configuration{$key}{NOTES}\n";
			}
		}
		# specified logs or verbose on command line
		if ( defined($options{v}) || defined($options{l}) ) {
			if ($CFG::configuration{$key}{LOGS}) {
				print "\tLOGS: $CFG::configuration{$key}{LOGS}\n";
			}
		}
	}
}
close(PIN);

# Set pid and started time from ps -eo pid,start_time,args command.
sub getPIDStartTime {
	# strip leading and trailing whitespace
        $_ =~ s/^\s+//;
        $_ =~ s/\s+$//;

	my ($procID,$startDate) = (split(/\s+/,$_))[0,1];
	#print "PID=$procID,startDate=$startDate\n";
	return $procID,$startDate;
}

sub usage {
	print <<USAGE;
	whats_running.pl  - Displays OpTier CoreFirst component status and stop/start scripts for those components
			    It is NOT a health check, just a process check.


	$0 [-h] [-v] [-s] [-x] [-n] [-l]

	Where
		-h - display help
		-v - verbose
		-s - display start scripts
		-x - display stop scripts
		-n - display any notes for service (optional, and not all entries will have this)
		-l - Location of log file or log directory

USAGE
	exit(0);
}

# Read a configuration file
#   The arg can be a relative or full path, or
#   it can be a file located somewhere in @INC.
sub ReadCfg
{
    my $file = $_[0];

    our $err;

    {   # Put config data into a separate namespace
#        package CFG;

        # Process the contents of the config file
    #    my $rc = do($file);
       # Put config data into a separate namespace
	my $comp = new Safe 'CFG';
        my $rc = $comp->rdo($file);

        # Check for errors
        if ($@) {
            $::err = "ERROR: Failure compiling '$file' - $@";
        } elsif (! defined($rc)) {
            $::err = "ERROR: Failure reading '$file' - $!";
        } elsif (! $rc) {
            $::err = "ERROR: Failure processing '$file'";
        }
    }

    return ($err);
}

