package Perl::Pretty::Composer;
use Moose;

use Carp qw(croak);

use Scope::Guard;

use namespace::clean -except => 'meta';

sub compose {
    my ( $self, $node ) = @_;

    $self->bind($node);
}

has [qw(bindings requires provides)] => (
    isa     => "ArrayRef",
    is      => "ro",
    default => sub { [] },
);

sub bind {
    my ( $self, $node, %bindings ) = @_;

    my ( $bs, $rs, $ps ) =
      ( $self->bindings, $self->requires, $self->provides );

    my $g = Scope::Guard->new( sub { pop @$_ for $bs, $rs, $ps } );

    push @$bs, @$bs ? { %{ $bs->[-1] }, %bindings } : \%bindings;
    push @$rs, my $r = {};
    push @$ps, my $p = {};

    my $res = $node->compose($self);

    my @p = keys %$p;
    delete @{$r}{@p};
    my @r = keys %$r;

    if ( @r or @p ) {
        return Perl::Pretty::Unit->new(
            node     => $res,
            requires => \@r,
            provides => \@p,
        );
    }
    else {
        return $res;
    }
}

sub declare_requires {
    my ( $self, @sym ) = @_;

    @{ $self->requires->[-1] }{@sym} = ();
}

sub declare_provides {
    my ( $self, @sym ) = @_;

    @{ $self->provides->[-1] }{@sym} = ();
}

sub resolve {
    my ( $self, $placeholder ) = @_;

    my $node = $self->bindings->[-1]{ $placeholder->name }
      or croak "undefined placeholder: " . $placeholder->name;

    $node->compose($self);
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
