#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Pretty::Unit';
use ok 'Perl::Pretty::Snippet';
use ok 'Perl::Pretty::Block';
use ok 'Perl::Pretty::List';

use ok 'Perl::Pretty::Formatter';

my $f = Perl::Pretty::Formatter->new;

is( $f->format(Perl::Pretty::Snippet->new( parts => [qw(foo bar)] )), "foobar", "format simple snippet" );

is( $f->format(Perl::Pretty::Unit->new( node => Perl::Pretty::Snippet->new( parts => [qw(foo bar)] ) )), "foobar", "format simple unit" );

like( $f->format(Perl::Pretty::List->new( parts => [qw(foo bar)] )), qr/\(\s*foo\s*,\s*bar\s*\)/s, "format simple list" );

like( $f->format(Perl::Pretty::Block->new( parts => [qw(foo bar)] )), qr/\{\s*foo\s*;\s*bar\s*\}/s, "format simple block" );

