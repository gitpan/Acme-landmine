package Acme::landmine;

use 5.000;
use strict;
use Carp;
no strict 'refs';

use vars qw'$VERSION $AUTOLOAD';

$VERSION = '0.01';


sub DESTROY{

};

sub AUTOLOAD {

         if($AUTOLOAD =~ /TIE/) {

		eval <<EOF;
		sub $AUTOLOAD {
			my \$flavor = shift;
			my \$sin = shift;
			bless \\\$sin, \$flavor;
		}
EOF
	}else{
		eval <<EOF;
		sub $AUTOLOAD {
			my \$sin = shift;
			confess  \$\$sin;
		};

EOF
	};

        goto &$AUTOLOAD;
}
	

1;
__END__

=head1 NAME

Acme::landmine -  variables that explode 

=head1 SYNOPSIS

  use Acme::landmine; 
  tie my $bomb, Acme::landmine => "Try serializing this!";
  tie my @bomb, Acme::landmine => "Try serializing this!";
  tie my %bomb, Acme::landmine => "Try serializing this!";

=head1 ABSTRACT

  variables that explode

=head1 DESCRIPTION

 a tie interface that C<confess>es.  This is useful
 for creating out-of-bounds markers when modeling data structures.

 DESTROY is not mined, but everything else is. 

=head2 EXPORT

None.


=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
