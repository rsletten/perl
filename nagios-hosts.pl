#!/usr/bin/perl
##
# Rob Sletten
##

use strict;
use warnings;

my $dafile=$ARGV[0];
my $cfserver=$ARGV[1];

open(my $infile, "<", "$dafile") or die("Unable to open ${dafile}: $!");
my @data = <$infile>;

my $outhost="${cfserver}-hosts.cfg";
my $groupout="${cfserver}-group.cfg";
open(my $outfile, ">", $outhost) or die("Unable to open $outhost: $!");
open(my $outgroup, ">", $groupout) or die("Unable to open $groupout: $!");

$outgroup->printf(<<HOST);
define hostgroup{
        hostgroup_name          ${cfserver}_CAs
        alias                   ${cfserver} CAs 
HOST

$outgroup->print("        members                 ");
foreach my $line (@data)
{
  chomp($line); 
  my ($hostname, $hostaddr, $caport) = split / /, $line;
  my ($alias) = "$hostname-$caport";
  $outfile->printf(<<HOST, $hostname, $caport, $hostname, $caport,  $hostaddr, $caport);
define host{
            use 3cf1CA-hosts 
            host_name %s-%s
            alias %s-%s
            address %s
            _CAPORT %s
            }
HOST

  chomp($hostname);
  $outgroup->print("$alias, ");

}

$outgroup->printf("\n	}");

close($outfile);
close($infile);
close($outgroup);
