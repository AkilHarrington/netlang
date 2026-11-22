# Findings, 22 Nov 2026 (Packet Tracer 9.0.1.0858)

## 2911 router
- IOS 15.1(4)M4, image C2900-UNIVERSALK9-M
- Ports: GigabitEthernet0/0, 0/1, 0/2 (plus a Vlan1 interface, likely a PT quirk)
- All ports administratively down by default -> compiler must add `no shutdown`
- Evidence: 2911_show-version.txt, 2911_show-ip-int-brief.txt

## 2960-24TT switch
- IOS 15.0(2)SE4, image C2960-LANBASEK9-M, model WS-C2960-24TT-L
- Ports: FastEthernet0/1-24, GigabitEthernet0/1-2, Vlan1 (administratively down)
- Switch ports are enabled by default (status "down" = no cable, not shut)
- Trunk options: allowed, native only -> NO `switchport trunk encapsulation` line
- Evidence: 2960-24TT_show-version.txt, 2960-24TT_switchport-trunk.txt

## 3560-24PS switch
- IOS 12.2(37)SE1, image C3560-ADVIPSERVICESK9-M, model WS-C3560-24PS-E
- Ports: FastEthernet0/1-24, GigabitEthernet0/1-2, Vlan1
- Switch ports enabled by default; Vlan1 administratively down
- Trunk options: allowed, encapsulation, native
  -> compiler must output `switchport trunk encapsulation dot1q` BEFORE `switchport mode trunk`
- Evidence: 3560-24PS_show-version.txt, 3560-24PS_show-ip-int-brief.txt, 3560-24PS_switchport-trunk.txt

## Packet Tracer vs real IOS
- `terminal length 0` rejected on the 2911 (valid on real IOS)
- 2960 `switchport trunk ?` lacks `pruning`, which real 2960s offer
- 2911 show version output is shorter than on real hardware

## Lab tips
- A mistyped command in privileged mode (e.g. `conft`) is treated as a hostname
  lookup and hangs. Engineers prevent this with `no ip domain-lookup`
  (candidate best-practice warning for v0.2).
