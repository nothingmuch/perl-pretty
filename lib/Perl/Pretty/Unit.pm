package Perl::Pretty::Unit;

use namespace::clean;

use parent qw(Perl::Pretty::Node);

sub new {
    my ( $class, %args ) = @_;

    bless {
        node     => ( $args{node}     || die "node is required" ),
        requires => ( $args{requires} || [] ),
        provides => ( $args{provides} || [] ),
    }, $class;
}

sub node { $_[0]{node} }

sub requires { $_[0]{requires} }

sub provides { $_[0]{provides} }

sub compose {
    my ( $self, $c ) = @_;

    $c->declare_requires( @{ $self->requires } );
    $c->declare_provides( @{ $self->provides } );

    $self->node->compose($c);
}

sub format {
    my ( $self, $formatter ) = @_;

    $self->node->format($formatter);
}

__PACKAGE__

__END__
