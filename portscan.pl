#!/usr/bin/perl -w
#Scans random IPs or specified IP range for open ports

use IO::Socket::INET;
use Net::IP;
use strict;
use Term::ANSIColor;
use Getopt::Std;

print color "reset";
my %options = ();
getopts("hvp:r:", \%options);
my($ip);
my($port);
my $port_range = $options{p};
my $ip_range = $options{r};
my @ports = split /,/, $port_range;

if ($options{h}) {
	do_help();
	exit;
}

if ($options{v}) {
	do_version();
	exit;
}

if (!$options{p}) {
	do_help();
	exit;
}

$SIG{'INT'} = sub {
	print color "reset", "\n";
	exit(0);
};

sub do_help {
	print "\nScans random IPs or specified IP range for open ports.\n";
	print "\nUsage: perl portscan.pl -r IPRANGE -p PORTNUMBERS -h -v";
	print "\nExample: perl portscan.pl -r 10.80.0.1-10.80.1.255 -p 80,443";
	print "\nWritten by sizeof(cat) <sizeofcat\@riseup.net>";
	print "\nReleased on Public Domain.\n";
}

sub do_version {
	print "\nportscan version 1.1.0\n";
}

sub do_scan {
	my ($IP, $PORT) = @_;
	my $sock = new IO::Socket::INET (                
		PeerAddr => $IP,
		PeerPort => $PORT,        
		Proto => 'tcp',
		Timeout => '2',       
	);
	print color "reset";
	if ($sock) {
		print color "green";       
		print "IP $IP has port $PORT open.\n";               
		open (MYFILE, '>>portscan.log');
		print MYFILE "$IP:$PORT\n";
		close(MYFILE);
	} else {
		print color "red";
		print "IP $IP has port $PORT closed.\n";
	}
	print color "reset";
}

if ($options{r}) {
	my $ips = new Net::IP ($ip_range) || die "Unable to generate IP range\n";
	do {
		$ip = $ips->ip();
		foreach $port (@ports) {
			do_scan($ip, $port);
		}
	} while (++$ips);
} else {
	while(1) {
		my $random1 = int(rand(255));
		my $random2 = int(rand(255));
		my $random3 = int(rand(255));
		my $random4 = int(rand(255));
		chomp($ip = "$random1.$random2.$random3.$random4");
		foreach $port (@ports) {
			do_scan($ip, $port);
		}
	}
}