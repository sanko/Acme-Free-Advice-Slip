use Test2::V0;
#
use lib '../lib', 'lib';
use Acme::Free::Advice::Slip qw[:all];
#
imported_ok qw[advice search];
#
subtest 'random advice' => sub {
    is my $slip = advice(), hash {
        field advice => D();
        field id     => D();
        end()
    }, 'advice() returns a random slip';
};
subtest 'specific advice' => sub {
    is my $slip = advice(224), hash {
        field advice => string q[Don't drink bleach.];
        field id     => number 224;
        end;
    }, 'advice(1) returns a known slip';
    is advice(100000), U(), 'advice(100000) returns undef';
};
subtest 'search for advice' => sub {
    is [ search('time') ], array {
        all_items hash {
            field advice => D();
            field date   => D();
            field id     => D();
            end;
        };
        etc;
    }, 'search("time") returns a list of slips';
    is [ search('tfcsqfdafdsa') ], [], 'search("tfcsqfdafdsa") returns an empty list';
};
#
done_testing;
