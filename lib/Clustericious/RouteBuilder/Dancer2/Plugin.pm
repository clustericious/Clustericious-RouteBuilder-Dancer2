use strict;
use warnings;
use 5.014;

package Clustericious::RouteBuilder::Dancer2::Plugin {

  use Dancer2::Plugin;

  our $clustericious;

  register clconfig => sub {
    my($dsl) = @_;
    $clustericious->config;
  };

  register_plugin;

}

1;
