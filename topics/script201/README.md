# Hst 7. script201 - Advanced scripting

## 1. Genereer een wachtwoordzin

Schrijf een script `passphrase.sh` dat een willekeurige wachtwoordzin genereert zoals gesuggereerd door <http://xkcd.com/936/>. Gebruik een woordenlijst zoals `/usr/share/dict/words` (moet je mogelijks installeren).

Opties en argumenten (kunnen in willekeurige volgorde staan):

- `passphrase.sh [-h|--help]`: druk uitleg over het commando af en sluit af met exit-status 0.
- `passphrase.sh [N] [WORDS]`
    - N = het aantal woorden in de wachtwoordzin (standaardwaarde = 4)
    - WORDS = het bestand dat de te gebruiken woordenlijst bevat (standaardwaarde = `/usr/share/dict/words`)
- Sluit af met een passende foutboodschap (op stderr!) en exit-status als er meer dan twee parameters gegeven werden
- Foutboodschappen worden ALTIJD naar `stderr` geschreven. Enkel de wachtwoordzin (en Usage-boodschap) wordt op `stdout` afgedrukt.
- Tip: met het commando `shuf` kan je de volgorde van lijnen tekst door elkaar schudden.

We geven al een sjabloon om mee te beginnen. Hierin zijn enkele best-practices voor het schrijven van Bash scripts verwerkt.

- De commentaar aan het begin van het script documenteert het gebruik.
- Start het script met de shell-opties voor niet gedefinieerde variabelen en commando's die falen. De optie `pipefail` moet je nu *niet* toevoegen.
- Declareer variabelen voor het aantal woorden en het bestand met de woordenlijst, en initialiseer ze met de standaardwaarden zoals hierboven gegeven.
- Er zijn al verschillende (lege) functies gedefinieerd. Aan jou om deze in te vullen. De functies bevatten momenteel het "lege" commando `:` zodat het script uitvoerbaar is. Verwijder het als je de functie implementeert.
    - De functie `main` (reeds ingevuld) roept eerst de functie op voor het verwerken van positionele parameters (zie verder) en vervolgens de functie die de wachtwoordzin genereert.
    - De functie `generate_passphrase` bevat de hoofdfunctionaliteit van het script en genereert een wachtwoordzin op basis van de instellingen (aantal woorden, woordenlijstbestand)
    - `process_cli_args` controleert eerst het aantal argumenten (en geeft een gepaste foutboodschap als dat niet ok is) en loopt daarna in een for-lus over alle argumenten. Aan de hand van een case-statement wordt beslist wat er moet gedaan worden:
        - Als `-h` of `--help` opgegeven werd, moet de `usage`-functie opgeroepen worden en wordt het script afgesloten.
        - Als een andere optie (beginnend met een `-`) werd opgegeven, moet je een foutboodschap afdrukken, de `usage`-functie oproepen en het script met een foutstatus afsluiten.
        - In elk ander geval veronderstellen we dat er een woordenlijstbestand of een aantal woorden werd opgegeven
        - Als het argument een bestand is, nemen we dat als woordenlijst en vullen dit in in de daarvoor bestemde variabele
        - In het andere geval veronderstellen we dat het een getal is (we gaan dit niet verder controleren) en vullen de overeenstemmende variabele in.
    - De `usage`-functie zal in het script-bestand op zoek gaan naar de commentaar ivm het gebruik van het script aan het begin van het bestand. Deze lijnen worden gekenmerkt door `##` aan het begin van de regel. Druk deze lijnen af, maar verwijder wel eerst de commentaartekens.

```console
$ ./passphrase.sh -h
Usage: ./passphrase.sh [N] [WORDLIST]
       ./passphrase.sh -h|--help
...
$ ./passphrase.sh 
swacking Super-christian bay-colored lavers 
$ ./passphrase.sh 6
restive Shishko bedrivels landiron -gen propurchase
$ ./passphrase.sh 1 2 3
At most two arguments expected, got 3
Usage: ...
$ ./passphrase.sh -v
Unknown option: -v
Usage: ...

```

## 2. Backup-script

Schrijf een script om een backup te maken van de gegeven directory, meer bepaald een Tar-archief gecomprimeerd met bzip2.

- Het archief krijgt als naam DIRECTORY-TIMESTAMP.tar.bz2 met:
    - DIRECTORY = de naam van de directory waarvan je een backup maakt
    - TIMESTAMP = de huidige datum/tijd in het formaat JJJJMMDDUUMM
    - vb. “osboxes-201312021825.tar.bz2” voor directory /home/osboxes
- Er wordt in dezelfde directory als het archief een log weggeschreven naar een bestand backup-TIMESTAMP.log van de uitvoer (zowel stdout als stderr) van het tar-commando.
- Gebruik: `backup.sh [OPTIES] [DIR]`
- Opties en argumenten:
    - `-h|-?|--help`: druk uitleg over het commando af en sluit af met exit-status 0. Eventuele andere opties en argumenten worden genegeerd.
    - `-d|--destination DIR`: de directory waar de backup naartoe geschreven moet worden. Standaardwaarde is `/tmp`
    - `DIR` de directory waarvan er een backup gemaakt moet worden. Standaardwaarde is de home-directory van de huidige gebruiker.
- Sluit af met een passende foutboodschap (op stderr!) en exit-status als:
    - de directory waarvan een backup gemaakt moet worden niet bestaat
    - de directory waar de backup naartoe geschreven moet worden niet bestaat

Ook hier kan je starten met het sjabloon dat op een gelijkaardige manier gestructureerd is als dat voor de vorige oefening.

## 3. Verbind met HOGENT VPN

Vanuit Linux een verbinding maken met de VPN-service van HOGENT (gebaseerd op Fortinet) is jammer genoeg niet zo eenvoudig. Er bestaat een Linux client van Fortinet zelf, maar sinds een recente versie lijkt die "onze" VPN-service niet meer te ondersteunen. Zowel GNOME of KDE ondersteunen VPN-verbindingen met allerlei vendors (Cisco, Fortinet, enz), maar daar heb je dan het probleem dat de authenticatie met Single Sign-On/SAML, zoals die voor alle diensten van HOGENT gebruikelijk is, niet ondersteund wordt. Gelukkig bestaat er een consoleapplicatie, [openfortivpn](https://github.com/adrienverge/openfortivpn/) die dat wél kan.

Doel van deze opdracht is om een script te schrijven, genaamd `vpn.sh`, dat het gebruik van `openfortivpn` zo eenvoudig mogelijk maakt zodat je de precieze configuratie en argumenten die je aan het commando moet meegeven niet hoeft te onthouden.

**Let op!** Dit script kan je enkel off-campus testen. Op de campus zal de VPN-verbinding niet werken.

- Opties en argumenten
    - `help`, `-h`, `--help`: druk een Usage:-boodschap af (vb. zie hieronder)
    - `info`, `status`: druk info ivm de huidige status van de VPN-verbinding af
    - `on`,  `true`,  `1`: zet de VPN-verbinding aan
    - `off`, `false`,  `0`: zet de VPN-verbinding aan
    - `check`, `deps`: controleer of alle nodige commando's geïnstalleerd zijn
- Verwerking van opties/argumenten
    - Je kan er voor zorgen dat opties/argumenten "case insensitive" zijn, bv. door ze eerst om te zetten naar kleine letters (kijk naar Bash parameter substitution)
    - Je kan er voor zorgen dat argumenten afgekort kunnen worden, zolang ze niet dubbelzinnig zijn (bv. `vpn.sh o` voor `on` of `off`, `c` of `ch` voor `check`). Voeg daarvoor waar nodig patronen toe aan het case-statement dat de argumenten verwerkt.
    - Als er geen argumenten gegeven worden, veronderstellen we dat de gebruiker `info` wil.
    - Als er meer dan één argument gegeven wordt, druk een foutboodschap af en sluit af met een foutstatus.
    - Als het argument niet herkend wordt, druk een foutboodschap af en suggereer hoe de gebruiker de Usage:-boodschap kan opvragen. Sluit af met een foutstatus.
- Globale variabelen
    - `vpn_endpoint`: voor de VPN-server (`vpn-ssl.hogent.be`)
    - `vpn_port`: voor de poort (`443`)
- De VPN-verbinding aanzetten gebeurt met volgende commando's:
    - `sudo openfortivpn "${vpn_endpoint}:${vpn_port}" --saml-login`
    - De output van dit commando zal vermelden dat je in een browser naar een bepaalde URL moet gaan om de authenticatie af te ronden. Je kan die URL automatisch in je browser openen met `xdg-open URL` (waarbij je `URL` vervangt door de juiste URL, gebruik makende van de variabelen voor VPN-server en poort).
    - Voer deze beide commando's uit op de achtergrond zodat je je prompt meteen terugkrijgt.
- De VPN-verbinding afsluiten gebeurt als volgt:
    - Gebruik eerst `pgrep` om het proces-ID van `sudo openfortivpn` op te zoeken. Sla deze op in een variabele (die leeg zal zijn als het proces niet gevonden werd).
    - Gebruik `sudo pkill` om het proces te beëindigen (als het gevonden werd) of geef een foutboodschap als het proces niet gevonden werd.
- Voor de status van de VPN-verbinding kan je het volgende tonen:
    - Zoek eerst naar het oudste Process-ID van `sudo openfortivpn`. Als het niet gevonden is, is VPN niet actief. Druk een boodschap af om dit aan de gebruiker te laten weten en sluit het script af met exit-status 0 (er is immers geen fout gebeurd).
    - Gebruik `pstree` om alle processen te tonen in een boomstructuur, startend vanaf deze die in de vorige stap gevonden was.
    - Toon IP-adresinformatie van netwerkinterface `ppp0` (dit is de naam van de virtuele netwerkinterface voor de VPN-verbinding)
    - Toon DNS-informatie voor de `ppp0` netwerkinterface (met `resolvectl`)
- De controle op de nodige commando's gebeurt als volgt:
    - De commando's `ip`, `openfortivpn`, `pgrep`, `pkill`, `pstree`, `resolvectl`, `xdg-open` moeten geïnstalleerd zijn. Maak hier een lijst of array voor aan.
    - Loop over elk element in de lijst/array en controleer met `which` of het commando bestaat.
        - Zo ja, druk de naam van het commando af en "OK"
        - Zo nee, druk de naam van het commando af en "FAIL"
        - Maak de tekst mooi op, bv. door de commando's en OK/FAIL mooi uit te lijnen en/of kleuren te gebruiken.
    - Op het einde druk je een tekst af die ofwel stelt dat alle commando's geïnstalleerd zijn, ofwel dat je nog bepaalde commando's moet installeren.
    - Vraag vervolgens de versie op van `openfortivpn` (met optie `--version`). Wanneer deze kleiner is dan 1.23.0, druk je een foutboodschap af dat deze versie niet geschikt is. Deze zal immers nog geen ondersteuning hebben voor SAML login.
    - Tip: je moet enkel controleren op de "minor version". Er bestaat geen release van `openfortivpn` met een "major version" kleiner dan 1.

Voorbeelden van gebruik. Merk op dat we hier het script gekopieerd hebben naar een directory in het `$PATH` van de gebruiker en dat we de extensie `.sh` hebben weggelaten.

```console
$ vpn
ℹ VPN connection does not seem to be active.

Enable VPN with command: vpn on
$ vpn foo
🔥 Invalid option or argument: foo
   Use "vpn help" for usage information
$ vpn help
Usage: vpn [COMMAND]

Use openfortivpn to connect to HOGENT's VPN endpoint with SAML login.

COMMANDS

  help, -h, --help
                 Print this help message
  info, status
                 Print status of the VPN connection
                 (default action)
  on, true, 1
                 Connect to the VPN endpoint
  off, false, 0
                 Disconnect from the VPN endpoint
  check, deps
                 Check whether necessary commands are installed

Commands (except on, off) can be abbreviated, e.g. c or ch instead of check.

EXAMPLES

 $ vpn           Shows VPN status
 $ vpn on        Connect VPN
 $ vpn 0         Disconnect VPN
 $ vpn --help    Print this help message
 $ vpn c         Check dependencies

REMARKS

The script asks for superuser access with sudo. You can configure sudo to
allow the command be executed without providing your user password, e.g. by
creating a file /etc/sudoers.d/openfortivpn with content:

  %wheel      ALL = (ALL) NOPASSWD: /usr/bin/openfortivpn

$ vpn check
ℹ Checking dependencies:
ip                            [ OK ]
openfortivpn                  [ OK ]
pgrep                         [ OK ]
pkill                         [ OK ]
pstree                        [FAIL]
resolvectl                    [ OK ]
xdg-open                      [ OK ]
🔥 One or more commands missing, ensure you have them installed!
openfortivpn version: 1.22.3  [FAIL]
🔥 Minimal required version is 1.23.0
   Your version of openfortivpn doesn't support SAML login!
   See <https://github.com/adrienverge/openfortivpn/blob/master/CHANGELOG.md#1230>
```

Na installatie van alle nodige packages zou je dit moeten zien:

```console
$ vpn check
ℹ Checking dependencies:
ip                            [ OK ]
openfortivpn                  [ OK ]
pgrep                         [ OK ]
pkill                         [ OK ]
pstree                        [ OK ]
resolvectl                    [ OK ]
xdg-open                      [ OK ]
✅ All commands are present!
openfortivpn version: 1.23.1  [ OK ]
```

Het aanzetten gebeurt zoals hieronder. Merk op dat niet alle tekst tegelijk getoond wordt, een deel zal je pas zien na inloggen via de browser.

```console
vpn on
🌐 Activating VPN connection.
INFO:   Listening for SAML login on port 8020
INFO:   Authenticate at 'https://vpn-ssl.hogent.be:443/remote/saml/start?redirect=1'
INFO:   Processing HTTP SAML request
INFO:   Connected to gateway.
INFO:   Authenticated.
INFO:   Remote gateway has allocated a VPN.
Using interface ppp0
Connect: ppp0 <--> /dev/pts/4
INFO:   Got addresses: [192.168.88.18], ns [193.190.173.1, 193.190.173.2], ns_suffix [hogent.be]
INFO:   Negotiation complete.
local  IP address 192.168.88.18
remote IP address 193.190.88.180
INFO:   Interface ppp0 is UP.
INFO:   Setting new routes...
INFO:   Adding VPN nameservers...
Dropped protocol specifier '.openfortivpn' from 'ppp0.openfortivpn'. Using 'ppp0' (ifindex=9).
INFO:   Tunnel is up and running.
```

Er zou nu een browservenster moeten geopend worden waar je kan aanmelden met je HOGENT-account. Je zal ook via de Outlook-app je login moeten bevestigen. Na afloop toont het browservenster deze boodschap:

> SAML session id received from Fortinet server. VPN will be established...
> You may close this browser tab now.
> 
> This window will close automatically in 5 seconds.

VPN is nu actief! Dit kan je testen met `vpn status`

```console
vpn status
ℹ Process info:
sudo,86059 openfortivpn vpn-ssl.hogent.be:443 --saml-login
  └─sudo,86130 openfortivpn vpn-ssl.hogent.be:443 --saml-login
      └─openfortivpn,86131 vpn-ssl.hogent.be 443 --saml-login
          ├─pppd,86175 230400 :169.254.2.1 noipdefault ipcp-accept-local noaccomp noauth default-asyncmap nopcomp receive-all nodefaultroute nodetach lcp-max-configure 40 mru 1354...
          ├─{openfortivpn},86176
          ├─{openfortivpn},86177
          ├─{openfortivpn},86178
          └─{openfortivpn},86179
ℹ IP:
9: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1354 qdisc fq_codel state UNKNOWN group default qlen 3
    link/ppp 
    inet 192.168.88.18 peer 193.190.88.180/32 scope global ppp0
       valid_lft forever preferred_lft forever
ℹ DNS:
Link 9 (ppp0): 193.190.173.1 193.190.173.2
```

De verbinding terug uitschakelen:

```console
$ vpn off
🛑 Stopping VPN connection.
[sudo] password for USERNAME: 
INFO:   Cancelling threads...
INFO:   Cleanup, joining threads...
INFO:   Setting ppp0 interface down.
INFO:   Restoring routes...
INFO:   Removing VPN nameservers...
Dropped protocol specifier '.openfortivpn' from 'ppp0.openfortivpn'. Using 'ppp0' (ifindex=9).
Hangup (SIGHUP)
Modem hangup
Connect time 4.9 minutes.
Sent 113056 bytes, received 114233 bytes.
Connection terminated.
INFO:   pppd: The link was terminated by the modem hanging up.
INFO:   Terminated pppd.
INFO:   Closed connection to gateway.
INFO:   Logged out.
```
