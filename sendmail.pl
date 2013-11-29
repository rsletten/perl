#!/usr/bin/perl
#
# Send the corefirst access logs summary output.
#
use Net::SMTP;

print "INFO: Sending email...\n";
#@emailTo = ("eli.rodriguez\@optier.com","dan.barr\@optier.com","anitha.vojjala\@wachovia.com");
#@emailTo = ("elias.rodriguez\@wellsfargo.com");
@emailTo = ("eli.rodriguez\@optier.com");
while(<>) 
{
	$data .= $_;
}

#$smtp = Net::SMTP->new('imc.capmark.funb.com');
#$smtp = Net::SMTP->new('cpowhl.wellsfargo.com', Debug=> 1);
$smtp = Net::SMTP->new('cpowhl.wellsfargo.com');

$smtp->mail('eli.rodriguez@optier.com');
$smtp->to(@emailTo);

$smtp->data();
$smtp->datasend("To: @emailTo\n");
$smtp->datasend("Subject: Message from " . `hostname` . "\n");
$smtp->datasend("\n");
$smtp->datasend("$data\n");
$smtp->dataend();

$smtp->quit;
print "INFO: Email sent...\n";
