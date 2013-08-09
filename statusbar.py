#!/usr/bin/env perl

use strict;
use warnings;

use POSIX 'strftime';
use Net::Ping;

my $sep = '│';
my %bat_state_label = (
        'charging' => '￪',
        'discharging' => '￬',
        'full' => '',
    );
my $cpu_count = 2;
my($ping_host,$ping_timeout) = ("www.google.com",0.5);
my @disks_monitored = qw(/ /tmp);

sub clock { strftime("%a %b %-d, %-H:%M", localtime) }

sub login { chop($_=$ENV{USER}.'@'.`hostname`); $_ }

sub battery {
    $_ = [split /\n/,`acpi`]->[0];
    my $bat_time = /\d\d:\d\d:\d\d/ ? $& : undef;
    return unless $bat_time;
    my $bat_state = /Charging|Discharging|Full/ ? lc $& : undef;
    my $bat_load = /\d+(?=%)/ ? $& : undef;

    $_ = join(' ', grep {$_}
        $bat_state_label{$bat_state},
        "$bat_load%",
        substr($bat_time, 0, 5));

    $_ = "#[fg=colour7, bg=colour1]$_#[fg=default, bg=default]"
        if $bat_load <= 15 and $bat_state eq 'discharging';

    $_
}

sub load_avg {
    $_ = int([split / /,`cat /proc/loadavg`]->[0] / $cpu_count * 100);
    return if $_ < 70;
    "#[fg=colour1]$_%#[fg=default]"
}

sub ping {
    $_ = Net::Ping->new('udp', $ping_timeout);
    return if @{[$_->ping($ping_host)]};
    "#[fg=colour1]X#[fg=default]"
}

sub df {
    @_ = ();
    open DF, join(' ', 'df', @disks_monitored).'|';
    $_ = <DF>;
    while(<DF>) {
        my($filesystem,$size,$used,$available,$percent,$mount)
            = split /\s+/, $_;
        chop $percent;
        push @_, "#[fg=colour1]$percent% $mount#[fg=default]"
            if $percent > 95;
    }
    @_;
}

print "$sep ",join(" $sep ", grep {$_}
        &df,
        &load_avg,
        join(' ', grep {$_} &login, &ping),
        &battery,
        &clock.' ',
    ),"\n";
