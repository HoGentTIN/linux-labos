# Labo Organising Users

## Gebruikes en groepen aanmaken

Het doel van deze opgave is om de opdrachten en de begrippen met betrekking tot gebruikers en groepen te bestuderen, binnen de context van Linux als een multi-user-systeem.

De VM komt met een default user `hogent` - dat ben jij (nu toch nog)! Log in als deze gebruiker.

- Geef hieronder telkens het commando en de uitvoer
- Wat is het commando om de huidige directory op te vragen? In welke map bevind je je nu?
- Wat is het UID van deze gebruiker, wat is de GID?

### adduser

Maak een nieuwe gebruiker aan met de naam `alice`, zonder specifieke opties. Werk hiervoor met `adduser`.

Voorzie een geschikt wachtwoord voor deze gebruiker en vergeet het niet! Noteer het eventueel in je verslag of in de beschrijving van je VM

### Configuratiebestanden voor gebruikersbeheer

- In welk bestand kan je de UID, gebruikersnaam, homedirectory, enz. van alle gebruikers terugvinden?
- In welk configuratiebestand kan je al de bestaande gebruikersgroepen nakijken, en ook de gebruikers die lid zijn van elke groep?
- In welk configuratiebestand vind je de wachtwoorden van alle gebruikers?

### Gebruikersgroepen aanmaken

- Maak een groep aan met de naam `sporten`
- In welk configuratiebestand vind je het GID van deze groep terug?
- Wat zal het GID zijn van de groepen `zwemmen` en `judo` als je deze nu onmiddellijk zou aanmaken? Maak ze aan en controleer!
- Voeg de gebruiker `alice` toe aan de groepen `sporten` en `zwemmen`
- Log in als `alice` door in een terminal het commando `su - alice` (let op de spaties!) uit te voeren
- Zorg er nu voor dat de groep `sporten` de primaire groep wordt van `alice`.
- Zorg er voor dat `alice` uitgelogd is, ga terug naar `root`

### Gebruikers en groepen beheren

Maak nu de gebruikers in onderstaande tabel aan. Zorg er voor dat ze al meteen bij aanmaken tot de aangegeven groepen behoren. Kies zelf geschikte wachtwoorden voor deze gebruikers en vergeet ze niet (vul eventueel een kolom toe aan de tabel).

| Gebruiker | Primaire groep | Aanvullende groepen |
| :-------: | :------------: | :-----------------: |
|   `bob`   |   `sporten`    |       `judo`        |
|  `carol`  |   `sporten`    |      `zwemmen`      |
| `daniel`  |   `sporten`    |       `judo`        |
|   `eva`   |   `sporten`    |      `zwemmen`      |

1. Geef de gebruikte commando's om de gebruikers aan te maken en ook om te verifiëren of dit correct gebeurd is:

2. Verwijder nu de groep `alice` en controleer.

3. Gebruiker `daniel` gaat een tijdje niet meer sporten. Zorg er voor dat deze gebruiker tot nader order geen toegang meer kan hebben tot het systeem (zonder het wachtwoord of de gebruiker te verwijderen!).

4. Hoe kan je controleren dat `daniel` inderdaad geen toegang meer heeft tot het systeem? In welk bestand kan dat en hoe zie je daar dan dat het account afgesloten is?

5. Gebruiker `daniel` komt terug naar de sportclub. Geef hem opnieuw toegang tot het systeem.

6. Gebruiker `eva` stopt helemaal met sporten. Verwijder deze gebruiker, maar doe dit zorgvuldig: zorg er in het bijzonder voor dat ook haar homedirectory verwijderd wordt.

7. Log aan als de gebruiker `carol`. Controleer of je in de "thuismap" bent van deze gebruiker. Maak onder deze map een bestand test aan door middel van het commando `touch`.

8. Probeer nu als gebruiker `carol` je te verplaatsen naar de “thuismap” van `alice`.

9. Kan je de inhoud van de mappen binnen de thuismap van `alice` bekijken?

10. Probeer nu als `carol` onder de "thuismap" van `alice` ook een bestand test te maken. Lukt dit? Kan je dit verklaren?

### Werken als `root`

1. Bekijk de eerste regels van het bestand `/etc/shadow`. Wat bemerk je bij de gebruiker root?

2. Log in als de root-gebruiker met het commando `sudo -i` (let op de spatie!) 

    - Wat is de home-directory van root?
    - Wat is het UID van deze gebruiker, wat is de GID?

3. Stel, nog steeds ingelogd als root, een wachtwoord in voor root. Kies een uniek, nieuw wachtwoord!

4. Merk je de verandering in /etc/shadow?

5. Log in als de root-gebruiker met het commando `su -` (let op de spatie!)

6. Log uit, en log opnieuw in met `sudo su -`. Wat wordt er anders?

### Jezelf toevoegen en admin maken

1. Voeg jezelf (met je eigen gekozen loginnaam) toe aan de VM waarin we werken. Gebruik hiervoor `useradd` en voeg de nodige opties toe zodat je een homedirectory krijgt en bash gebruikt als default shell.

2. Bekijk `/etc/shadow`. Bemerk dat jijzelf als gebruiker nog geen wachtwoord hebt! Stel het in met `passwd`

3. Nu wil je jezelf eveneens adminstrator van het systeem maken, zodat je met `sudo` beheerstaken kan uitvoeren. Aan welke groep voeg je jezelf hiervoor toe?

4. Wanneer je jezelf toevoegt aan deze groep, zal je wellicht nog niet meteen adminrechten hebben. Je kan dit oplossen door uit te loggen en opnieuw in te loggen, maar er is ook een commando dat je kan gebruiken om dit meteen te laten gelden. Welk commando is dat?
