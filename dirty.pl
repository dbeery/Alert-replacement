#!/usr/local/bin/perl
use lib "./RPC-XML-0.67/lib";
use RPC::XML;
use RPC::XML::Client;
my $DEBUG_SWITCH = "off";

#Define Geneos Parts
 my $host    = 'localhost';
my $port    = '6969';
my $sampler = 'API_Sampler';
my $me      = 'ME_API';
my $LanUnit = $ARGV[0];
my $view    = $LanUnit;
my $group   = 'Alert';
 my $client  = new RPC::XML::Client 'http://' . $host . ':' . $port . '/xmlrpc';

#Define the Alert
my $TimeStamp  = localtime(time);
my $hostname   = `hostname`;
my $domainname = `domainname`;

my $String  = $ARGV[1];
my @String  = split( / /, $String, 2 );
my $State   = $String[0];
my $Message = $String[1];
if ( $DEBUG_SWITCH eq "on" ) {
    print "State: " . $State . "\n";
     print "Message: " . $Message . "\n";
}

sub printresult {
    my $res = $_[0];
    if ( $DEBUG_SWITCH eq "on" ) {
        print "Response value  - " . $res->value . "\n";
         print "Response type   - " . $res->type . "\n";
        print "Response string - " . $res->as_string . "\n";
        print "----------------";
    }
 }

#CREATE a view
my $req = RPC::XML::request->new( $me . '.' . $sampler . '.' . 'createView',
                                  $view, $group );
my $res = $client->send_request($req);
 printresult($res);



################################################################################################################
#
# Create Table
#
#Add Columns
$req = RPC::XML::request->new(
           $me . '.' . $sampler . '.' . $group . '-' . $view . '.addTableColumn',
          'LanUnit' );
$res = $client->send_request($req);
printresult($res);
$req = RPC::XML::request->new(
           $me . '.' . $sampler . '.' . $group . '-' . $view . '.addTableColumn',
          'State' );
$res = $client->send_request($req);
printresult($res);
sleep 1;
 $req = RPC::XML::request->new(
          $me . '.' . $sampler . '.' . $group . '-' . $view . '.addTableColumn',
          'Message' );
$res = $client->send_request($req);
 printresult($res);
$req = RPC::XML::request->new(
          $me . '.' . $sampler . '.' . $group . '-' . $view . '.addTableColumn',
          'TimeStamp' );
$res = $client->send_request($req);
 printresult($res);

#Add Row
$req = RPC::XML::request->new(
             $me . '.' . $sampler . '.' . $group . '-' . $view . '.addTableRow',
             $LanUnit );
$res = $client->send_request($req);
 printresult($res);


################################################################################################################
#
# Update Table
#
$req = RPC::XML::request->new(
         $me . '.' . $sampler . '.' . $group . '-' . $view . '.updateTableCell',
          $LanUnit . '.LanUnit', $LanUnit );
$res = $client->send_request($req);
printresult($res);
$req = RPC::XML::request->new(
         $me . '.' . $sampler . '.' . $group . '-' . $view . '.updateTableCell',
          $LanUnit . '.State', 'started' );
$res = $client->send_request($req);
printresult($res);
$req = RPC::XML::request->new(
         $me . '.' . $sampler . '.' . $group . '-' . $view . '.updateTableCell',
          $LanUnit . '.Message', $Message );
$res = $client->send_request($req);
printresult($res);
$req = RPC::XML::request->new(
         $me . '.' . $sampler . '.' . $group . '-' . $view . '.updateTableCell',
          $LanUnit . '.TimeStamp', $TimeStamp );
$res = $client->send_request($req);
printresult($res);
