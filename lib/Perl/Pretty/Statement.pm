package Perl::Pretty::Statement;

use namespace::clean;

use parent qw(Perl::Pretty::Expression);

sub format {
    my ( $self, @args ) = @_;

    $self->SUPER::format(@args) . ';';
}

__PACKAGE__

__END__
