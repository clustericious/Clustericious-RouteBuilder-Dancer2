use strict;
use warnings;
use Test::Clustericious::Cluster;
use Test::More tests => 2;

my $cluster;

subtest prep => sub {
  plan tests => 1;
  $cluster = Test::Clustericious::Cluster->new;
  $cluster->create_cluster_ok('ConfigTest');
};

my $t = $cluster->t;
my $url = $cluster->url;

subtest 'config pass thru' => sub {
  plan tests => 3;

  $t->get_ok("$url/foo")
    ->status_is(200)
    ->content_is('roger ramjet');

};

__DATA__

@@ etc/ConfigTest.conf
---
url: <%= cluster->url %>
foo: roger ramjet


@@ lib/ConfigTest.pm
package ConfigTest;

use strict;
use warnings;
use base qw( Clustericious::App );
use ConfigTest::Routes;

our $VERSION = '1.23';

1;


@@ lib/ConfigTest/Routes.pm
package ConfigTest::Routes;

use strict;
use warnings;
use Clustericious::RouteBuilder::Dancer2;

get '/foo' => sub {
  clconfig->foo;
};

1;


