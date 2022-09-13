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

