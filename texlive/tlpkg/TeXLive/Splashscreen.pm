# $Id: Splashscreen.pm 16713 2010-01-14 18:13:06Z karl $
# TeXLive::Splashscreen.pm - module for initial splash screen
# See end for copyright.
# 

$TeXLive::Splashscreen::VERSION = '1.0';

package TeXLive::Splashscreen;

use Tk qw/Ev/;
use Tk qw/:eventtypes/;
use TeXLive::waitVariableX;
use Tk::widgets qw/Toplevel/;
use base qw/Tk::Toplevel/;

Construct Tk::Widget 'Splashscreen';

sub Populate {
    my ($self, $args) = @_;

    $self->withdraw;
    $self->overrideredirect(1);

    $self->SUPER::Populate($args);

    $self->{ofx} = 0;           # X offset from top-left corner to cursor
    $self->{ofy} = 0;           # Y offset from top-left corner to cursor
    $self->{tm0} = 0;           # microseconds time widget was Shown

    $self->ConfigSpecs(
        -milliseconds => [qw/PASSIVE milliseconds Milliseconds 0/],
    );

    $self->bind('<ButtonPress-3>'   => [$self => 'b3prs', Ev('x'), Ev('y')]);
    $self->bind('<ButtonRelease-3>' => [$self => 'b3rls', Ev('X'), Ev('Y')]);

} # end Populate

# Object methods.

sub Destroy {


    my ($self, $millis) = @_;

    $millis = $self->cget(-milliseconds) unless defined $millis;
    my $t = Tk::timeofday;
    $millis = $millis - ( ($t - $self->{tm0}) * 1000 );
    $millis = 0 if $millis < 0;

    my $destroy_splashscreen = sub {
	$self->update;
	$self->after(100);	# ensure 100% of PB seen
	$self->destroy;
    };

    do { &$destroy_splashscreen; return } if $millis == 0;

    while ( $self->DoOneEvent (DONT_WAIT | TIMER_EVENTS)) {}

    $self->waitVariableX( [$millis, $destroy_splashscreen] );

} # end Destroy

sub Splash {

    my ($self, $millis) = @_;

    $millis = $self->cget(-milliseconds) unless defined $millis;
    $self->{tm0} = Tk::timeofday;
    $self->configure(-milliseconds => $millis);
    $self->Popup;

} # end_splash

# Private methods.

sub b3prs {
    my ($self, $x, $y) = @_;
    $self->{ofx} = $x;
    $self->{ofy} = $y;
} # end b3prs

sub b3rls {
    my($self, $X, $Y) = @_;
    $X -= $self->{ofx};
    $Y -= $self->{ofy};
    $self->geometry("+${X}+${Y}");
} # end b3rls

1;
__END__


=head1 NAME

TeXLive::Splashscreen - display a Splashscreen during program initialization.

=head1 SYNOPSIS

 $splash = $parent->Splashscreen(-opt => val, ... );

=head1 DESCRIPTION

For programs that require large load times, it's a common practice to
display a Splashscreen that occupies the user's attention.  This
Toplevel mega widget provides all the display, destroy and timing
events.  All you do it create the Splashscreen mega widget, populate
it as you see fit, then invoke Splash() to display it and Destroy() to
tear it down.

Important note: be sure to sprinkle update() calls throughout your
initialization code so that any Splashscreen events are handled.
Remember, the screen may be animated, or the user may be simply moving
the Splashscreen about.

=head1 OPTIONS

The following option/value pairs are supported:

=over 4

=item B<-milliseconds>

The minimum number of milliseconds the Splashscreen should remain on
the screen.  Default is 0, which means that the Splashscreen is 
destroyed as soon as Destroy() is called.  Otherwise, Destroy() waits
for the specified time interval to elapse before destroying the
Splashscreen.

=back

=head1 METHODS

=head2 $splash->Splash([B<milliseconds>]);

If B<milliseconds> is specified, it's the minimum number of
milliseconds the Splashscreen should remain on the screen.
This value takes precedence over that specified on the
Splashscreen constructor call.

=head2 $splash->Destroy([B<milliseconds>]);

If B<milliseconds> is specified, it's the minimum number of
milliseconds the Splashscreen should remain on the screen.
This value takes precedence over that specified on the
Splash() call, which takes precedence over that specified
during Splashscreen construction.

=head1 BINDINGS

=head2 <ButtonPress-3>

Notifies the Splashscreen to set a mark for an impending move.

=head2 <ButtonRelease-3>

Moves the Splashscreen from the mark to the cursor's current position.

=head1 ADVERTISED WIDGETS

Component subwidgets can be accessed via the B<Subwidget> method.
This mega widget has no advertised subwidgets. Instead, treat the
widget reference as a Toplevel and populate it as desired.

=head1 EXAMPLE

 $splash = $mw->Splashscreen;

 ... populate the Splashscreen toplevel as desired ...

 $splash->Splash(4000);

 ... program initialization ...

 $splash->Destroy;

=head1 AUTHOR

Stephen.O.Lidie@Lehigh.EDU

Copyright (C) 2001 - 2002, Steve Lidie. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

This package is a literal copy of the Splashscreen.pm code only changing
the package name.

=head1 KEYWORDS

Splashscreen, Toplevel

=cut
