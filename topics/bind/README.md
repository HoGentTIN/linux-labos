# Labo DNS server met BIND

We gaan verder op de opstelling van het [Vagrant labo](../vagrant_rpm/), over het automatiseren van een serverinstallatie. We gaan deze opstelling nu uitbreiden met een server voor basis-netwerkdiensten DNS en later DHCP (zie ook het [DHCP-labo](../ip_dhcp/README.md)).

## Aan de slag

Op dit moment heb je een opstelling met verschillende VMs die aangesloten zijn op de VirtualBox `intnet` interface:

- Linux GUI-VM (sinds het begin van het semester!)
- `db` - Vagrant VM, ook opgezet in het Vagrant-labo
- `web` - Vagrant VM, opgezet in het Vagrant-labo

Om aan het labo te beginnen moet de Linux GUI-VM opgestart zijn. VMs `web` en `db` zijn voorlopig niet nodig.

We gaan wel een nieuwe VM aanmaken met de naam `srv`. Daarvoor moet je eerst in `vagrant-hosts.yml` volgende code toevoegen:

```yaml
- name: srv
  box: bento/almalinux-10
  ip: 192.168.76.254
  intnet: true
```

In de directory `provisioning/` moet je ook een script met de naam `srv.sh` toevoegen. Kopieer eventueel het script `web.sh` en verwijder alle code die te maken heeft met het installeren van Apache. Je kan ook in je Github repo de originele versie van `web.sh` opzoeken en die opslaan als `srv.sh`.

Start tenslotte de VM op met `vagrant up srv`.

## Iteratie 1. Caching name server

Om te beginnen installeren we BIND als een caching name server, d.w.z. BIND heeft zelf nog geen zonebestanden met resource records, maar gaat alle queries doorsturen naar een andere DNS server.

- Installeer BIND
- Zorg er voor dat BIND naar alle interfaces luistert en dat alle hosts DNS queries mogen sturen
- Zet in de configuratie van de BIND server de waarde dnssec-validation op no.
- Vergeet de configuratie van de firewall niet!
- Start de service op

Verwerk de voorgaande stappen in het provisioning-script, zodat je deze VM kan reconstrueren! Controleer telkens het resultaat!

- Voer de troubleshooting-taken voor de transportlaag uit: draait de service? Op welke poort(en)? Is de firewall correct geconfigureerd?
- Zet de query log aan voor de DNS service
- Open een aparte terminal met het systeemlog voor de BIND service (`journalctl -f` ...)
- Voer een DNS query uit vanop de server zelf (stuur de query naar localhost)
- Voer een DNS query uit vanaf de Linux GUI-VM
- Krijg je antwoord op je DNS queries? Wat zie je in de logs?
- Onze DNS-server heeft geen eigen zonebestanden. Hoe kan het dan toch antwoord geven op onze queries? Welke DNS-server is er m.a.w. verantwoordelijk voor het beantwoorden van onze queries?

## Iteratie 2. Authoritatieve name server

Gebruik het [voorbeeld in de slides](https://hogenttin.github.io/linux-slides/topics/bind.html) als basis om `srv` te configureren als een authoritative name server voor domein *linux.lan* met volgende hosts:

- `db` - 192.168.76.3
- `web` - 192.168.76.4, met alias `www`
- `srv` - 192.168.76.254, met alias `ns`
- `mail` - 192.168.76.10, met aliassen `imap` en `smtp`
    - dit is een fictieve host, we gaan deze niet implementeren!

Schrijf een zonebestand voor de forward zone (reverse lookup komt later) en pas het hoofdconfiguratiebestand aan. Controleer telkens de syntax van zowel je zonebestand als het hoofdconfiguratiebestand!

Verwerk ook deze stappen in het provisioning-script van de VM. Let er op dat als je bestanden kopieert naar de VM, deze de juiste permissies en eigendomsrechten hebben. Voor BIND is dit belangrijk! Kijk zelf na welke permissies de configuratiebestanden moeten hebben en pas deze toe op eventuele nieuwe bestanden die je naar de VM kopieert.

Test het resultaat! Doe een DNS query voor bv. `www.linux.lan`. Krijg je zowel het CNAME als het A-record terug?

Nog enkele zaken om uit te proberen:

- Kan je de mailserver en nameserver van het domein opvragen?
- Werkt een DNS query voor Google nog?
- Kan je een zonetransfer vragen vanop de Linux GUI-VM? En vanop `srv` zelf?

## Iteratie 3. Reverse lookup, authoritative only

Schrijf vervolgens een reverse lookup zone. Wat zal de naam voor deze zone moeten worden? Pas ook het hoofdconfiguratiebestand van BIND aan om deze zone te laden. Zet recursie nu uit (optie `recursion`). Zorg ook hier dat dit geautomatiseerd kan gebeuren!

Controleer opnieuw het resultaat: voer een "reverse lookup" uit met een van de IP-adressen van de hosts in linux.lan. Werkt een (forward) lookup voor google.com nog?

## Installatie DHCP

We hadden in een [eerder labo](../ip_dhcp/README.md) handmatig een DHCP-server geïnstalleerd op een AlmaLinux-VM. In dit labo gaan we deze functionaliteit toevoegen aan `srv`. Haal je labo-nota's van toen er bij en automatiseer de installatie en configuratie van de DHCP-server. Bij de subnet-declaratie geef je volgende zaken mee:

- de range blijft zoals in het vorige labo: 192.168.76.100-150
- geef de domeinnaam mee aan clients
- geef clients ook een DNS-server, nl. het IP-adres van `srv`

Als je de AlmaLinux-VM nog in gebruik hebt, sluit deze dan nu af. Voer het provisioning-script voor `srv` uit en verifieer dat de DHCP-service actief is.

Als je in de Linux GUI-VM een vast IP had ingesteld op de interface aangesloten op het intnet netwerk, verwijder dat dan en vraag opnieuw een IP-adres via DHCP. Zet de netwerkinterface uit en opnieuw aan. Controleer je nieuwe IP-adres en of er een DNS-server is ingesteld voor deze interface (`resolvectl status`).

Probeer opnieuw DNS-queries uit, maar zonder een DNS-server te specifiëren. Normaal zou nu zowel een query voor google.com (via NAT-interface) als `www.linux.lan` (via intnet-interface) moeten werken!

Probeer tenslotte in een webbrowser de website <http://www.linux.lan> te openen. Dit zou moeten werken als je de VMs db en web hebt opgestart.

## Afwerken opstelling

Controleer tenslotte nog eens of alle nodige code in de provisioning-scripts aanwezig is. Voer `vagrant destroy` uit en `vagrant up`. De 3 VMs zouden moeten opstarten, foutloos hun provisioning-script uitvoeren en de opstelling zou zonder verdere manuele handelingen moeten werken zoals daarnet!

**Optioneel:** Als je de VM `srv` ook wilt instellen als een NAT router, dan kan je instructies vinden in de syllabus onder "[managing firewalls: router with nat](https://hogenttin.github.io/linux-training-hogent/opslinux/firewall/#router-with-nat)". Samen met de DHCP en DNS services wordt deze VM dan een volwaardige gateway voor het lokale netwerk!
