#Created by Tsubasa Kato - 5/17/2024 -> Conversion to timeout version done with ChatGPT - GPT-4o.
#(C)2024/5/17/2024 12:30PM Tsubasa Kato - Inspire Search Corporation
use strict;
use warnings;
use Socket;

my $dbfile = "ip.txt";
my $timeout = 5; # Timeout duration in seconds

open (my $I, '<', $dbfile) or die "Unable to open: $dbfile";
my @lines = <$I>;
close $I;

foreach my $ip (@lines) {
    chomp $ip;
    my $ipinfo = "";

    eval {
        local $SIG{ALRM} = sub { die "timeout\n" };
        alarm $timeout;

        $ipinfo = gethostbyaddr(pack('C4', split(/\./, $ip)), AF_INET);

        alarm 0;
    };

    if ($@) {
        if ($@ eq "timeout\n") {
            $ipinfo = "Timeout occurred";
        } else {
            die $@; # Propagate unexpected errors
        }
    }

    $ipinfo ||= "No address";

    open(my $OUT, '>>', 'ip-output.txt') or die "Unable to open ip-output.txt";
    print $OUT "$ip\t$ipinfo\n";
    close $OUT;

    print "$ip\t$ipinfo\n";
}
