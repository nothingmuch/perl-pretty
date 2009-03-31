package Perl::Pretty::Statement;

use namespace::clean;

use parent qw(Perl::Pretty::Snippet);

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_expressions(@{ $self->parts });
}

__PACKAGE__

__END__
