# Labo Scripting 102

## Fouten opsporen/voorkomen

Vanaf nu begin je elk script met de volgende drie lijnen:

```bash
set -o errexit
set -o nounset
set -o pipefail
```

1. Zoek in de man-page van Bash op wat deze opties precies doen.

2. Hoe kan je deze drie commando's zo compact mogelijk herschrijven?

3. Installeer `shellcheck` op je Linux-VM en controleer je scripts uit [Labo Scripting 101](../script101/). Bekijk de foutmeldingen en probeer ze te begrijpen. Pas zo nodig je scripts aan zodat er geen fouten meer zijn.

Blijf ook in de toekomst telkens `shellcheck` gebruiken om je scripts te controleren!

## Booleans en exitstatus, voorwaardelijke statements

### Gebruikersinvoer en getallen vergelijken

In het voorjaar van 2026 werd een Europese app geïntroduceerd die beweerde op een veilige manier de leeftijd van gebruikers te kunnen verifiëren. Kort erna werd door een security researcher [een kwetsbaarheid ontdekt in de app](https://cybernews.com/security/eu-age-verification-app-hack/), waardoor de verificatie makkelijk te omzeilen was. Kan jij het beter? :wink:

Schrijf een script `age-verification.sh` dat de gebruiker vraagt om zijn/haar leeftijd in te voeren. Als de gebruiker 18 jaar of ouder is, druk dan een boodschap af dat toegang verleend wordt. Je kan je script nog iets geestigs laten doen, als je dat wilt. Let natuurlijk wel op met NSFW content in een educatieve context... :wink:

Indien de verificatie faalt, druk een boodschap af dat toegang geweigerd wordt.

Zorg ervoor dat je script ook werkt als de gebruiker een niet-numerieke waarde invoert (bv. "twintig") of helemaal niets invoert. Vraag in beide gevallen om een numerieke waarde in te voeren.

Het script sluit uiteraard in alle omstandigheden af met een gepaste exit-status.

### Check .ssh/ permissies

Schrijf een script `check-ssh-permissions.sh` dat controleert of de permissies van de `.ssh` directory in je home-directory en je publieke en private sleutel(s) in die directory correct zijn ingesteld. Druk een boodschap af voor elke permissie die niet correct is ingesteld, en welke de correcte permissies moeten zijn. Sluit af met een exit-status van 1 als er één of meerdere problemen gevonden werden. Als alles in orde is, druk dan een boodschap af dat alles ok is en sluit af met exit-status 0.

### Netwerktester

Schrijf een script `network-tester.sh` dat controleert of de netwerkverbinding correct werkt. Meer bepaald test het script volgende zaken:

- Heeft de machine een IP-adres?

    - Gebruik hiervoor bv. `ip -br a`.
    - Gebruik filters om in de uitvoer enkel IPv4-adressen verschillend van 127.0.0.1 te behouden
    - Is het resultaat leeg? Druk dan een gepaste foutboodschap af en ga verder met de volgende test.
    - Als het resultaat niet leeg is, druk dan het IP-adres (of adressen) af en ga verder met de volgende test.

- Is er een default gateway ingesteld?

    - Gebruik hiervoor bv. `ip r` en filters enkel het IP-adres van de default gateway te behouden
    - Is er geen default gateway? Druk een gepaste foutboodschap af en ga verder met de volgende test.
    - Als er een default gateway is, druk dan het IP-adres van de gateway af en ga verder met de volgende test.

- Werkt routering naar het internet?

    - Gebruik hiervoor bv. `ping` om een publieke server zoals 1.1.1.1 te pingen. De uitvoer van het commando mag niet op het scherm komen.
    - Druk afhankelijk van het resultaat een gepaste boodschap af en ga verder met de volgende test.

- Werkt DNS?

    - Gebruik hiervoor bv. `getent ahosts` om het IP-adres van een publieke domeinnaam zoals icanhazip.com op te vragen
    - Druk afhankelijk van het resultaat een gepaste boodschap af en ga verder met de volgende test.

- Druk tenslotte je publieke IP-adres af door deze met `curl` te vragen aan icanhazip.com.

- De exit-status van het script is 0 als alle tests succesvol waren, en 1 als er één of meerdere tests gefaald hebben.

*Extra:* speel met de vorm van de output van het script op een manier die meerwaarde biedt aan de gebruiker. Bijvoorbeeld, je kan kleuren (zoek op hoe dit werkt! Tip: ANSI escape codes) of emoji's gebruiken om duidelijk te maken welke tests geslaagd zijn en welke niet.
