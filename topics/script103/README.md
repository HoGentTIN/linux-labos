# Labo Scripting 103

In dit labo gaan we oefenen met positionele parameters en lussen in Bash scripts.

## params.sh

Schrijf een script `params.sh` dat volgende zaken afdrukt (zie voorbeeld hieronder):

- De naam van het script
- Het aantal argumenten
- Het eerste, derde en tiende argument (of niets als deze niet opgegeven zijn)
- Als er meer dan drie positionele parameters opgegeven werden, gebruik dan `shift` om alle waarden drie plaatsen op te schuiven
- Geef opnieuw het aantal (overblijvende) argumenten
- En druk ze allemaal ineens af

```console
$ ./params.sh 
Script name: ./params.sh
num params:  0
Param 1:     
Param 3:     
Param 10:    
num params:  0
Remaining:  
$ ./params.sh een
Script name: ./params.sh
num params:  1
Param 1:     een
Param 3:     
Param 10:    
num params:  1
Remaining:   een
$ ./params.sh een twee drie vier
Script name: ./params.sh
num params:  4
Param 1:     een
Param 3:     drie
Param 10:    
num params:  1
Remaining:   vier
$ ./params.sh een twee drie vier vijf zes zeven acht negen tien elf
Script name: ./params.sh
num params:  11
Param 1:     een
Param 3:     drie
Param 10:    tien
num params:  8
Remaining:   vier vijf zes zeven acht negen tien elf
```

## all-params.sh

Schrijf een script `all-params.sh` dat elke positionele parameter op een aparte lijn afdrukt. Gebruik hiervoor een for-lus. Als de gebruiker geen argumenten opgegeven heeft, drukt het script een foutboodschap af (zie voorbeeld hieronder) en sluit het script af met foutcode (exit-status verschillend van 0).

```console
$ ./all-params.sh
Geen argumenten opgegeven!
$ echo $?
1
$ ./all-params.sh dit is een test
dit
is
een
test
$ echo $?
0
$ ./all-params.sh dit is "een test"
dit
is
een test
```

## sort-passwd.sh

Schrijf een script `sort-passwd.sh` dat het password-bestand afdrukt in tabelvorm (gebruik hiervoor het commando `column -t`)

  - Als de gebruiker als argument een cijfer van 1 t/m 7 opgeeft, dan wordt de uitvoer gesorteerd volgens dat veld (bv. 1 = username, 3 = UID, 4 = GID, enz.)
  - Als er geen argument opgegeven is, wordt "1" verondersteld. Eventuele extra argumenten worden genegeerd.
  - Controleer of eventuele argumenten de correcte vorm hebben (cijfer tussen 1 en 7). Geef zo nodig een foutboodschap en sluit af met een foutcode
  - Optioneel: als je argument 3 of 4 opgeeft, dan zou je numeriek moeten sorteren i.p.v. alfabetisch. Pas het script aan om dit toe te laten.

      Tip: maak een variabele aan om het type van sorteren te selecteren. Als de opgegeven kolom 3 of 4 is, steek je er de optie van het commando `sort` voor numeriek sorteren in, anders de optie om alfabetisch te sorteren. Gebruik de variabele dan in het sorteercommando.

  ```console
  $ ./sort-passwd.sh 
  _apt           x  105 65534                          /nonexistent            /usr/sbin/nologin
  avahi-autoipd  x  115 124    Avahi autoip daemon,,,  /var/lib/avahi-autoipd  /usr/sbin/nologin
  avahi          x  120 129    Avahi mDNS daemon,,,    /var/run/avahi-daemon   /usr/sbin/nologin
  ...
  $ ./sort-passwd.sh 3
  root     x  0      0      root            /root          /bin/bash
  daemon   x  1      1      daemon          /usr/sbin      /usr/sbin/nologin
  ...
  osboxes  x  1000   1000   osboxes.org,,,  /home/osboxes  /bin/bash
  nobody   x  65534  65534  nobody          /nonexistent   /usr/sbin/nologin
  $ ./sort-passwd.sh 0
  Please enter a number between 1 and 7 (included)
  $ ./sort-passwd.sh 8
  Please enter a number between 1 and 7 (included)
  $ ./sort-passwd.sh foo
  ./sort-passwd.sh: line 11: [: foo: integer expression expected
  Please enter a number between 1 and 7 (included)
  ```

## srm.sh - safe remove

Schrijf een script `srm.sh` dat bestanden op een "veilige" manier verwijdert.

- Als argument neemt het script één of meer bestandsnamen. Als je geen argumenten opgegeven hebt, drukt het script een foutboodschap af en sluit af.

- In plaats van een bestand echt te verwijderen, wordt het gecomprimeerd met gzip en naar een directory `~/.trash` verplaatst. Als deze directory nog niet bestaat, maak die dan aan en laat het weten aan de gebruiker. Als je bestanden verplaatst, gebruik dan de `verbose` optie, zodat de gebruiker weet wat er gebeurt met de bestanden.

- Het script werkt enkel op gewone bestanden, niet op directories, links of andere soorten bestanden! Controleer dit en geef zo nodig een gepaste foutboodschap. Het script gaat daarna verder met de volgende bestanden.

- Het script moet uiteraard ook werken op bestanden met een spatie in de naam!

- **Uitbreiding:** Telkens je het script oproept, controleert het de inhoud van de trash-folder. Alle bestanden die ouder zijn dan 2 weken worden definitief verwijderd. Je geeft de gebruiker een melding van de verwijderde bestanden (gebruik gewoon de `verbose` optie in het commando om bestanden te verwijderen).

Tip: Maak enkele bestanden aan om het script te testen, bv.

```console
$ echo "Dit is een test" > file1.txt
$ echo "Dit is een test" > 'file 2.txt'
$ echo "Dit is een test" > file3.txt
$ mkdir dir1 dir2
$ ln -s file1.txt link1.txt
$ ls -l
total 21k
drwxr-xr-x. 1 bert bert   0 2022-09-13 12:39  dir1
drwxr-xr-x. 1 bert bert   0 2022-09-13 12:39  dir2
-rw-r--r--. 1 bert bert  16 2022-09-13 12:35  file1.txt
-rw-r--r--. 1 bert bert  16 2022-09-13 12:36 'file 2.txt'
-rw-r--r--. 1 bert bert  16 2022-09-13 12:36  file3.txt
lrwxrwxrwx. 1 bert bert   9 2022-09-13 12:39  link1.txt -> file1.txt
-rwxr-xr-x. 1 bert bert 792 2022-09-13 12:38  srm.sh
```

Voorbeelden van gebruik van het script (zonder uitbreiding)

```console
$ ./srm.sh
Expected at least one argument!
$ ./srm.sh file1.txt 
Created trash folder /home/bert/.trash
renamed 'file1.txt.gz' -> '/home/bert/.trash/file1.txt.gz'
$ ./srm.sh *.txt 
renamed 'file 2.txt.gz' -> '/home/bert/.trash/file 2.txt.gz'
renamed 'file3.txt.gz' -> '/home/bert/.trash/file3.txt.gz'
link1.txt is not a file! Skipping...
$ ./srm.sh dir*
dir1 is not a file! Skipping...
dir2 is not a file! Skipping...
```

Voorbeeld met opruimen van oude bestanden:

```console
$ ./srm.sh *.txt
Cleaning up old files
removed '/home/osboxes/.trash/oldfile.txt.gz'
renamed 'file1.txt.gz' -> '/home/bert/.trash/file1.txt.gz'
renamed 'file 2.txt.gz' -> '/home/bert/.trash/file 2.txt.gz'
renamed 'file3.txt.gz' -> '/home/bert/.trash/file3.txt.gz'
link1.txt is not a file! Skipping...
```

Tip: om dit te testen kan je een oud bestand simuleren met het commando `touch`:

```console
$ touch -t 200001010000 oldfile.txt.gz
```

Dit commando zet de datum van het bestand op 1 januari 2000, middernacht (formaat JJJJMMDDuumm)
