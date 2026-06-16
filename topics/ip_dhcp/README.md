# Labo IP-configuratie, DHCP server (Kea)

In dit deel van het labo gaan we een tweede (server-)VM aanmaken en er een LAN opzetten waar onze Linux GUI-VM en deze nieuwe deel van zullen uitmaken. Het LAN heeft als netwerk-adres 192.168.76.0/24.

## Configuratie Linux GUI VM

1. Open in VirtualBox de VM *Settings > Network > Adapter 2*. Kies *Internal Network* in het dropdown-tekstvak. Klik *OK* om te bevestigen.

2. In de Linux GUI-VM, klik op het icoontje voor de netwerkinstellingen en dan *Network connections*. Selecteer de tweede netwerkadapter.

3. Selecteer het tabblad *IPv4 Settings* en vul volgende informatie in:

    - Method: Manual
    - Addresses: Add, en vervolgens als Address "192.168.76.13" en Netmask "24".
    - Voor Gateway en DNS servers vul je niet in.

4. Bevestig met *Save*. Controleer dat de netwerkadapter een IP-adres heeft door in een terminal `ip a` uit te voeren.

## Configuratie van de server-VM

Op deze VM draait een andere Linux-distributie, nl. AlmaLinux 10. Deze is afgeleid van RedHat Enterprise Linux 10 (RHEL). Om RHEL te installeren heb je in principe een (betalend) service-contract nodig bij RedHat. AlmaLinux is een gratis en volledig compatibel alternatief. RHEL (en compatibele distributies, gezamenlijk onder de noemer *Enterprise Linux* of EL geplaatst) worden beschouwd als kwalitatieve, stabiele en goed beveiligde distributies en worden daarom vaak gebruikt als server-OS.

Deze VM heeft een gebruiker `vagrant` met wachtwoord `vagrant` met `sudo`-privileges. Op de VM is de service `sshd` (wordt in een ander hoofdstuk behandeld) actief. Er zijn 2 netwerkkaarten. De eerste is aangesloten op een NAT-interface (en zorgt voor internettoegang), de andere is ook een "intnet" interface. De twee VMs zullen via deze laatste interface met elkaar kunnen communiceren. Na het labo sluit je deze VM best af met het commando `sudo poweroff` en niet door het VirtualBox-venster te sluiten.

1. Importeer het .ova-bestand met de server-VM in VirtualBox en start op. Je kan indien nodig de toetsenbordinstellingen aanpassen naar AZERTY met `sudo localectl set-keymap be`.

2. Pas de netwerkinstellingen aan:

    - Zorg dat de tweede netwerkinterface permanent een vast IP-adres toegekend krijgt (nl. 192.168.76.254/24)
    - Op deze netwerkinterface wordt geen default gateway of DNS-server ingesteld.

3. Pas de wijzigingen toe en controleer het effect met `ip a`.

4. Als beide VMs het juiste IP-adres hebben, dan zou je moeten kunnen pingen tussen de twee. Controleer dit in beide richtingen.

5. Welke voorwaarden moeten voldaan zijn zodat twee hosts op eenzelfde LAN naar elkaar kunnen pingen?

## DHCP Server (Kea)

De volgende stap is nu om van de AlmaLinux-VM een DHCP-server te maken.

1. Installeer [Kea DHCP van ISC](https://www.isc.org/kea/).

2. Bewerk het gepaste configuratiebestand (je begint best met een van de beschikbare voorbeelden):

    - Declareer een subnet voor IP netwerk 192.168.76.0/24.
    - Deze DHCP-server deelt dynamische IP-adressen uit vanaf 192.168.76.101 tot en met 192.168.76.253.
    - De default lease time komt op 3u, de maximale op 7u.

3. Eens de configuratie klaar is, start je de service op en zorg je er meteen voor dat deze ook bij booten van de VM meteen wordt opgestart.

4. (Her)configureer opnieuw de tweede netwerkinterface van de Linux GUI-VM. Stel deze opnieuw in om een IP-adres via DHCP aan te vragen. Herstart de netwerkinterface en controleer of je een IP-adres krijgt en of dat overeenkomt met de DHCP-configuratie. Volg het gedrag van de DHCP-server via de systeemlogs (`journalctl -f`).

5. Je kan (optioneel) ook de DHCP-configuratie aanpassen en om de Linux GUI-VM altijd hetzelfde gereserveerde IP-adres te geven.

    - Dit gebeurt op basis van het MAC-adres van de client
    - Stel de maximale lease time in op 24u

    Na wijziging van het configuratiebestand start je de service opnieuw op en controleer je of de Linux-GUI VM het verwachte IP-adres krijgt.

6. Wat moet je doen om er voor te zorgen dat je Linux GUI-VM opnieuw Internet-toegang kan krijgen?

7. Een (optionele) uitbreiding van het labo is om van de AlmaLinux VM ook een router te maken. Deze biedt dan volwaardige internettoegang aan de Linux GUI-VM en voorziet dus alle clients niet alleen van een IP adres, maar ook van een default gateway en DNS server. Om (NAT) routering aan te zetten op de AlmaLinux-VM, voer je volgende stappen uit:

    - Bewerk `/etc/sysctl.conf` en voeg een lijn toe met: `net.ipv4.ip_forward=1`
    - Voer (als root) `sysctl -p` uit

    De VM is nu een router, maar je moet ook nog NAT aanzetten. Dat kan met volgende commando's (als root):

    ```bash
    nft add table nat
    nft 'add chain nat postrouting { type nat hook postrouting priority 100 ; }'
    nft add rule nat postrouting masquerade
    ```
