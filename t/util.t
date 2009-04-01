#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Pretty::Util' => qw(:all);

is f("foo"), "foo";
is f(e("foo")), "foo";
is f(st("foo")), "foo;";
is f(unit(st("foo"))), "foo;";
is f(st("foo", "bar")), "foo bar;";
is f(c(st("foo"), st("bar"))), "foo;bar;";
is f(l("foo", e("bar"))), "(foo, bar)";
is f(b("foo", "bar")), "{foo;bar;}";
is f(bind(p("foo"), foo => e("blah"))), "blah";
is f(c_if("foo", "bar")), "if ( foo ) {bar;}";
is f(b(c_if("foo", "bar"), c_else("gorch"))), "{if ( foo ) {bar;}else {gorch;}}";
