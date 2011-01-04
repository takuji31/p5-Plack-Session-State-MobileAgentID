package Plack::Session::State::MobileAgentID;
use strict;
use warnings;

use parent qw/Plack::Session::State/;
use HTTP::MobileAgent;
use Carp();

our $VERSION = '0.01';

sub new {
    my $class = shift;
    bless {},$class;
}

sub get_session_id {
    my ( $self, $env ) = @_;

    my $mobile_agent = HTTP::MobileAgent->new;
    Carp::croak "Can't support this carrier"
        unless $mobile_agent->is_docomo
        || $mobile_agent->is_softbank
        || $mobile_agent->is_ezweb;
    my $id = $mobile_agent->user_id;

    return $id;

}

sub generate {
    my $self = shift;
    $self->get_session_id(@_);
}

1;
__END__

=head1 NAME

Plack::Session::State::MobileAgentID - Session state for Plack::Session by mobile user id.

=head1 SYNOPSIS

use Plack::Builder;
use Plack::Session::State::MobileAgentID;
my $app = sub { #do something };

builder {
    enable 'Session', state => Plack::Session::State::MobileAgentID->new;
    $app;
}

=head1 DESCRIPTION

Plack::Session::State::MobileAgentID is

=head1 AUTHOR

Nishibayashi Takuji E<lt>takuji {at} senchan.jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
