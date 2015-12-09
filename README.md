# Clustericious::RouteBuilder::Dancer2 [![Build Status](https://secure.travis-ci.org/plicease/Clustericious-RouteBuilder-Dancer2.png)](http://travis-ci.org/plicease/Clustericious-RouteBuilder-Dancer2)

Build Clustericious routes with Dancer2

# SYNOPSIS

    package MyApp {
    
      use base qw( Clustericious::App );
    
    }
    
    package MyApp::Routes {
    
      use Clustericious::RouteBuilder::Dancer2;
      
      get '/foo' => sub { 'hello foo!' };
    
    }

# DESCRIPTION

This module serves an alternative route builder for [Clustericious](https://metacpan.org/pod/Clustericious) using [Dancer2](https://metacpan.org/pod/Dancer2)
as the DSL to build routes.

# CAVEATS

Although the original [Clustericious::RouteBuilder](https://metacpan.org/pod/Clustericious::RouteBuilder) allowed you to declare routes
in either the app namespace or `::Routes` under the app namespace, when using this
route builder you MUST declare your routes in a separate `::Routes` module.  This
is because the [Dancer2](https://metacpan.org/pod/Dancer2) DSL conflicts with [Clustericious](https://metacpan.org/pod/Clustericious).

# AUTHOR

Graham Ollis &lt;plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
