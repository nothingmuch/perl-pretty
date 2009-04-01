package Perl::Pretty::List;

use namespace::clean;

use parent qw(Perl::Pretty::Chunk);

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_list(@{ $self->parts });
}

__PACKAGE__

__END__
