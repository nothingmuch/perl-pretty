package Perl::Pretty::List;
use Moose;

use namespace::clean -except => 'meta';

extends qw(Perl::Pretty::Snippet);

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_list(@{ $self->parts });
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
