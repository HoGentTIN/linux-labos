# Labo Mounting filesystems

Deze labo-oefeningen gaan er van uit dat je de extra VDI hebt toegevoegd aan jouw Linux GUI-VM.

Omdat je voor quasi alle commando's root-rechten nodig hebt, is het voor deze oefening te verantwoorden om effectief in te loggen als de root-gebruiker!

1. Ga naar de map `/mnt`. Maak er twee submappen aan, genaamd `booty/` en `kernel/`.

    - Mount `/dev/sdb1` op zowel de map `booty/` als `kernel/`.
    - Kopieer het bestand `/boot/vmlinuz` (wat is dit bestand trouwens?) naar de map `/mnt/booty`.
    - Is het bestand nu ook aanwezig in de map `/mnt/kernel`? Leg uit.

2. Hermount `/dev/sdb1` read-only op `kernel/` (opties `-o remount,bind,ro`). Verbreek de verbinding met de map `/mnt/booty`.

    - Probeer nu in `/mnt/kernel` het bestand dat je kopieerde te verwijderen. Waarom lukt dit niet?

3. Installeer de tool `gparted` op jouw systeem. Bekijk (grafisch) welke ruimte er nog vrij is op deze harde schijf.

    - Kan je nog een primaire partitie aanmaken?
    - Kan je nog een logische partitie aanmaken?
    - Sluit de grafische tool

4. Maak met `fdisk` een nieuwe partitie aan die de volledige vrije ruimte gebruikt.

    - Welk naam krijgt deze block device? Hoeveel opslagruimte is er in deze partitie?
    - Formateer deze partitie met NTFS

5. Bewerk het bestand `/etc/fstab`. Voeg een lijn toe die deze nieuwe NTFS-partitie koppelt aan de map `/mnt/kernel`.

    - Test dit uit door gewoon `mount /dev/PARTITIE` (met PARTITIE de naam van de block device) uit te voeren. Je hoeft de doelmap niet expliciet op te geven; de aanvullende info komt uit `/etc/fstab`!
    - Toon de aan de directorystructuur gekoppelde partities met `findmnt`

6. Zoek de UUID van de partitie `/dev/sdb3`. Voeg een lijn toe in `/etc/fstab`, die deze partitie mount op `/mnt/booty`.

    - Test dit uit door `mount /mnt/booty` (zonder device) uit te voeren.
    - Toon opnieuw de gekoppelde partities met `findmnt`.

7. Bekijk de inhoud van de map `/mnt/kernel`. Waar is het bestand heen? Bekijk opnieuw de gekoppelde partities en verklaar.
