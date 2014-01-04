$TeXLive::waitVariableX::VERSION = '1.0';

package TeXLive::waitVariableX;

use Carp;
use Exporter;

use base qw/Exporter/;
@EXPORT = qw/waitVariableX/;
use strict;

sub waitVariableX {

    use Tie::Watch;

    my ($parent, $millis) = (shift, shift); # @_ has list of var refs

    croak "waitVariableX:  no milliseconds." unless defined $millis;
    my ($callback, $st, $tid, @watch, $why);

    if (ref $millis eq 'ARRAY') {
        $callback = Tk::Callback->new($millis->[1]);
        $millis = $millis->[0];
    }

    $st = sub {my $argv = $_[0]->Args('-store'); $why = $argv->[0]};
    foreach my $vref (@_) {
        push @watch,
            Tie::Watch->new(-variable => $vref, -store => [$st, $vref]);
    }
    $tid = $parent->after($millis => sub {$why = 0}) unless $millis == 0;

    $parent->waitVariable(\$why); # wait for timer or watchpoint(s)

    $_->Unwatch foreach @watch;
    $parent->afterCancel($tid);
    $callback->Call($why) if defined $callback;

    return $why;		# why we stopped waiting: 0 or $vref

} # end waitVariableX

1;
__END__


=head1 NAME

TeXLive::waitVariableX - a waitVariable with extensions.

=head1 SYNOPSIS

 use Tk::waitVariableX;

 $splash->waitVariableX( [$millis, $destroy_splashscreen], \$v1, \$v2} );

=head1 DESCRIPTION

This subroutine waits for a list of variables, with a timeout - the
subroutine returns when one of the variables changes value or the timeout
expires, whichever occurs first. 

Although the millisecond parameter is required, it may be zero, which
effects no timeout. The milliscond paramter may also be an array of
two elements, the first the millisecond value, and the second a 
normal Per/Tk callback. The callback is invoked just before 
waitVariableX returns.

Callback format is patterned after the Perl/Tk scheme: supply either a
code reference, or, supply an array reference and pass the callback
code reference in the first element of the array, followed by callback
arguments.

=head1 COPYRIGHT

Copyright (C) 2000 - 2002 Stephen O. Lidie. All rights reserved.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

This package is a literal copy of the original package only changing its name.
=cut
