#!/usr/bin/perl -w
# $Id: 15_accessor.t,v 1.1.1.1 2006/04/13 01:20:07 fil Exp $
use strict;

use Test::More ( tests => 5 );
use Text::Diff::Parser;
use IO::File;

my $file = 't/double.diff';
my $file2 = "t/dbix-abstract.patch";

##########
my $parser = Text::Diff::Parser->new( File=>$file, Simplify=>1 );

my $files = { $parser->files };
is_deeply( $files, {
            Changes => 'Changes',
            README  => 'README',
    }, "List of files changed" );


my $changes = $parser->changes( 'README' );

is( $changes, 1, "One change to README" );


##########
$parser = Text::Diff::Parser->new( {File=>$file2, Simplify=>1, Strip=>2} );
is_deeply( { $parser->files }, 
           { qw( Abstract.pm Abstract.pm
                 2-dbix-abstract.t 2-dbix-abstract.t
                 dbia.config dbia.config
               ) }, "Stripped filenames" );

##########
$parser = Text::Diff::Parser->new( {File=>$file2, Simplify=>1, Strip=>1} );

$changes = $parser->changes( 'Abstract.pm' );
is( $changes, 21, "21 changes to Abstract.pm" );

$changes = $parser->changes( 't/2-dbix-abstract.t' );
is( $changes, 13, "13 changes to t/2-dbix-abstract.t" );
