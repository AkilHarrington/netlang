# branch.nl: two switches and a router

devices
    SW1  switch  2960-24TT
    SW2  switch  2960-24TT
    R1   router  2911

links
    SW1 g0/1  <->  SW2 g0/1
    SW1 g0/2  <->  R1 g0/1

vlans
    10  Sales
    20  Voice

ports 1-10 on SW1, SW2
    data   Sales      # PCs
    voice  Voice      # phones plugged in front of the PCs

ip R1 g0/0  192.168.10.1/24

## this is the first broken example I made where I incorrectly assigned the IP Address to R1s G0/0 port instead of G0/1
# DELIBERATELY BROKEN: IP is on R1 g0/0, which isn't connected.
# Expected error: R1 g0/1 connects to SW1 but has no IP.