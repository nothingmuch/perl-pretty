package Perl::Pretty::Placeholder;

use namespace::clean;

use parent qw(Perl::Pretty::Node);

sub new {
    my ( $class, %args ) = @_;

    bless { name => ( $args{name} || die "name is required" ) }, $class;
}

sub name { $_[0]{name} }

sub compose {
    my ( $self, $c ) = @_;

    $c->resolve($self);
}

__PACKAGE__

__END__
