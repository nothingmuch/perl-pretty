package Perl::Pretty::Util;

use strict;
use warnings;

use Perl::Pretty::Formatter;
use Perl::Pretty::Composer ;

use Perl::Pretty::Chunk;
use Perl::Pretty::Expression;
use Perl::Pretty::Statement;
use Perl::Pretty::Compound;
use Perl::Pretty::Block;
use Perl::Pretty::List;
use Perl::Pretty::Unit;
use Perl::Pretty::Placeholder;
use Perl::Pretty::Binding;

use namespace::clean -except => 'meta';

use Sub::Exporter -setup => {
    exports => [qw(
        f
        compose

        p
        c
        e
        st
        b
        l

        unit
        bind

        c_if
        c_elsif
        c_else
        c_unless
    )]
};

sub f { Perl::Pretty::Formatter->new->format( compose($_[0]) ) }

sub compose { Perl::Pretty::Composer->new->compose($_[0]) }

sub p { Perl::Pretty::Placeholder->new( name => $_[0] ) }

sub c { Perl::Pretty::Chunk->new( parts => [@_] ) }
sub e { Perl::Pretty::Expression->new( parts => [@_] ) }
sub st { Perl::Pretty::Statement->new( parts => [@_] ) }
sub b { Perl::Pretty::Block->new( parts => [ map { ref $_ ? $_ : st($_) } @_] ) }
sub l { Perl::Pretty::List->new( parts => [@_] ) }

sub compound {
    my ( $label, $statement, $block ) = ( @_ == 3 ? @_ : ( undef, @_ ) );

    Perl::Pretty::Compound->new(
        label => $label,
        statement => $statement,
        block => $block,
    );
}

sub unit {
    unshift @_, 'node' if @_ % 2;
    Perl::Pretty::Unit->new( @_ );
}

sub bind {
    my ( $node, %bindings ) = @_;
    Perl::Pretty::Binding->new( node => $node, bindings => \%bindings );
}

sub c_if {
    my ( $cond, @s ) = @_;

    compound( e("if (", $cond, ")"), b(@s) );
}

sub c_elsif {
    my ( $cond, @s ) = @_;

    compound( e("elsif (", $cond, ")"), b(@s) );
}

sub c_else {
    compound( e("else"), b(@_) );
}

sub c_unless {
    my ( $cond, @s ) = @_;

    compound( e("unless (", $cond, ")"), b(@s) );
}

__PACKAGE__

__END__
