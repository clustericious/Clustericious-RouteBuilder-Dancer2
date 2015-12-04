use strict;
use warnings;
use 5.014;

package Clustericious::RouteBuilder::Dancer2::Plugin {

  use Dancer2::Plugin;

  our $clustericious;

  register clconfig => sub {
    my($dsl) = @_;
    my $app = $dsl->app;
    $clustericious->config;
  }, { is_global =>  0 };

  on_plugin_import {
    my($dsl) = @_;
    my $app = $dsl->app;
  };

  register_plugin;

}

1;
