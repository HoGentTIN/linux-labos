# Task scheduling

## Job control

1. Start het commando `sleep 500` in de terminal. Zorg ervoor dat je terminal meteen weer vrijkomt voor nieuwe commando's zonder het proces te stoppen.

2. Start het commando `sleep 600`, nu in de voorgrond.

    - Pauzeer het actieve commando zodat je de prompt terugkrijgt.
    - Bekijk de lijst met actieve jobs.
    - Laat het commando nu verder draaien, maar in de achtergrond.

3. Onderbreek beide commando's terwijl ze in de achtergrond draaien. Bekijk opnieuw de lijst met actieve jobs.

## Eenmalige taken plannen

1. Plan een taak in die over exact 3 minuten vanaf nu de tekst "Labo at-commando geslaagd" wegschrijft naar een nieuw bestand genaamd `at_test.txt` in je thuismap.

    - Toon de lijst met geplande taken

    - Controleer dat het bestand correct wordt aangemaakt op het juiste tijdstip. Gebruik eventueel `watch` of `tail -f` om meteen te zien wanneer het bestand wordt aangemaakt.

2. Plan een taak in die vanavond om 23:30 uur het commando `whoami` uitvoert.

    - Vraag de lijst op van al jouw geplande at-taken en zoek het ID van de taak die je net hebt aangemaakt.
    - Verwijder deze taak uit de wachtrij zodat deze vanavond niet wordt uitgevoerd.

## Periodieke taken plannen

1. Open de crontab-configuratie voor jouw huidige gebruiker.

2. Plan eerst een taak die elke minuut de tekst "yyyy-mm-dd HH:MM:SS - Labo cronjob geslaagd" toevoegt aan het einde van een bestand genaamd `cron_test.txt` in de directory voor tijdelijke bestanden. Vervang daarbij uiteraard `yyyy-mm-dd HH:MM:SS` door de huidige datum en tijd in dat formaat. Observeer de correcte werking van de cronjob door het bestand te bekijken. Verwijder de cronjob (of zet deze in commentaar) als dit gelukt is.

3. Voeg regels toe aan je crontab om op de hieronder gegeven tijdstippen met het commando `logger` een boodschap weg te schrijven naar de systeemlog met de beschikbare vrije schijfruimte op de root-partitie. Gebruik daarvoor `df` en filter de output zodat alleen de gewenste info overblijft. De logboodschap moet er als volgt uitzien: "Free disk space: XG", waarbij X de beschikbare vrije schijfruimte is (in dit geval in gigabytes).

    - Elke vijf minuten
    - Elke dag om 8 uur 's ochtends
    - Elke maandag om 12 uur 's middags
    - Op de eerste dag van elke maand om middernacht
    - Elke maandag en vrijdag van de zomervakantiemaanden, na de middag, telkens om het uur om 15 minuten na het uur (vb. 13:15, 14:15, enz.)
    - Telkens bij het opstarten van het systeem

Controleer de werking door de systeemlogs te bekijken met `journalctl`. Je kan normaal de logboodschappen die jij hebt toegevoegd filteren met `journalctl -t GEBRUIKER` (GEBRUIKER vervangen door je eigen gebruikersnaam).

Voorbeeld:

```console
student@debian:~$ sudo journalctl -f -t student
Jun 15 21:03:42 debian student[2883]: Test
Jun 15 21:23:01 debian student[3037]: Free disk space: 55G
Jun 15 21:24:01 debian student[3062]: Free disk space: 55G
Jun 15 21:25:01 debian student[3077]: Free disk space: 55G
Jun 15 21:26:01 debian student[3084]: Free disk space: 55G
```

De eerste lijn van de output is een testboodschap die we handmatig hebben toegevoegd met `logger Test` om uit te proberen hoe het commando werkt. De volgende lijnen zijn de output van onze cronjob die we als test elke minuut de vrije schijfruimte lieten loggen om te controleren dat de cronjob correct werkt. Door de optie `-f` te gebruiken bij `journalctl` kunnen we meteen zien wanneer er nieuwe logboodschappen bijkomen.
