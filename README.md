Description
===========

portscan is a simple port scanner for random IPs or specified IP ranges. Logs the open ports to a separate text file.

Usage
=====

    perl portscan.pl -r IPRANGE -p PORTNUMBER -h -v

-p specifies the port number to scan, for example `-p 80` or `-p 80,443`.

-r speficies the IP range to scan, ignore it for random IP scanning. Ranges can be specified in the `10.80.0.1-10.80.1.255` or `10.80.1.0/24` formats.

-h shows the program help

-v shows the program version

Example
=======

    perl portscan.pl -r 10.80.0.1-10.80.1.255 -p 80,443

License
=======

portscan is written by sizeof(cat) <sizeofcat AT riseup DOT net> and released into the Public Domain. Read more in the [LICENSE](LICENSE) file.

Contributing
============

Contributions are welcome!

Source code
===========

The application can be downloaded from GitHub.com:

	git clone https://github.com/sizeofcat/portscan.git