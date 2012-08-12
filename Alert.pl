#Added to Git
use RPC::XML;
use RPC::XML::Client;

my $host    = $ARGV[0];
my $port    = $ARGV[1];
my $LanUnit = $ARGV[2];
my $State   = $ARGV[3];
my $Message = $ARGV[4];

my $res;

my $ManagedEntity = 'ME_API';
my $Sampler       = 'API_SAMPLER';
my $Group         = 'ME_API';
my $View          = 'View1';
my $GeneosString = $ManagedEntity . '.' . $Sampler . '.' . $Group . '-' . $View;

my $client = new RPC::XML::Client 'http://' . $host . ':' . $port . '/xmlrpc';

sub ManagedEntityExists {
	my $ManagedEntity = $_[0];

	my $req =
	  RPC::XML::request->new( '_netprobe.ManagedEntityExists', $ManagedEntity );
	my $res = $client->send_request($req);

	#Returns true or false
	return $res;
}

sub SamplerExists {
	my $Sampler = $_[0];

	my $req = RPC::XML::request->new( '_netprobe.SamplerExists', $Sampler );
	my $res = $client->send_request($req);

	#Returns true or false
	return $res;
}

sub ColumnCount {
	my $GeneosString = $_[0];

	my $req = RPC::XML::request->new(
		$GeneosString . 'getColumnCount');
	my $res = $client->send_request($req);

	#Returns a int
	return $res;
}

sub ViewExists {
	my $ManagedEntity= $_[0];
	my $Sampler = $_[1];
	my $Group   = $_[2];
	my $View    = $_[3];

	my $req = RPC::XML::request->new(
		$ManagedEntity . '.' . $Sampler . '.' . 'viewExists',
		$Group . '-' . $View );
	my $res = $client->send_request($req);

	#Returns true or false
	return $res;
}

sub CreateView {
	my $ManagedEntity = $_[0];
	my $Sampler       = $_[1];
	my $Group         = $_[2];
	my $View          = $_[3];

	my $req =
	  RPC::XML::request->new( $ManagedEntity . '.' . $Sampler . '.createView',
		$View, $Group );
	my $res = $client->send_request($req);
	return $res;
}

sub CreateTable {
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

	$val = 10;

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

sub PrintResult {
	if ( $res->value ne "OK" ) {
		print "Response type - " . $res->type . "\n";
		print "Response string - " . $res->as_string . "\n";
	}
	else {
		print "Response value - " . $res->value . "\n";
	}
}

#Check if the ME exists
if ( ManagedEntityExists($ManagedEntity) == 0 ) {
	print "Managed Entity does not exist. Exiting..";

}
else {
	print "Managed Entity exists. Continuing..";
	
	# Check if the Sampler exists
	if ( ManageduEntityExists($ManagedEntity) == 0 ) {
		print "Sampler does not exist. Exiting..";

	}
	else {
		print "Sampler exists. Continuing..";
		# Check if the 3 Columns Exist
		
		$res=ColumnCount($GeneosString);
		
		if ( $res == 3) {
			print "3 Columns exists. Continuing..";
		}
		else {
			print "Other than 3 columns exist: " .$res . " returned"; 
		}
	}
}

