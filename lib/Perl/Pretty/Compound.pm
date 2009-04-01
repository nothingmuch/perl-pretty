package Perl::Pretty::Compound;

use namespace::clean;

sub new {
    my ( $class, %args ) = @_;

    bless {
        statement => ( $args{statement} || die "statement is required" ),
        block     => ( $args{block}     || die "block is required" ),
        label     => $args{label},
    }, $class;
}

sub statement { $_[0]{statement} }

sub block { $_[0]{block} }

sub label { $_[0]{label} }

sub compose {
    my ( $self, $c ) = @_;

    Perl::Pretty::Compound->new(
        label => $self->label,
        statement => $self->statement->compose($c),
        block => $self->block->compose($c),
    );
}

sub format {
    my ( $self, $formatter ) = @_;

    $formatter->emit_expressions(
        ( defined($self->label) ? $self->label . ":" : () ),
        $self->statement,
        $self->block,
    );
}

__PACKAGE__

__END__
