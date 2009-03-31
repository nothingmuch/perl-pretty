package Perl::Pretty::Node;
use Moose;

use Carp qw(croak);

use namespace::clean -except => 'meta';

sub format {
    croak ref($_[0]) . " cannot be formatted (uncomposed)";
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
