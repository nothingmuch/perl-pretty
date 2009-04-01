package Perl::Pretty::Formatter;

use namespace::clean;

sub new {
    bless {}, shift;
}

sub format {
    my ( $self, $node ) = @_;

    if ( ref $node ) {
        return $node->format($self);
    } else {
        return $node;
    }
}

sub emit_chunks {
    my ( $self, @contents ) = @_;

    return join('', map { $self->format($_) } @contents );
}

sub emit_expressions {
    my ( $self, @contents ) = @_;

    return join(' ', map { $self->format($_) } @contents );
}

sub emit_lines {
    my ( $self, @contents ) = @_;

    return join('', map { $self->format($_) } @contents); # FIXME indent, newlines
}

sub emit_block {
    my ( $self, @contents ) = @_;

    return '{' . $self->emit_lines(@contents) . '}'; # FIXME increase indent locally
}

sub emit_list {
    my ( $self, @contents ) = @_;

    return '(' . join(', ', map { $self->emit_chunks($_) } @contents) . ')'; # FIXME limit to 80 chars?
}

__PACKAGE__

__END__
