#!/usr/bin/perl
use lib "./RPC-XML-0.67/lib";

#Added to Git
use RPC::XML;
use RPC::XML::Client;
my $host    = $ARGV[0];
 my $port    = $ARGV[1];
my $LanUnit = $ARGV[2];
my $State   = $ARGV[3];
my $Message = $ARGV[4];
my $res;

#my $ManagedEntity = 'ME_TEST';
my $ManagedEntity = 'ME_API';
my $Sampler       = 'API_SAMPLER';
 my $Group         = 'ME_API';
my $View          = 'View1';
my $GeneosString = $ManagedEntity . '.' . $Sampler . '.' . $View. '-' . $Group;
my $client = new RPC::XML::Client 'http://' . $host . ':' . $port . '/xmlrpc';

sub printresultnew {
        my $res = $_[0];
        if ($res->value ne "OK") {
        print "Response type - " .$res->type ."\n";
        print "Response string - " .$res->as_string ."\n";
         }
        else {
                print "Response value - " .$res->value ."\n";
        }

}

sub GatewayConnected {
        print "--------------------------------------\n";

        my $ManagedEntity = $_[0];
        my $req =
          RPC::XML::request->new( '_netprobe.gatewayConnected');
        my $res = $client->send_request($req);

        print "Gateway Connected - Printing Result\n";
         printresultnew($res);

        #Returns true or false

        if ($res->as_string eq  "<boolean>1</boolean>") {
                return 1;
        }else{
                return 0;
         }

}


sub ManagedEntityExists {
        print "--------------------------------------\n";
       my $ManagedEntity = $_[0];
        my $req =
          RPC::XML::request->new( '_netprobe.ManagedEntityExists', $ManagedEntity );
         my $res = $client->send_request($req);

        print "ManagedEntity Name: " . $ManagedEntity . "\n";
        print "ManagedEntityExists - Printing Result\n";
        printresultnew($res);

        if ($res->as_string eq  "<boolean>1</boolean>") {
                return 1;
        }else{
                return 0;
        }


}
        
sub SamplerExists {
         print "--------------------------------------\n";

        my $Sampler = $_[0];
        my $req     = RPC::XML::request->new( '_netprobe.SamplerExists', $Sampler );
        my $res     = $client->send_request($req);
         print "Sampler Name: " . $Sampler . "\n";
        print "Sub SamplerExists - Printing Result\n";
        printresultnew($res);

       #Returns true or false
        if ($res->value ne "OK") {
                 return 0
        }else{
                return $res;
        }
}

sub ColumnCount {
        print "--------------------------------------\n";

        my $GeneosString = $_[0];
         my $req = RPC::XML::request->new( $GeneosString . '.getColumnCount' );
        my $res = $client->send_request($req);

        print "Sub ColumnCount - Printing Result\n";
        printresultnew($res);

        #Returns a int
        return $res;
}

sub ViewExists {
        print "--------------------------------------\n";

        my $ManagedEntity = $_[0];
        my $Sampler       = $_[1];
         my $Group         = $_[2];
        my $View          = $_[3];
        my $req = RPC::XML::request->new(
                                                   $ManagedEntity . '.' . $Sampler . '.' . 'viewExists',
                                                    $View. '-' . $Group);
        my $res = $client->send_request($req);

        print "View  Name: " .  $View . "\n";
        print "Group Name: " .  $Group . "\n";
         print "Sub ViewExists Printing Result\n";
        printresultnew($res);

        #Returns true or false
        return $res;
}

sub CreateView {
        print "--------------------------------------\n";

        my $ManagedEntity = $_[0];
        my $Sampler       = $_[1];
        my $Group         = $_[2];
        my $View          = $_[3];
        my $req =
          RPC::XML::request->new( $ManagedEntity . '.' . $Sampler . '.createView',
                                                           $View, $Group );
        my $res = $client->send_request($req);

        print "Sub Creating View - Printing Result\n";
        printresultnew($res);
         return $res;
}

sub CreateTable {
        print "--------------------------------------\n";

        my $GeneosString = $_[0];
        my $LanUnit      = $_[1];

        #Create Table
         $req = RPC::XML::request->new( $GeneosString . '.addTableColumn', 'name' );
        $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.addTableColumn', 'State' );
         $res = $client->send_request($req);
        $req =
          RPC::XML::request->new( $GeneosString . '.addTableColumn', 'Message' );
        $res = $client->send_request($req);
         $req = RPC::XML::request->new( $GeneosString . '.addTableRow', $LanUnit );
        $res = $client->send_request($req);

        print "Sub Creating Table - Printing Result\n";
         printresultnew($res);
 
}


sub updatecell {
my $GeneosString = $_[0];
my $row = $_[1];
my $column = $_[2];
my $value = $_[3];
	$req = RPC::XML::request->new( $GeneosString . '.updateTableCell',$row . '.' . $column, $value);
return $req;
}


sub UpdateTable {

        #Update Table Cells
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row1.ColA', '1' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row1.ColB', '2' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row1.ColC', '3' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row2.ColA', '4' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row2.ColB', '5' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row2.ColC', '6' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row3.ColA', '7' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row3.ColB', '8' );
         $res = $client->send_request($req);
        $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                   'Row3.ColC', '9' );
         $res = $client->send_request($req);
}

sub createHeadline {

        #CREATE a headline
        my $req =
          RPC::XML::request->new( $GeneosString . '.addHeadline', 'Headline' );
         my $res = $client->send_request($req);
        return $res;
}

sub ContinualUpdate {

        # time in secs between updates
        $sleep_secs = 0.10;
        $val        = 10;

         # initial headline value
        $hl_val = 0;

        #Update Table Cells
        while (1) {
                $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                            'Row1.ColA', $val );
                $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                 $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                           'Row1.ColB', $val );
                 $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                            'Row1.ColC', $val );
                $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                 $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                           'Row2.ColA', $val );
                 $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                            'Row2.ColB', $val );
                $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                 $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                           'Row2.ColC', $val );
                 $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                            'Row3.ColA', $val );
                $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                 $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                           'Row3.ColB', $val );
                 $res = $client->send_request($req);
                select( undef, undef, undef, $sleep_secs );
                $val++;
                $req = RPC::XML::request->new( $GeneosString . '.updateTableCell',
                                                                            'Row3.ColC', $val );
                $res = $client->send_request($req);

                #Update the headline
                $hl_val++;
                 my $req = RPC::XML::request->new( $GeneosString . '.updateHeadline',
                                                                                  'Headline', $hl_val );
                my $res = $client->send_request($req);
                 select( undef, undef, undef, $sleep_secs );
        }
}

#Check if we are connected to a Gateway
print "********************************\n";
print "********************************\n";
 print "Checking if connected to a Gateway\n";
if ( GatewayConnected() == 0 ) {
        print "Gateway Not connected. Exiting..\n";
        exit;
}

#Check if the ME exists#
print "********************************\n";
 print "********************************\n";
print "Checking if ManagedEntity Exists\n";
if ( ManagedEntityExists($ManagedEntity) == 0 ) {
        print "Managed Entity does not exist. Exiting..\n";
         exit;
}

# Check if the Sampler existsA
print "********************************\n";
print "********************************\n";
print "Checking if Sampler Exists\n";
 if (SamplerExists($Sampler) == 0 ) {
        print "Sampler does not exist. Exiting..\n";
        exit;
} else {
        print "Sampler Exists.\n";
}

# Check if the View Exists.
 print "********************************\n";
print "********************************\n";
print "Checking if View Exists\n";
if ( ViewExists($ManagedEntity,$Sampler,$Group,$View) == 0 ) {
         print "View does not exist. Creating..\n";
        CreateView($ManagedEntity,$Sampler,$Group,$View);
        print "View Created\n";
}

print "********************************\n";
 print "********************************\n";
print "Checking if Columns Exists\n";
# Check if the 3 Columns Exist
$res = ColumnCount($GeneosString);
if ( $res == 3 ) {
        print "3 Columns exists. Continuing..\n";
 } else {
        print "Other than 3 columns exist: " . $res . " returned";
}
