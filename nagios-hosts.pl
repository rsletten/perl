#!/usr/bin/perl

use strict;
use warnings;

open(my $infile, "<", "data.txt") or die("Unable to open data.txt: $!");
my @data = <$infile>;

my $outhost="hosts.cfg";
my $groupout="hostgroup.cfg";
open(my $outfile, ">", $outhost) or die("Unable to open $outhost: $!");
open(my $outgroup, ">", $groupout) or die("Unable to open $groupout: $!");

$outgroup->printf(<<HOST);
define hostgroup{
        hostgroup_name          3cf1_CAs
        alias                   Monitored CAs 
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
