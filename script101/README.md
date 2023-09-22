# Hst 2. script101 - Intro scripting

## I/O Redirection en filters

1. Op een Linux-systeem van de Debian-familie kan je een lijst van geïnstalleerde software opvragen met het commando `apt list --installed`. Doe dit op jouw Linux-Mint VM. Het commando genereert heel wat output, zo veel dat je misschien zelfs niet de volledige lijst kan zien in de terminal. Zorg er voor dat je telkens een pagina te zien krijgt en dat je op spatie kan drukken voor de volgende pagina.

2. Als we verschillende dingen willen doen met de lijst van geïnstalleerde software, dan moeten we het commando telkens opnieuw uitvoeren. Dat is tijdrovend. Schrijf in plaats daarvan het resultaat van het commando weg in een bestand `packages.txt`.

3. Bij het wegschrijven naar een bestand krijg je toch nog een waarschuwing te zien. Zorg er voor dat deze niet getoond wordt.

4. Toon de eerste tien lijnen van `packages.txt` (met het geschikte commando!). De eerste lijn bevat nog geen naam van een package en hoort er dus eigenlijk niet bij. Gebruik een geschikt commando om er voor te zorgen dat die eerste lijn uit de uitvoer van `apt list` *niet* mee weggeschreven wordt naar `packages.txt`. Controleer het resultaat!

5. Gebruik een geschikt commando om te tellen hoeveel packages er momenteel geïnstalleerd zijn. Tip: elke lijn van `packages.txt` bevat de naam van een package.

6. Op elke lijn staat naast de naam van de package en de versie ook de processorarchitectuur vermeld (bv. amd64). Toon een gesorteerde lijst van alle architecturen die voorkomen in het bestand (geen dubbels afdrukken!) en ook hoe vaak elk voorkomt.

7. Zoek in `packages.txt` naar alle packages met `python` in de naam. Hoeveel zijn dit er?

8. Het commando `apt list --all-versions` toont zowel packages die geïnstalleerd zijn als beschikbare packages. Gebruik het om alle packages met `python` in de naam op te lijsten. **Let op:** het is hier niet nodig om een apart commando te gebruiken om te zoeken op naam. Je kan dit al opgeven met het commando `apt-list` zelf.

9. Het is vervelend dat in de uitvoer van dit commando lege lijnen zitten. Zo kunnen we het aantal niet makkelijk tellen. Laat ons deze lege regels wegfilteren aan de hand van een geschikt commando. (Tip: in een lege lijn wordt het begin van de regel onmiddellijk gevolgd door het einde van een regel). Schrijf het resultaat weg naar `python-packages.txt`. Zorg ook dat de waarschuwing niet getoond wordt en dat die eerste lijn (`Listing...`) niet mee weggeschreven wordt.

10. Hoeveel packages zijn er opgesomd in `python-packages.txt`? Hoeveel daarvan hebben de vermelding "installed"?

11. Als je goed kijkt in `python-packages.txt` zal je zien dat sommige packages 2x vermeld worden (bv. `hexchat-python`) en dus dubbel geteld worden. Haal enkel de package-namen uit het bestand (zonder versienummer, enz.) en laat alle dubbels vallen. Hoeveel packages hou je dan nog over?

## Variabelen

Zoek de inhoud op van volgende shellvariabelen en vul volgende tabel aan. Wat betekent elke variabele?

- `PATH`
- `HISTSIZE`
- `UID`
- `HOME`
- `HOSTNAME`
- `LANG`
- `USER`
- `OSTYPE`
- `PWD`

## Variabelen in scripts

1. Maak een script aan met de naam `hello.sh`. De eerste lijn van een script is altijd een "shebang". We gaan dat niet voor elke oefening herhalen, vanaf nu moet *elk* script een shebang hebben! De tweede lijn drukt de tekst "Hallo GEBRUIKER" af (met GEBRUIKER de login-naam van de gebruiker). Gebruik een geschikte variabele om de login-naam op te vragen. Maak het script uitvoerbaar en test het.

    De variabele met de login-naam van de gebruiker is niet gedefinieerd in het script zelf. Hoe heet dit soort variabelen?

2. Maak nu een tweede script aan met de naam `hey.sh`. Dit script drukt "Hallo" en de waarde van de variabele `${person}` af (merk op dat we deze met opzet nog niet initialiseren!). Wat zal het resultaat zijn van dit script? M.a.w. wat drukt het script af wanneer je het uitvoert? Denk eerst na voordat je het uitprobeert!

   - `Hallo ${person}`
   - `Hallo` gevolgd door je gebruikersnaam
   - `Hallo`
   - Het script geeft een foutboodschap omdat de variabele `${person}` niet bestaat

3. Voeg meteen na de shebang een regel toe met het commando `set -o nounset` en voer het script opnieuw uit. Wat gebeurt er nu? Wat denk je dat beter is: deze regel toevoegen of niet?

4. Definieer de variabele `${person}` op de command-line (dus NIET in het script!). Druk de waarde ervan af om te verifiëren dat deze variabele bestaat. Voer vervolgens het script uit. Werkt het nu?

5. Wat moet je doen om de variabele `${person}` zichtbaar te maken binnen het script?

6. Verwijder de variabele `${person}` met `unset`. Verifieer dat deze niet meer bestaat door de waarde op te vragen. Combineer nu eens het definiëren van deze variabele en het uitvoeren van het script in één regel, met een spatie tussen beide. De opdrachtregel heeft de vorm van: `variabele=waarde ./script.sh`.

    Werkt het script? Kan je de variabele nog opvragen nadat het script afgelopen is?

## Filters in scripts

Door filters te combineren kan je heel complexe tekstbewerkingstaken uitvoeren. In principe kan je dat meteen vanaf de command-line, maar dat vraagt veel typwerk en de kans bestaat dat je je alle opties niet meer herinnert, of dat je een typo maakt waardoor het commando faalt.

Voor dit soort taken kan je een script schrijven! Je probeert eerst de commando's uit in de terminal en als ze werken kopieer je ze naar een script-bestand.

1. Schrijf een script `list-users.sh` dat in het bestand `/etc/passwd` enkel de gebruikersnamen filtert en deze alfabetisch gesorteerd afdrukt.

2. Maak een variant `list-system-users.sh` dat enkel de "systeemgebruikers" (gesorteerd) afdrukt, d.w.z. gebruikers met een UID kleiner dan 1000.

3. Schrijf een script `topcmd.sh` dat een lijst afdrukt van de 10 commando's die je tot nu toe het vaakst gebruikt hebt

    - Start met de uitvoer van het commando `history`. Filter hieruit enkel de namen van de uitgevoerde commando's (= eerste woord van de opdrachtregel)
        - **Let op!** Als je `history` uitvoert binnen een script, dan vraagt het de historiek op *binnen de shell-omgeving van dat script*. Als je het script uitvoert met `./topcmd.sh`, zal de uitvoer altijd leeg zijn, want je zit in een nieuwe subshell. Een oplossing is om bij uitvoer van het script te forceren dat het *in de huidige shell* wordt uitgevoerd en dus geen subshell opent. Dat kan met het commando `source` (dus: `source topcmd.sh`) of de korte notatie `. topcmd.sh` (punt, spatie, scriptnaam).
    - Tel het aantal keer dat elk commando gebruikt is (bv. met uniq)
    - Sorteer de lijst op het aantal keer dat elk commando gebruikt werd, in dalende volgorde
    - Hou enkel de tien meest gebruikte commando's over
    - Tip: Je kan een [alias](https://tldp.org/LDP/abs/html/aliases.html) maken voor de commando's die je het meest gebruikt zodat je in de toekomst minder tikwerk hebt! bv. `alias s="git status"`

    Op een Linux-systeem van de Debian-familie kan je alle nuttige alias-definities bijhouden in een bestand `~/.bash_aliases`. Deze worden geladen telkens je een terminal opent.

## Uitdaging: gebruikersnamen en wachtwoorden genereren

Het bestand `employees.csv` bevat een lijst van werknemers in een klein IT-bedrijf met vestigingen in Vlaanderen en Tsjechië. Als systeembeheerder is het jouw taak om alle werknemers een gebruikersnaam en wachtwoord te geven op een nieuwe server.

Als een goede systeembeheerder is je instinct natuurlijk om dit proces [te automatiseren](https://xkcd.com/1319/).

1. Gebruik het commando `apg` (A Password Generator) om voor elke gebruiker een wachtwoord te genereren. Tel het aantal lijnen in het CSV-bestand (let op: eerste lijn is kolomhoofding) en gebruik het resultaat om er voor te zorgen dat `apg` meteen het juiste aantal wachtwoorden aanmaakt. Elk wachtwoord bestaat uit 15 lettertekens en bevat enkel hoofdletters, kleine letters en cijfers. Schrijf het resultaat weg in een bestand `passwords.txt`.

2. Gebruik filtercommando's om een gebruikersnaam te genereren voor elk peroneelslid. Deze bestaat uit de voornaam, gevolgd door de voorletters van de familienaam, allemaal in kleine letters. Bijvoorbeeld: iemand met de naam Jan De Smet zou gebruikersnaam `jands` krijgen, een Jan Desmet wordt `jand`. In de namen van de Tsjechische collega's komen diakritische tekens voor (bv. `Š`, `ř`). Dit is erg vervelend, want voor gebruikersnamen beperken we ons best tot ASCII-lettertekens. Gebruik `iconv` om deze speciale tekens zo goed mogelijk te benaderen met een ASCII-teken (bv. `Š` wordt `s`, `ř` wordt `r`). Tip: dit kan met de optie `-t`. Sla het resultaat op in een bestand `usernames.txt`

3. Voeg tenslotte beide bestanden lijn per lijn samen tot een CSV-bestand `user-pass.csv`. Op elke lijn komt dus een gebruikersnaam en een wachtwoord, gescheiden door een komma.

4. Verwerk deze commando's nu in een script `user-pass.sh`.

    Gebruik het commando van daarnet dat een foutboodschap afdrukt bij het opvragen van onbestaande variabelen. Voeg ook nog de regel `set -o errexit` toe, die er voor zorgt dat een script altijd meteen stopt wanneer een commando faalt i.p.v. verder te gaan met uitvoeren.

    Definieer variabelen voor het input- (`employees.csv`), outputbestand (`user-pass.txt`) en de tijdelijke tussenresultaten (`usernames.txt` en `passwords.txt`).

    Maak ook een variabele `num_employees` voor het aantal personeelsleden. Je kan de variabele initialiseren met het aantal dat je eerder al geteld hebt. Je kan ook in het script zelf dat aantal bepalen aan de hand van het daarvoor geschikte commando en het resultaat in de variabele steken. Daavoor gebruik je *command substitution*:

    ```bash
    variable=$(command)
    ```

    Merk op dat hier haakjes gebruikt worden ipv accolades. Al wat het commando afdrukt op `stdout` wordt als string in de variabele gestopt.

    Het script voert de verschillende stappen zoals hierboven opgesomd uit, en verwijdert ook de tussenresultaten.
