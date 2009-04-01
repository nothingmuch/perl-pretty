#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Pretty::Unit';
use ok 'Perl::Pretty::Chunk';
use ok 'Perl::Pretty::Block';
use ok 'Perl::Pretty::List';
use ok 'Perl::Pretty::Expression';
use ok 'Perl::Pretty::Statement';
use ok 'Perl::Pretty::Compound';

use ok 'Perl::Pretty::Formatter';

my $f = Perl::Pretty::Formatter->new;

is( $f->format("foo"), "foo", "strings pass through" );

is( $f->format(Perl::Pretty::Chunk->new( parts => [qw(foo bar)] )), "foobar", "format simple snippet" );

is( $f->format(Perl::Pretty::Unit->new( node => Perl::Pretty::Chunk->new( parts => [qw(foo bar)] ) )), "foobar", "format simple unit" );

like( $f->format(Perl::Pretty::List->new( parts => [qw(foo bar)] )), qr/\(\s*foo\s*,\s*bar\s*\)/s, "format simple list" );

like( $f->format(Perl::Pretty::Block->new( parts => [map { Perl::Pretty::Statement->new(parts => [ $_ ]) } qw(foo bar)] )), qr/\{\s*foo\s*;\s*bar\s*;\s*\}/s, "format simple block" );

like( $f->format(Perl::Pretty::Expression->new( parts => [qw(foo bar)] )), qr/foo\s+bar/s, "format expressions" );

like( $f->format(Perl::Pretty::Statement->new( parts => [qw(foo bar)] )), qr/foo\s+bar;/s, "format statement" );

is( $f->format(Perl::Pretty::Compound->new( statement => "if (foo)", block => "{ blah }" ) ), 'if (foo) { blah }', "compound statement with strings" );

like( $f->format(Perl::Pretty::Compound->new( statement => Perl::Pretty::Expression->new( parts => [ 'if', '(foo)' ] ), block => Perl::Pretty::Block->new( parts => [ Perl::Pretty::Statement->new( parts => [ "blah" ] ) ] ) ) ), qr/if\s*\(\s*foo\s*\)\s*{\s*blah;\s*}/s, "compound statement with strings" );
