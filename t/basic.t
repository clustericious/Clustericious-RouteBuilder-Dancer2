use strict;
use warnings;
use Test::Clustericious::Cluster;
use Test::More tests => 2;

my $cluster;

subtest prep => sub {
  plan tests => 1;
  $cluster = Test::Clustericious::Cluster->new;
  $cluster->create_cluster_ok('Basic');
};

my $t = $cluster->t;

subtest 'in different .pm files' => sub {
  plan tests => 2;

  my $url = $cluster->urls->[0];

  subtest 'default routes are reachable' => sub {
    plan tests => 3;

    $t->get_ok("$url/version")
      ->status_is(200)
      ->json_is('/0', '1.23');;

  };

  subtest 'dancer content' => sub {
    plan tests => 3;

    $t->get_ok("$url/foo")
      ->status_is(200)
      ->content_is('Hello World!');

  };
};

__DATA__

@@ etc/Basic.conf
---
url: <%= cluster->url %>


@@ lib/Basic.pm
package Basic;

use strict;
use warnings;
use base qw( Clustericious::App );
use Basic::Routes;

our $VERSION = '1.23';

1;


@@ lib/Basic/Routes.pm
package Basic::Routes;

use strict;
use warnings;
use Clustericious::RouteBuilder::Dancer2;

get '/foo' => sub {
  "Hello World!";
};

1;


