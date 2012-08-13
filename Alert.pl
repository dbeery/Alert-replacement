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
        print "Response value - " .$res->value ."\n";
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
print "\n\n********************************\n";
print "********************************\n";
print "Checking if connected to a Gateway\n";
if ( GatewayConnected() == 0 ) {
        print "Gateway Not connected. Exiting..\n";
        exit;
}

#Check if the ME exists
print "\n\n********************************\n";
print "********************************\n";
print "Checking if ManagedEntity Exists\n";
if ( ManagedEntityExists($ManagedEntity) == 0 ) {
        print "Managed Entity does not exist. Exiting..\n";
        exit;
}

# Check if the Sampler exists
print "\n\n********************************\n";
print "********************************\n";
print "Checking if Sampler Exists\n";
if (SamplerExists($Sampler) == 0 ) {
        print "Sampler does not exist. Exiting..\n";
        exit;
} else {
        print "Sampler Exists. Moving On\n";
}

# Check if the View Exists.
print "\n\n********************************\n";
print "********************************\n";
print "Checking if View Exists\n";
if ( ViewExists($ManagedEntity,$Sampler,$Group,$View) == 0 ) {
        print "View does not exist. Creating..\n";
        CreateView($ManagedEntity,$Sampler,$Group,$View);
        print "View Created\n";
}

print "\n\n********************************\n";
print "********************************\n";
print "Checking if Columns Exists\n";
# Check if the 3 Columns Exist
$res = ColumnCount($GeneosString);
if ( $res == 3 ) {
        print "3 Columns exists. Continuing..\n";
} else {
        print "Other than 3 columns exist: " . $res . " returned";
}

=for comment

#
# jaguar@jagfm1i01:alert$./alert-replacement.pl localhost 6969
#********************************
#********************************
#Checking if connected to a Gateway
#--------------------------------------
#Gateway Connected - Printing Result
#Response type - boolean
#Response string - <boolean>1</boolean>
#********************************
#********************************
#Checking if ManagedEntity Exists
#--------------------------------------
#ManagedEntity Name: ME_API
#ManagedEntityExists - Printing Result
#Response type - boolean
#Response string - <boolean>1</boolean>
#********************************
#********************************
#Checking if Sampler Exists
#--------------------------------------
#Sampler Name: API_SAMPLER
#Sub SamplerExists - Printing Result
#Response type - boolean
#Response string - <boolean>0</boolean>
#Sampler does not exist. Exiting..
#

9 API Technical ReferenceAPI Technical ReferenceAPI Technical Reference API Technical ReferenceAPI Technical Reference API Technical Reference API Technical Reference API Technical Reference API Technical Reference API Technical Reference
9.1 API Function Calls
entity.sampler.createView
string entity.sampler.createView(string viewName, string groupHeading)
Creates a new, empty view in the specified sampler under the specified groupHeading. This view will appear in Active Console once it has been created, even if no information has been added to it. For historic reasons, the groupHeading must not be the same as the viewName.
Parameters
viewName - The name of the view to be created.
groupHeading - The group heading to use.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, VIEW_EXISTS, VIEW_AND_GROUP_EQUAL
entity.sampler.viewExists
boolean entity.sampler.viewExists(string viewName)
Checks whether a particular view exists in this sampler. viewName should be in the form group-view. This method is useful if no updates are needed in a long period of time, to check whether the NetProbe has restarted. If this were the case then the sampler would exist, but the view would not.
Parameters
viewName - The name of the view.
Returns
true if the view exists, false otherwise.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER
entity.sampler.removeView
string entity.sampler.removeView(string viewName, string groupHeading)
Removes a view that has been created with createView. Note that this cannot be used if a Gateway1 is connected.
Parameters
viewName - The name of the view.
groupHeading - The group heading.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, GATEWAY_NOT_SUPPORTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.getParameter
string entity.sampler.getParameter(string parameterName)
Retrieves the value of a sampler parameter that has been defined in the gateway configuration.
For example:
January 2010 Page 29 of 37
[mysampler_SAMPLER_DESCRIPTOR] PLUGIN = API INFO = Some text
allows the call sampler.getParameter(“INFO”) to retrieve the text “Some text”. If the sampler is not defined in the gateway configuration then an error will be returned.
Parameters
parameterName - The name of the parameter to be retrieved.
Returns
The parameter text written in the gateway configuration.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, SAMPLER_PARAM_NOT_FOUND
entity.sampler.view.addTableRow
string entity.sampler.view.addTableRow(string rowName)
Adds a new, blank table row to the specified view. The name of each row must be unique to that table. An attempt to create two rows with the same name will result in an error.
Parameters
rowName - The name of the row to be created.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, ROW_EXISTS
entity.sampler.view.removeTableRow
string entity.sampler.view.removeTableRow(string rowName)
Removes an existing row from the specified view.
Parameters
rowName - The name of the row to be removed.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, NO_SUCH_ROW
entity.sampler.view.addHeadline
string entity.sampler.view.addHeadline(string headlineName)
Adds a headline variable to the view.
Parameters
headlineName - The name of the headline to be created.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, HEADLINE_EXISTS
entity.sampler.view.removeHeadline
string entity.sampler.view.removeHeadline(string headlineName)
Removes a headline variable from the view. Note that this cannot be used if a Gateway1 is connected.
Parameters
headlineName - The name of the headline to be removed.
Returns
“OK” on successful completion.
January 2010 Page 30 of 37
Errors
GATEWAY_NOT_CONNECTED, GATEWAY_NOT_SUPPORTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, NO_SUCH_HEADLINE
entity.sampler.view.updateVariable
string entity.sampler.view.updateVariable(string variableName, string newValue)
Can be used to update either a headline variable or a table cell. If the variable name contains a period (.) then a cell is assumed, otherwise a headline variable is assumed.
Parameters
variableName - The name of the variable to be updated.
newValue - The new value it should take.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, NO_SUCH_CELL, NO_SUCH_HEADLINE
entity.sampler.view.updateHeadline
string entity.sampler.view.updateHeadline(string headlineName, string newValue)
Updates a headline variable. This performs the same action as updateVariable, but is fractionally faster as it is not necessary to determine the variable type.
Parameters
headlineName - The name of the headline to be updated.
newValue - The new value it should take.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, NO_SUCH_HEADLINE
entity.sampler.view.updateTableCell
string entity.sampler.view.updateTableCell(string cellName, string newValue)
Updates a single cell in a table. The standard row.column format should be used to reference a cell. This performs the same action as updateVariable, but is fractionally faster as it is not necessary to determine the variable type.
Parameters
cellName - The name of the cell to be updated.
newValue - The new value it should take.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, NO_SUCH_CELL
entity.sampler.view.updateTableRow
string entity.sampler.view.updateTableRow(string rowName, array newValue)
Updates an existing row from the specified view with the new values provided.
Parameters
rowName - The name of the row whose values are to be updated.
newValue – The new values.
Returns
“OK” on successful completion.
Errors
January 2010 Page 31 of 37
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, NO_SUCH_ROW
entity.sampler.view.addTableColumn
string entity.sampler.view.addTableColumn(string columnName)
Adds another column to the table. Each column must be unique.
Parameters
columnName - The name of the column to add.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, COLUMN_EXISTS
entity.sampler.view.updateEntireTable
string entity.sampler.view.updateEntireTable(array newTable)
Updates the entire table for a given view. This is useful if the entire table will change at once or the table is being created for the first time. The array passed should be two dimensional. The first row should be the column headings and the first column of each subsequent row should be the name of the row. The array should be at least 2 columns by 2 rows. Once table columns have been defined, they cannot be changed by this method.
Parameters
newTable - The table data.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW, COLUMN_MISMATCH
entity.sampler.view.columnExists
boolean entity.sampler.columnExists(string columnName)
Check if the headline variable exists.
Parameters
columnName – The unique name of the row.
Returns
true if the column exists, false otherwise.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.rowExists
boolean entity.sampler.rowExists(string rowName)
Check if the headline variable exists.
Parameters
rowName – The unique name of the row.
Returns
true if the row exists, false otherwise.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.headlineExists
boolean entity.sampler.headlineExists(string headlineName)
January 2010 Page 32 of 37
Check if the headline variable exists.
Parameters
headlineName – The name of the headline variable.
Returns
true if the headline variable exists, false otherwise.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getColumnCount
int entity.sampler.getColumnCount()
Return the column count of the view
Parameters
None
Returns
The number of columns in the view. This includes the rowName column.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getRowCount
int entity.sampler.getRowCount()
Return the rowcount of the view.
Parameters
None
Returns
The number of rows in the view
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getHeadlineCount
int entity.sampler.getHeadlineCount()
Return the headline count of the view.
Parameters
None
Returns
The number of headlines in the view. This includes the samplingStatus headline.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getColumnNames
array entity.sampler.getColumnNames()
Returns the names of existing columns
Parameters
None
Returns
The names of existing columns in the view. This includes the rowNames column name.
Errors
January 2010 Page 33 of 37
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getRowNames
array entity.sampler.getRowNames()
Returns the names of existing rows
Parameters
None
Returns
the names of existing rows in the view
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getHeadlineNames
array entity.sampler.getHeadlineNames()
Returns the names of existing headlines
Parameters
None
Returns
the names of existing headlines in the view. This includes the samplingStatus headline.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.view.getRowNamesOlderThan
array entity.sampler.view.getRowNamesOlderThan(string time)
Returns the names of rows whose update time is older than the time provided.
Parameters
time - The timestamp against which to compare row update time. The timestamp should be provided as Unix timestamp, i.e. number of seconds elapsed since UNIX epoch.
Returns
The names of rows whose update time is older than the time provided.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_VIEW
entity.sampler.signOn
string entity.sampler.signOn(int seconds)
Commits the API client to provide at least one heartbeat or update to the view within the time period specified. seconds should be at least 1 and no more than 86400 (24 hours). signOn may be called again to change the time period without the need to sign off first.
Parameters
seconds - The maximum time between updates before samplingStatus becomes FAILED.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NUMBER_OUT_OF_RANGE
entity.sampler.signOff
string entity.sampler.signOff()
January 2010 Page 34 of 37
Cancels the commitment to provide updates to a view. If this method is called when signOn has not been called then it has no effect.
Parameters
None.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER
entity.sampler.heartbeat
string entity.sampler.heartbeat()
Prevents the sampling status from becoming failed when no updates are needed to a view and the client is signed on. If this method is called when signOn has not been called then it has no effect.
Parameters
None.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER
9.2 API Streams Function Calls
entity.sampler.stream.addMessage
string entity.sampler.stream.addMessage(string message)
Adds a new message to the end of the stream.
Parameters
message - The line of text to be added to the stream.
Returns
“OK” on successful completion.
Errors
GATEWAY_NOT_CONNECTED, NO_SUCH_SAMPLER, NO_SUCH_STREAM, STREAM_BUFFER_FULL
9.3 NetProbe Function Calls
_netprobe.managedEntityExists
boolean _netprobe.managedEntityExists(string managedEntity)
Checks whether a particular Managed Entity exists on this NetProbe containing any API or API-Streams samplers.
Parameters
managedEntity - The name of the Managed Entity.
Returns
true if the Managed Entity exists, false otherwise.
Errors
No errors specific to this method.
_netprobe.samplerExists
January 2010 Page 35 of 37
boolean _netprobe.samplerExists(string sampler)
Checks whether a particular API or API-Streams sampler exists on this NetProbe.
Parameters
sampler - The name of the sampler.
Returns
true if the sampler exists, false otherwise.
Errors
No errors specific to this method.
_netprobe.gatewayConnected
boolean _netprobe.gatewayConnected()
Checks whether the Gateway is connected to this NetProbe.
Parameters
None.
Returns
true if the Gateway is connected, false otherwise.
Errors
No errors specific to this method.
9.4 Gateway Function Calls
_gateway.addManagedEntity
string _gateway.addManagedEntity(string managedEntity, string dataSection)
Adds the managed entity to the particular data section. The data section should be #include’d into the MANAGED_ENTITIES section of the gateway setup. As long as a Gatway is connected, this method will always return “OK”. If the managed entity already exists, a warning will be seen in the Gateway log.
Parameters
managedEntity - The name of the Managed Entity to add.
dataSection - The data section to add the managed entity to.
Returns
“OK”.
Errors
GATEWAY_NOT_CONNECTED
9.5 General Error Codes Code Name Description
100
MISC_ERROR
An error has occurred that has not been defined specifically.
101
NUMBER_OUT_OF_RANGE
Either an invalid number was sent (e.g. text), or it is out of the range of numbers required by the function.
102
HOST_NOT_TRUSTED
Your host is not allowed to make API calls (see the security section in this document).
9.6 Operational Error Codes Code Name Description
200
NO_SUCH_METHOD
An attempt has been made to call a method that has not been defined above.
201
WRONG_PARAM_COUNT
The wrong number of parameters has been
January 2010 Page 36 of 37
passed to the function.
202
NO_SUCH_SAMPLER
An attempt has been made to call a method on a sampler that has not been created.
203
GATEWAY_NOT_CONNECTED
An attempt has been made to pass a command to the Gateway, but no gateway is currently connected.
204
GATEWAY_NOT_SUPPORTED
An unsupported Gateway is currently connected to the Netprobe. This will typically be issued for individual commands that do not work with Gateway1.
9.7 Sampler Error Codes Code Name Description
300
SAMPLER_PARAM_NOT_FOUND
A request has been made for a sampler parameter that has not been defined in the gateway setup.
301
VIEW_EXISTS
An attempt has been made to create a view that already exists. Each view must have a unique name within the sampler.
302
NO_SUCH_VIEW
An attempt has been made to call a method on a sampler view that has not been created.
303
NO_SUCH_STREAM
An attempt has been made to call a method on a stream that has not been defined in the sampler descriptor.
304
VIEW_AND_GROUP_EQUAL
When views are created, the view name must not be the same as the group heading.
9.8 View Error Codes Code Name Description
400
NO_SUCH_CELL
An attempt has been made to reference a cell that does not exist in this view.
401
ROW_EXISTS
An attempt has been made to add a row that already exists. Each row must have a unique name.
402
COLUMN_EXISTS
An attempt has been made to create a column that already exists.
403
NO_SUCH_HEADLINE
An attempt has been made to update a headline that has not been created.
404
HEADLINE_EXISTS
An attempt has been made to add a headline that already exists. Each headline must have a unique name.
405
NO_SUCH_ROW
An attempt has been made to reference or remove a row that doesn’t exist.
406
NO_SUCH_COLUMN
An attempt has been made to reference a column that doesn’t exist.
407
COLUMN_MISMATCH
An attempt was made to change the number/names of columns with the updateEntireTable method.
9.9 XML-RPC Error Codes Code Name Description
500
NO_XML_SENT
A header was sent but no XML was included with the request.
January 2010 Page 37 of 37
9.10 Stream Error Codes Code Name Description
600
STREAM_BUFFER_FULL
The buffer for this stream is full so the message has not been appended to the stream. This is probably caused by FKM not being set up on the stream or not reading data fast enough.



=cut