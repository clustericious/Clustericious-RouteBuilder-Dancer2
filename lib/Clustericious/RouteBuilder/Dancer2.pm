use strict;
use warnings;
use 5.014;

package Clustericious::RouteBuilder::Dancer2 {

  # ABSTRACT: Build Clustericious routes with Dancer2
  # VERSION

=head1 SYNOPSIS

 package MyApp {
 
   use base qw( Clustericious::App );
 
 }
 
 package MyApp::Routes {
 
   use Clustericious::RouteBuilder::Dancer2;
   
   get '/foo' => sub { 'hello foo!' };
 
 }

=head1 DESCRIPTION

This module serves an alternative route builder for L<Clustericious> using L<Dancer2>
as the DSL to build routes.

=head1 CAVEATS

Although the original L<Clustericious::RouteBuilder> allowed you to declare routes
in either the app namespace or C<::Routes> under the app namespace, when using this
route builder you MUST declare your routes in a separate C<::Routes> module.  This
is because the L<Dancer2> DSL conflicts with L<Clustericious>.

=cut

  use Dancer2            ();
  use Clustericious::App ();
  use Import::Into;
  my %routes;

  sub import
  {
    my $caller   = caller;
    my $app_name = $caller;
    $app_name =~ s{::Routes$}{};
    $routes{$app_name} = $caller;

    Dancer2->import::into($caller);
    
    # OKAY we better find a better way to do this.  But for now...
    eval qq{
      package $caller {
        require Clustericious::RouteBuilder::Dancer2::Plugin;
        Clustericious::RouteBuilder::Dancer2::Plugin->import::into(\$caller);
      }
    };
    die $@ if $@;
  }

  Clustericious::App->_add_route_builder(sub {
    my($app) = @_;
    $Clustericious::RouteBuilder::Dancer2::Plugin::clustericious = $app;

    if(my $class = $routes{ref $app})
    {
      $app->plugin( MountPSGI => {
        '/' => $class->to_app,
      });
    }
  });
}

1;
