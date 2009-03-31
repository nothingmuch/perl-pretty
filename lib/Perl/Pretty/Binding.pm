package Perl::Pretty::Binding;

use namespace::clean;

use parent qw(Perl::Pretty::Node);

sub new {
    my ( $class, %args ) = @_;

    bless {
        node     => ( $args{node}     || die "node is required" ),
        bindings => ( $args{bindings} || {} ),
    }, $class;
}

sub node { $_[0]{node} }

sub bindings { $_[0]{bindings} }

sub compose {
    my ( $self, $c ) = @_;

    $c->bind( $self->node, %{ $self->bindings } );
}

__PACKAGE__

__END__
