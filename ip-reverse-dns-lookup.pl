use Socket;
$dbfile = "ip.txt";

open (I, "$dbfile") or die "Unable to open: $dbfile";
my @lines = <I>;
close I;

foreach (@lines){
	chomp;
	$ip = $_;
	$ipinfo = gethostbyaddr(pack('C4',split('\.', $ip)), AF_INET);
	print gethostbyaddr(pack('C4',split('\.', $ip)), AF_INET);
	
	print "\n";
	
	if ($ipinfo eq ""){
	$ipinfo = "No address";
	}

	
	open(OUT,">> ip-output.txt");
	print OUT "$ip	$ipinfo\n";
	close(OUT); 

}
