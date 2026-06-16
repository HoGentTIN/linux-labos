# Labo Webserver (Enterprise Linux)

In dit labo zul je een webserver opzetten in de AlmaLinux server-VM die je in het vorige labo gemaakt hebt.

Eén van de redenen waarom Linux zo'n dominante positie heeft verworven in het datacenter is doordat het werd ingezet als een platform voor webapplicaties, meer bepaald in de vorm van de zgn. LAMP-stack. Deze afkorting staat voor Linux + Apache + MySQL + PHP. De combinatie vormt een platform voor het ontwikkelen van webapplicaties waar vele bekende websites (bv. Facebook) op gebaseerd zijn.

Beschrijf telkens zo precies mogelijk de procedure die je gevolgd hebt. Zorg er voor dat je aan de hand van je beschrijving deze taken later heel vlot kan herhalen als dat nodig is. Een goede procedurehandleiding is een eerste stap in het automatiseren van de installatie. Test ook telkens na elke stap dat die correct verlopen is.

## Apache installeren

Het is belangrijk dat je controleert voordat je aan dit labo begint, dat je twee netwerkinterfaces hebt op je virtuele machine. De ene moet van het type NAT zijn. Deze heeft verbinding met het internet en heeft typisch als IP-adres 10.0.2.15. De andere netwerkinterface moet van het type Internal Network zijn. Via deze kan je communiceren met de Linux GUI VM en je webserver testen. Als je niets hebt veranderd de standaardinstellingen van VirtualBox, is het server IP-adres hoogstwaarschijnlijk 192.168.76.2.

- Installeer Apache op je server-VM en verifieer dat hij draait en bereikbaar is vanuit een webbrowser in de GUI-VM.

- Installeer ondersteuning voor HTTPS en verifieer dat dit werkt, bijvoorbeeld met curl of een webbrowser.

    Verklaar de foutmeldingen die je krijgt als je dit probeert en zoek uit hoe je deze kan omzeilen. We gebruiken bewust het woord *omzeilen*, want je zal het niet kunnen *oplossen*. Kan je uitleggen waarom dat is?

- Installeer ondersteuning voor PHP en verifieer dat dit werkt, bijvoorbeeld met een eenvoudige PHP-pagina (bv. `<?php phpinfo; ?>`).

## MariaDB installeren

MariaDB is de naam van een variant (fork) van de bekende database MySQL. Op sommige Linux-distributies (zoals Fedora) is MySQL zelfs niet meer beschikbaar. MariaDB is wel grotendeels compatibel en kan perfect dienen als vervanger. Installeer MariaDB op je server-VM.

De databank opvullen met gegevens gebeurt in een volgend labo.

## Testen, logbestanden

1. Met welk commando test je of een host op het netwerk op dit moment online is? Probeer dit uit vanop je GUI-VM met het IP-adres van je server-VM en voeg de uitvoer hieronder in. Welk protocol uit de TCP/IP familie wordt door deze tool gebruikt?

2. Met het commando `ss -tln` kan je opvragen welke services er draaien op je systeem, ahv. de open (server-)netwerkpoorten. Leg uit wat de opties `-tln` betekenen. Probeer het commando uit op je server-VM wanneer Apache en MariaDB draaien en voeg de uitvoer hieronder in. Geef voor elke open poort beneden de 10.000 welke netwerkservice er (volgens de TCP/IP-standaarden) mee geassocieerd is.

3. Met welk commando kan je de logs voor een specifieke netwerkservice (bv. sshd, httpd, mariadb) bekijken?

4. Wat is de naam van het logbestand waar je kan opvolgen welke webpagina's er opgevraagd worden aan je webserver?

5. Open dit bestand met `tail -f` en laad een webpagina via een webbrowser. Wat gebeurt er in het logbestand?

6. Herhaal oefening 4. en 5. met een pagina die niet bestaat.
