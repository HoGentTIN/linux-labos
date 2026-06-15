# Labo Package Management (Debian)

1. Update de lijst van beschikbare software op je systeem. Toon een lijst van bij te werken packages (zonder deze ook daadwerkelijk bij te werken!) 

2. Kan je één package updaten (en de rest van de lijst niet), bv. Firefox?

3. Installeer onderstaande applicaties of “packages”. Zorg er voor dat je dit zowel via de grafische gebruikersinterface kan als vanop de command-line.

    - Git client
    - jq (JSON processor)
    - ShellCheck
    - VI Improved, incl. variant met GTK3 GUI

4. Download de package `sl` van de Ubuntu repository: <https://packages.ubuntu.com/resolute/games/sl>

    Of deze versie die meer aansluit bij de CPU-architectuur van de meeste laptops: <https://packages.ubuntu.com/resolute/amd64/sl/download>

    - Installeer vervolgens dit gedownload .deb bestand.
    - Kan je het commando sl nu laten werken in de CLI?

5. Kan je hetzelfde doen met de package cavepacker?

    - <https://packages.ubuntu.com/resolute/amd64/cavepacker/download>, tenzij je een ander type processor hebt.
    - Kan je met dpkg de informatie opvragen over deze package (zie man page)? Waardoor loop je vast?

6. Download deze package: <https://debian.inf.tu-dresden.de/debian/pool/main/i/isc-dhcp/isc-dhcp-server_4.4.3-P1-8_ppc64el.deb>

    - Waarom kan deze package nooit compatibel zijn met jouw VM?
    - Kan je alle bestanden oplijsten die deel uitmaken van deze package?
    - Hoe haal je de `dhcpd.conf` uit dit bestand?

7. De eerste keren dat je per ongeluk ` ` in plaats van ls intikt is het nog grappig dat er een ASCII-art trein voorbij rijdt, maar eens dit vervelend begint te worden wil je deze applicatie misschien verwijderen... Welk commando heb je daarvoor nodig?
