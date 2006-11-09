#!/usr/bin/perl -w
# $Id: 20_parse.t 154 2006-11-09 19:29:38Z fil $
use strict;

use Test::More tests => 9;

use Text::Diff::Parser;


my $parser = Text::Diff::Parser->new( Verbose => 0 );

my @tests = (

    {   file => 't/std-more.diff',
        desc => "Standard diff, many files",
        result => [
            { filename1 => 'something', line1 => 2,
              filename2 => 'something.1', line2 => 1,
              size      => 2,
              type      => 'REMOVE'
            },

            { filename1 => 'something', line1 => 3,
              filename2 => 'something.2', line2 => 2,
              size      => 1,
              type      => 'REMOVE'
            },

            { filename1 => 'something', line1 => 1,
              filename2 => 'something.3', line2 => 2,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'something', line1 => 3,
              filename2 => 'something.3', line2 => 4,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => 'something', line1 => 4,
              filename2 => 'something.3', line2 => 4,
              size      => 1,
              type      => 'ADD'
            },

            { filename1 => 'something', line1 => 3,
              filename2 => 'something.4', line2 => 3,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => 'something', line1 => 4,
              filename2 => 'something.4', line2 => 3,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'something', line1 => 4,
              filename2 => 'something.4', line2 => 5,
              size      => 2,
              type      => 'ADD'
            },
        ],
    },

    {   file => 't/std-2.diff',
        desc => "Standard diff, 2 files",
        result => [
            { filename1 => '-r1.1.1.1', line1 => 8,
              filename2 => 'demo.pl', line2 => 8,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => '-r1.1.1.1', line1 => 9,
              filename2 => 'demo.pl', line2 => 8,
              size      => 1,
              type      => 'ADD'
            },

            { filename1 => '-r1.1.1.1', line1 => 12,
              filename2 => 'postback.pl', line2 => 12,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => '-r1.1.1.1', line1 => 13,
              filename2 => 'postback.pl', line2 => 12,
              size      => 1,
              type      => 'ADD'
            },
        ],
    },

    
    {   file => 't/easy.diff',
        result => [
            { filename1 => 'Makefile.PL', line1 => 60,
              filename2 => 'Makefile.PL', line2 => 60,
              size      => 3,
              type      => ''
            },
            { filename1 => 'Makefile.PL', line1 => 63,
              filename2 => 'Makefile.PL', line2 => 63,
              size      => 2,
              type      => 'REMOVE'
            },
            { filename1 => 'Makefile.PL', line1 => 65,
              filename2 => 'Makefile.PL', line2 => 63,
              size      => 3,
              type      => 'ADD'
            },
            { filename1 => 'Makefile.PL', line1 => 65,
              filename2 => 'Makefile.PL', line2 => 66,
              size      => 1,
              type      => ''
            },
            { filename1 => 'Makefile.PL', line1 => 66,
              filename2 => 'Makefile.PL', line2 => 67,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'Makefile.PL', line1 => 66,
              filename2 => 'Makefile.PL', line2 => 68,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => 'Makefile.PL', line1 => 67,
              filename2 => 'Makefile.PL', line2 => 68,
              size      => 3,
              type      => ''
            },
        ],
        desc   => "Unified diff.  Only one in file"
    },
    {   file => 't/double.diff',
        result => [
            { filename1 => 'Changes', line1 => 1,
              filename2 => 'Changes', line2 => 1,
              size      => 2,
              type      => ''
            },
            { filename1 => 'Changes', line1 => 3,
              filename2 => 'Changes', line2 => 3,
              size      => 9,
              type      => 'ADD'
            },
            { filename1 => 'Changes', line1 => 3,
              filename2 => 'Changes', line2 => 12,
              size      => 3,
              type      => ''
            },
            { filename1 => 'README', line1 => 21,
              filename2 => 'README', line2 => 21,
              size      => 3,
              type      => ''
            },
            { filename1 => 'README', line1 => 24,
              filename2 => 'README', line2 => 24,
              size      => 6,
              type      => 'ADD'
            },
            { filename1 => 'README', line1 => 24,
              filename2 => 'README', line2 => 30,
              size      => 3,
              type      => ''
            },
        ],
        desc   => "Unified diff.  2 in file"
    },
    {   file => 't/tripple.diff',
        desc => "Unified diff.  3 chunks",
        result => [
            # 0..2
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 1,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 1,
              size      => 3,
              type      => ''
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 4,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 4,
              size      => 2,
              type      => 'ADD'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 4,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 6,
              size      => 3,
              type      => ''
            },

            # 3..9
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 161,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 140,
              size      => 3,
              type      => ''
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 164,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 143,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 165,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 143,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 165,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 144,
              size      => 5,
              type      => ''
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 170,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 149,
              size      => 2,
              type      => 'REMOVE'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 172,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 149,
              size      => 2,
              type      => 'ADD'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 172,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 151,
              size      => 3,
              type      => ''
            },

            # 10..15
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 281,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 260,
              size      => 3,
              type      => ''
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 284,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 263,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 284,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 264,
              size      => 4,
              type      => ''
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 288,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 268,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 289,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 268,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 289,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 269,
              size      => 1,
              type      => ''
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 290,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 270,
              size      => 1,
              type      => 'REMOVE'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 291,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 270,
              size      => 1,
              type      => 'ADD'
            },
            { filename1 => 'lib/POE/Component/Generic.pm', line1 => 291,
              filename2 => 'lib/POE/Component/Generic.pm', line2 => 271,
              size      => 3,
              type      => ''
            },
        ],

    },
    {   file => 't/one-line.diff',
        desc => "Unified diff, zero vs one line",
        result => [
            { filename1 => '/dev/null', line1 => 0,
              filename2 => 'one-line', line2 => 1,
              size      => 1,
              type      => 'ADD'
            },
        ],
    },
    {   file => 't/svn-one-line.diff',
        desc => "Unified diff, zero vs one line, from subversion",
        result => [
            { filename1 => 'local/CPAN/SVN-Web/branches/svn-client/lib/SVN/Web/I18N.pm', line1 => 0,
              filename2 => 'local/CPAN/SVN-Web/branches/svn-client/lib/SVN/Web/I18N.pm', line2 => 1,
              size      => 2,
              type      => 'ADD'
            },
        ],
    },
    {   file => 't/zero-line.diff',
        desc => "Unified diff, one line vs zero",
        result => [
            { filename1 => 'one-line', line1 => 1,
              filename2 => 'zero-line', line2 => 0,
              size      => 1,
              type      => 'REMOVE'
            },
        ],
    },
    {   file => 't/svn-zero-line.diff',
        desc => "Unified diff, one line vs zero, from subversion",
        result => [
            { filename1 => 't/svn-one-line.diff', line1 => 0,
              filename2 => 't/svn-one-line.diff', line2 => 1,
              size      => 7,
              type      => 'ADD'
            },
        ],
    }
);

foreach my $test ( @tests ) {
    if( $test->{file} ) {
        $parser->parse_file( $test->{file} );
    }
    else {
        die "HONK";
    }
    my $res = [$parser->changes];
    compare_changes($res, $test->{result}, $test->{desc} );
}


sub compare_changes
{
    my( $got, $expected, $text ) = @_;

    my $q1 = 0;
    foreach my $ch ( @$got ) {
        foreach my $f ( qw(filename1 line1 size filename2 line2) ) {
            my $v = $ch->can($f)->($ch);
            unless( $expected->[$q1]{$f} eq $v ) {
                my_fail( $text, $ch, $expected, $q1, $f, $v );
                return;
            }
        }
        my $v = $ch->type;
        unless( $expected->[$q1]{type} eq $v ) {
            my_fail( $text, $ch, $expected, $q1, 'type', $v );
            return;
        }
        $q1++;
    }
    pass( $text );
}

sub my_fail
{
    my( $text, $ch, $expected, $q1, $f, $v ) = @_;

    fail( $text );
    $expected->[$q1]{$f} ||= '';
    $v ||= '';
    diag ( "     \$got->[$q1]->$f = $v" );
    diag ( "\$expected->[$q1]{$f} = $expected->[$q1]{$f}" );
    diag ( join "\n", $ch->text );
}
