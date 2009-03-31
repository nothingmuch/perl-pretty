package Perl::Pretty::Block;

use namespace::clean;

use parent qw(Perl::Pretty::Snippet);

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_block(@{ $self->parts });
}

__PACKAGE__

__END__
