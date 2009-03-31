package Perl::Pretty::Unit;
use Moose;

use namespace::clean -except => 'meta';

extends qw(Perl::Pretty::Node);

has node => (
    isa => "Perl::Pretty::Node",
    is  => "ro",
);

has [qw(requires provides)] => (
    isa     => "ArrayRef[Str]",
    is      => "ro",
    default => sub { [] },
);

sub compose {
    my ( $self, $c ) = @_;

    $c->declare_requires( @{ $self->requires } );
    $c->declare_provides( @{ $self->provides } );

    $self->node->compose($c);
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
