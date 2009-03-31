package Perl::Pretty::Node;

use Carp qw(croak);

use namespace::clean;

sub format {
    croak ref($_[0]) . " cannot be formatted (uncomposed)";
}

__PACKAGE__

__END__
