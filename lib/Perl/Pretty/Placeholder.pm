package Perl::Pretty::Placeholder;
use Moose;

use namespace::clean -except => 'meta';

extends qw(Perl::Pretty::Node);

has name => (
    isa      => "Str",
    is       => "ro",
    required => 1,
);

sub compose {
    my ( $self, $c ) = @_;

    $c->resolve($self);
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
