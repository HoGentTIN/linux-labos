# Hst 2. script101 - Intro scripting

## Variabelen

Zoek de inhoud op van volgende shellvariabelen en vul volgende tabel aan. Wat betekent elke variabele?

| Variabele  | Waarde | Betekenis |
| :--------- | :----- | :-------- |
| `PATH`     |        |           |
| `HISTSIZE` |        |           |
| `UID`      |        |           |
| `HOME`     |        |           |
| `HOSTNAME` |        |           |
| `LANG`     |        |           |
| `USER`     |        |           |
| `OSTYPE`   |        |           |
| `PWD`      |        |           |
| `MANPATH`  |        |           |

## Variabelen in scripts

1. Maak een script aan met de naam `hello.sh`. De eerste lijn van een script is altijd een "shebang". We gaan dat niet voor elke oefening herhalen, vanaf nu moet *elk* script een shebang hebben! De tweede lijn drukt de tekst "Hallo GEBRUIKER" af (met GEBRUIKER de login-naam van de gebruiker). Gebruik een geschikte variabele om de login-naam op te vragen. Maak het script uitvoerbaar en test het.

    De variabele met de login-naam van de gebruiker is niet gedefinieerd in het script zelf. Hoe heet dit soort variabelen?

2. Maak nu een tweede script aan met de naam `hey.sh`. Dit script drukt "Hallo" en de waarde van de variabele `${person}` af. Wat zal het resultaat zijn van dit script? M.a.w. wat drukt het script af wanneer je het uitvoert? Denk eerst na voordat je het uitprobeert!

   - `Hallo ${person}`
   - `Hallo` gevolgd door je gebruikersnaam
   - `Hallo`
   - Het script geeft een foutboodschap omdat de variabele `${person}` niet bestaat

3. Voeg meteen na de shebang een regel toe met het commando `set -o nounset` en voer het script opnieuw uit. Wat gebeurt er nu? Wat denk je dat beter is: deze regel toevoegen of niet?

4. Definieer de variabele `${person}` op de command-line (dus NIET in het script!). Druk de waarde ervan af om te verifiëren dat deze variabele bestaat. Voer vervolgens het script uit. Werkt het nu?

5. Wat moet je doen om de variabele `${person}` zichtbaar te maken binnen het script?

6. Verwijder de variabele `${person}` met `unset`. Verifieer dat deze niet meer bestaat door de waarde op te vragen. Combineer nu eens het definiëren van deze variabele en het uitvoeren van het script in één regel, met een spatie tussen beide. De opdrachtregel heeft de vorm van: `variabele=waarde ./script.sh`.

    Werkt het script? Kan je de variabele nog opvragen nadat het script afgelopen is?

## I/O Redirection en filters

1. Op een Linux-systeem van de Debian-familie kan je een lijst van geïnstalleerde software opvragen met het commando `apt list --installed`. Doe dit op jouw Linux-Mint VM. Het commando genereert heel wat output, zo veel dat je misschien zelfs niet de volledige lijst kan zien in de terminal. Zorg er voor dat je telkens een pagina te zien krijgt en dat je op spatie kan drukken voor de volgende pagina.

2. Als we verschillende dingen willen doen met de lijst van geïnstalleerde software, dan moeten we het commando telkens opnieuw uitvoeren. Dat is tijdrovend. Schrijf in plaats daarvan het resultaat van het commando weg in een bestand `packages.txt`.

3. Bij het wegschrijven naar een bestand krijg je toch nog een waarschuwing te zien. Zorg er voor dat deze niet getoond wordt.

4. Toon de eerste tien lijnen van `packages.txt` (met het geschikte commando!). De eerste lijn bevat nog geen naam van een package en hoort er dus eigenlijk niet bij. Gebruik een geschikt commando om er voor te zorgen dat die eerste lijn uit de uitvoer van `apt list` *niet* mee weggeschreven wordt naar `packages.txt`. Controleer het resultaat!

5. Gebruik een geschikt commando om te tellen hoeveel packages er momenteel geïnstalleerd zijn. Tip: elke lijn van `packages.txt` bevat de naam van een package.

6. Op elke lijn staat naast de naam van de package en de versie ook de processorarchitectuur vermeld (bv. amd64). Toon een gesorteerde lijst van alle architecturen die voorkomen in het bestand (geen dubbels afdrukken!) en ook hoe vaak elk voorkomt.

7. Zoek in `packages.txt` naar alle packages met `python` in de naam. Hoeveel zijn dit er?

8. Het commando `apt list --all-versions` toont zowel packages die geïnstalleerd zijn als beschikbare packages. Gebruik het om alle packages met `python` in de naam op te lijsten. **Let op:** het is hier niet nodig om een apart commando te gebruiken om te zoeken op naam. JE kan dit al opgeven met het commando `apt-list` zelf.

9. Het is vervelend dat in de uitvoer van dit commando lege lijnen zitten. Laat ons deze wegfilteren aan de hand van een geschikt commando. (Tip: in een lege lijn wordt het begin van de regel onmiddellijk gevolgd door het einde van een regel). Schrijf het resultaat weg naar `python-packages.txt`. Zorg ook dat de waarschuwing niet getoond wordt en dat die eerste lijn (`Listing...`) niet mee weggeschreven wordt.

10. Hoeveel packages zijn er opgesomd in `python-packages.txt`? Hoeveel daarvan hebben de vermelding "installed"?

11. Als je goed kijkt in `python-packages.txt` zal je zien dat sommige packages 2x vermeld worden (bv. `hexchat-python`) en dus dubbel geteld worden. Haal enkel de package-namen uit het bestand (zonder versienummer, enz.) en laat alle dubbels vallen. Hoeveel packages hou je dan nog over?

## Casus: gebruikersnamen en wachtwoorden genereren

Het bestand `employees.csv` bevat een lijst van werknemers in een klein IT-bedrijf met vestigingen in Vlaanderen en Tsjechië. Als systeembeheerder is het jouw taak om alle werknemers een gebruikersnaam en wachtwoord te geven op een nieuwe server.

1. Gebruik het commando `apg` (A Password Generator) om voor elke gebruiker een wachtwoord te genereren. Tel het aantal lijnen in het CSV-bestand (let op: eerste lijn is kolomhoofding) en gebruik het resultaat om er voor te zorgen dat `apg` meteen het juiste aantal wachtwoorden aanmaakt. Elk wachtwoord bestaat uit 15 lettertekens en bevat enkel hoofdletters, kleine letters en cijfers. Schrijf het resultaat weg in een bestand `passwords.txt`.

2. **Uitdaging.** De gebruikersnaam voor elke gebruiker bestaat uit de voornaam, gevolgd door de voorletters van de familienaam, allemaal in kleine letters. Bijvoorbeeld: iemand met de naam Jan De Smet zou gebruikersnaam `jands` krijgen, een Jan Desmet wordt `jand`. In de namen van de Tsjechische collega's komen diakritische tekens voor (bv. `Š`, `ř`). Dit is erg vervelend, want voor gebruikersnamen beperken we ons best tot ASCII-lettertekens. Gebruik `iconv` om deze speciale tekens zo goed mogelijk te benaderen met een ASCII-teken (bv. `Š` wordt `s`, `ř` wordt `r`). Tip: dit kan met de optie `-t`. Sla het resultaat op in een bestand `usernames.txt`

3. Voeg tenslotte beide bestanden lijn per lijn samen tot een CSV-bestand `user-pass.csv`. Op elke lijn komt dus een gebruikersnaam en een wachtwoord, gescheiden door een komma.

4. Verwerk deze commando's nu in een script. Je kan variabelen definiëren voor het input- en outputbestand. Het script voert de verschillende stappen zoals hierboven uit, en verwijdert ook de tussenresultaten (`usernames.txt` en `passwords.txt`).
