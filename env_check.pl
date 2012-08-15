#!/usr/local/bin/perl

my $hostname   = `hostname`;
my $domainname = `domainname`;

$DEBUG_SWITCH= 'off';

#Define the Fortune part
my @prelife2=qw(icomp82 forcoi02 foqcop07 foqcop08 forcoi06 forwei02);
 


# Checks if a provided element exists in the provided list
# Usage: isInList <needle element> <haystack list>
# Returns: 0/1
sub isInList {
    my $needle = shift;
    my @haystack = @_;
    foreach $hay (@haystack) {
        if ( $needle eq $hay ) {
            return 1;
        }
    }
    return 0;
}


sub isInList2 {
  my( $d, $it ) = ( "\0", @_ );
  join( $d, '', @_, '' ) =~ /$d\Q$it\E$d/
}



sub CheckEnviroment {
        if ( $DEBUG_SWITCH eq "on" ) {
                print "hostname=" . $hostname . "\n";
                print "domainname=" . $domainname . "\n";
         }

        if ( $domainname =~ "prod" ) {
                $ENVIROMENT = "Production";
        }

        if ( $domainname =~ "prel" ) {
                $ENVIROMENT = "Prelife";
         }

        if ( $domainname =~ "dev" ) {
                $ENVIROMENT = "Development";
        }

        if ( $domainname =~ "gde" ) {
                $ENVIROMENT = "Development";
         }

        if ($ENVIROMENT eq "Prelife") {

			if (isInList($domainname,@prelife2)) {
				$ENVIROMENT = "Prelife2";
			}else {
				$ENVIROMENT = "Prelife";
			}

#        if (exists($prelife{$hostname}))
#                {
#                  $ENVIROMENT = "Prelife2";
#                }
#                else
#                 {
#                  $ENVIROMENT = "Prelife";
#                }
#        }

        return $ENVIROMENT;
}


print "Enviroment: " . CheckEnviroment . "\n";
 