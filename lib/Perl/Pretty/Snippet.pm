package Perl::Pretty::Snippet;

use namespace::clean;

use parent qw(Perl::Pretty::Node);

sub new {
    my ( $class, %args ) = @_;

    bless {
        parts => $args{parts} || die "parts is required",
    }, $class;
}

sub parts { $_[0]{parts} }

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

__PACKAGE__

__END__
