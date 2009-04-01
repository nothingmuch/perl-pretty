#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Pretty::Unit';
use ok 'Perl::Pretty::Chunk';
use ok 'Perl::Pretty::Block';
use ok 'Perl::Pretty::List';
use ok 'Perl::Pretty::Statement';

use ok 'Perl::Pretty::Formatter';

my $f = Perl::Pretty::Formatter->new;

is( $f->format(Perl::Pretty::Chunk->new( parts => [qw(foo bar)] )), "foobar", "format simple snippet" );

is( $f->format(Perl::Pretty::Unit->new( node => Perl::Pretty::Chunk->new( parts => [qw(foo bar)] ) )), "foobar", "format simple unit" );

like( $f->format(Perl::Pretty::List->new( parts => [qw(foo bar)] )), qr/\(\s*foo\s*,\s*bar\s*\)/s, "format simple list" );

like( $f->format(Perl::Pretty::Block->new( parts => [qw(foo bar)] )), qr/\{\s*foo\s*;\s*bar\s*\}/s, "format simple block" );

like( $f->format(Perl::Pretty::Statement->new( parts => [qw(foo bar)] )), qr/foo\s+bar/s, "format statement" );

