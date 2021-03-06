package Perl::Pretty::Expression;

use namespace::clean;

use parent qw(Perl::Pretty::Chunk);

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_expressions(@{ $self->parts });
}

__PACKAGE__

__END__
