#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Pretty::Unit';
use ok 'Perl::Pretty::Binding';
use ok 'Perl::Pretty::Placeholder';
use ok 'Perl::Pretty::Snippet';

use ok 'Perl::Pretty::Composer';

my $c = Perl::Pretty::Composer->new;

my %id = (
    unary  => Perl::Pretty::Snippet->new( parts => ["foo"] ),
    binary => Perl::Pretty::Snippet->new( parts => [qw(foo bar)] ),
    nested => Perl::Pretty::Snippet->new(
        parts => [ Perl::Pretty::Snippet->new( parts => ["blah"] ) ]
    ),
    unit => Perl::Pretty::Unit->new(
        requires => [qw($blah)],
        node     => Perl::Pretty::Snippet->new( parts => ["foo"] )
    ),
);

foreach my $key ( keys %id ) {
    my $id = $id{$key};
    use Data::Dumper;
    is_deeply( $c->compose($id), $id, "'$key' composes to itself" ) or die Dumper($id, $c->compose($id))
}

my %simplify = (
    inner_unit => {
        from => Perl::Pretty::Snippet->new(
            parts => [
                Perl::Pretty::Unit->new(
                    requires => [qw($blah)],
                    node     => Perl::Pretty::Snippet->new( parts => ["foo"] )
                )
            ]
        ),
        to => Perl::Pretty::Unit->new(
            requires => [qw($blah)],
            node     => Perl::Pretty::Snippet->new(
                parts => [ Perl::Pretty::Snippet->new( parts => ["foo"] ) ]
            )
        ),
    },
    useless_unit => {
        from => Perl::Pretty::Unit->new(
            node => Perl::Pretty::Snippet->new( parts => [qw(foo)] )
        ),
        to => Perl::Pretty::Snippet->new( parts => [qw(foo)] ),
    },
    nested_inner_unit => {
        from => Perl::Pretty::Unit->new(
            node => Perl::Pretty::Snippet->new(
                parts => [
                    Perl::Pretty::Unit->new(
                        requires => [qw($blah)],
                        node => Perl::Pretty::Snippet->new( parts => ["foo"] )
                    ),
                ],
            ),
        ),
        to => Perl::Pretty::Unit->new(
            requires => [qw($blah)],
            node     => Perl::Pretty::Snippet->new(
                parts => [ Perl::Pretty::Snippet->new( parts => ["foo"] ), ],
            ),
        ),
    },
    nested_useless_unit => {
        from => Perl::Pretty::Unit->new(
            node => Perl::Pretty::Unit->new(
                node => Perl::Pretty::Snippet->new( parts => [qw(foo)] )
            )
        ),
        to => Perl::Pretty::Snippet->new( parts => [qw(foo)] ),
    },
);

foreach my $key ( keys %simplify ) {
    my ( $from, $to, ) = @{ $simplify{$key} }{qw(from to)};
    is_deeply( $c->compose($from), $to, "'$key' simplified" );
}

my %binding = (
    simple_binding => {
        from => Perl::Pretty::Binding->new(
            node => Perl::Pretty::Placeholder->new( name => "foo", ),
            bindings =>
              { foo => Perl::Pretty::Snippet->new( parts => [qw(foo)] ), },
        ),
        to => Perl::Pretty::Snippet->new( parts => [qw(foo)] ),
    },
    complex_binding => {
        from => Perl::Pretty::Binding->new(
            node => Perl::Pretty::Unit->new(
                provides => [qw($foo)],
                node     => Perl::Pretty::Snippet->new(
                    parts => [
                        "foo", Perl::Pretty::Placeholder->new( name => "foo" ),
                    ],
                ),
            ),
            bindings => {
                foo => Perl::Pretty::Unit->new(
                    requires => [qw($foo)],
                    node => Perl::Pretty::Snippet->new( parts => [qw(bar)] ),
                ),
            },
        ),
        to => Perl::Pretty::Unit->new(
            provides => [qw($foo)],
            node     => Perl::Pretty::Snippet->new(
                parts =>
                  [ "foo", Perl::Pretty::Snippet->new( parts => [qw(bar)] ), ]
            )
        ),
    },
    complex_binding_with_remainder => {
        from => Perl::Pretty::Binding->new(
            node => Perl::Pretty::Unit->new(
                provides => [qw($foo)],
                node     => Perl::Pretty::Snippet->new(
                    parts => [
                        "foo", Perl::Pretty::Placeholder->new( name => "foo" ),
                    ],
                ),
            ),
            bindings => {
                foo => Perl::Pretty::Unit->new(
                    requires => [qw($bar)],
                    node => Perl::Pretty::Snippet->new( parts => [qw(bar)] ),
                ),
            },
        ),
        to => Perl::Pretty::Unit->new(
            provides => [qw($foo)],
            requires => [qw($bar)],
            node     => Perl::Pretty::Snippet->new(
                parts =>
                  [ "foo", Perl::Pretty::Snippet->new( parts => [qw(bar)] ), ]
            ),
        ),
    },
);

foreach my $key ( keys %binding ) {
    my ( $from, $to, ) = @{ $binding{$key} }{qw(from to)};
    is_deeply( $c->compose($from), $to, $key );
}
