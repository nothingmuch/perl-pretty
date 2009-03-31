package Perl::Pretty::Snippet;
use Moose;

use namespace::clean -except => 'meta';

extends qw(Perl::Pretty::Node);

has parts => (
    isa      => "ArrayRef[Perl::Pretty::Node|Str]",
    is       => "ro",
    required => 1,
);

sub compose {
    my ( $self, @args ) = @_;

    ( ref $self )->new(
		parts => [ map { ref $_ ? $_->compose(@args) : $_ } @{ $self->parts } ],
	);
}

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_chunks(@{ $self->parts });
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
