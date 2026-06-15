# Labo Advanced Text Processing

## Pattern Matching

Voor de volgende oefeningen **moet** je *globbing* gebruiken. Elke poging om reguliere expressies te gebruiken (zoals pipen naar grep) is verboden!

Creëer in de directory `linux/` een aantal lege bestanden met de naam `file`, `filea` t/m `filed`, `file1` t/m `file9` en `file10` t/m `file19`.

Hieronder is een trucje om dat snel te doen. Het concept dat we hier toepassen heet *Brace expansion*. Zoek op in de man-page van Bash hoe dit precies werkt! Tip: in de man-page, druk op de `/` toets om te zoeken en tik in "Brace Expansion" gevolgd door Enter.

```console
student@debian:~/linux$ touch file{,a,b,c,d}
student@debian:~/linux$ for i in {1..19}; do touch "file${i}"; done
student@debian:~/linux$ ls
student@debian:~/linux$ ls
file    file11  file14  file17  file2  file5  file8  fileb
file1   file12  file15  file18  file3  file6  file9  filec
file10  file13  file16  file19  file4  file7  filea  filed
```

Toon met `ls` telkens enkel de gevraagde bestanden, niet meer en niet minder.

- Alle bestanden die beginnen met `file`
- Alle bestanden die beginnen met `file`, gevolgd door één letterteken (cijfer of letter)
- Alle bestanden die beginnen met `file`, gevolgd door één letter, maar geen cijfer
- Alle bestanden die beginnen met `file`, gevolgd door één cijfer, maar geen letter
- De bestanden `file12` t/m `file16`
- Bestanden die beginnen met `file`, niet gevolgd door een 1

## AWK

Sommige van deze opgaven kan je op de command-line uitvoeren met een one-liner. Wanneer de opgave complexer wordt, kan je ook een script schrijven.

1. De pipeline hieronder is representatief voor vele codevoorbeelden die je online kan vinden. In dit geval worden uit `/etc/passwd` alle gebruikers afgedrukt die Bash als login-shell hebben. Maar eigenlijk zijn de pipes overbodig! Aangezien we toch `awk` gebruiken in deze pipeline, kunnen we de opdrachtregel herschrijven zodat enkel `awk` overblijft en er geen I/O redirection meer plaatsvindt.

    ```bash
    cat /etc/passwd | grep 'bash$' | awk -F: '{print $1}'
    ```

2. Gebruik `curl` om de het volgende CSV-bestand te downloaden en lokaal op te slaan: <https://raw.githubusercontent.com/HoGentTIN/dsai-en-labs/main/data/rlanders.csv>. Het bestand bevat random gegenereerde data en heeft volgende kolommen:

   - ID: int, nummer van de observatie
   - Gender: string, Male/Female
   - Money: int, >0
   - Days: int, >0
   - Months: int, >0
   - Count: int, >0
   - Survey: int, 1 t/m 5

3. Gebruik AWK (dus niet head of tail) om enkel de data in het csv-bestand af te drukken zonder de header (= eerste regel).

4. Bereken minimum (= 4) en maximum (= 20) van de op twee na laatste kolom (= *Months*).

5. Bereken de som van de kolom *Count* (= 12656). Doe vervolgens hetzelfde, maar enkel voor de rijen met "Female" (= 2475).

6. Kolom *Survey* bevat waarden op een Likert-schaal (1-5). Tel hoeveel elke waarde voorkomt. Het resultaat ziet er zo uit:

    ```text
    1       4
    2       62
    3       114
    4       65
    5       5
    ```

7. Bereken het gemiddelde van de kolom *Money* (= 500.156).

8. Bereken nu het gemiddelde van *Money*, maar opgesplitst volgens *Gender*. De uitvoer ziet er uit zoals hieronder.

    *Opm.* Vermijd het gebruik van de hard-coded waarden "Male" en "Female" in je script!

    ```text
    Female: 472.057692
    Male: 507.535354
    ```

9. Schrijf een AWK-script dat de gemiddelden van kolommen 3 t/m 7 berekent.

## jq


1. Gebruik curl om via <https://data.stad.gent/> de actuele bezetting van de Gentse parkeergarages in JSON-formaat op te vragen en op te slaan in een bestand (bv. `parkings.json`).

2. Gebruik `jq` eerst als "pretty printer" om de structuur van de JSON-data te bestuderen.

3. Haal de namen van de verschillende parkeergarages op.

    1. Zorg er voor dat het resultaat niet als een lijst van JSON-strings getoond wordt, we willen enkel de namen. Tip: je kan jq met een specifieke optie oproepen om dit resultaat te bekomen.
    2. Druk het resultaat nu af als een geldige JSON-array

4. We hebben voor elke parking de hieronder opgesomde gegevens nodig. Schrijf het resultaat als een JSON-array van dictionaries. Behoud de oorspronkelijke namen van de "keys", of kies zelf geschikte namen.

    - Naam van de parking
    - Timestamp van de laatste wijziging van de capaciteit
    - Beschikbare capaciteit
    - Totale (theoretische) capaciteit

5. Pas het vorige commando aan zodat de uitvoer in CSV-formaat afgedrukt wordt. De keys worden dan de kolomnamen, bv:

    ```csv
    "name","lastUpdate","available","total"
    "B-Park Dampoort","2022-10-20T19:46:01+02:00",129,120
    "B-Park Gent Sint-Pieters","2022-10-20T19:52:40+02:00",953,1000
    "Getouw","2022-10-20T19:55:53+02:00",307,340
    "Ledeberg","2022-10-20T19:55:53+02:00",424,500
    "Savaanstraat","2022-10-20T19:55:53+02:00",373,530
    "Tolhuis","2022-10-20T19:55:53+02:00",83,150
    "Dok noord","2022-10-20T18:54:23+02:00",258,550
    "Ramen","2022-10-20T19:55:53+02:00",64,250
    "Reep","2022-10-20T19:55:53+02:00",91,439
    "Sint-Pietersplein","2022-10-20T19:55:53+02:00",146,698
    ```
