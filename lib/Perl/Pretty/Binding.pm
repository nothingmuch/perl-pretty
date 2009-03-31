package Perl::Pretty::Binding;
use Moose;

use namespace::clean -except => 'meta';

extends qw(Perl::Pretty::Node);

has node => (
	isa => "Perl::Pretty::Node",
	is  => "ro",
);

has bindings => (
    isa => "HashRef",
    is  => "ro",
);

sub compose {
    my ( $self, $c ) = @_;

    $c->bind( $self->node, %{ $self->bindings } );
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
