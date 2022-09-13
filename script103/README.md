# Hst 6. script103

Vanaf nu begin je elk script met de volgende drie lijnen:

```bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
```

## Tests

1. **Safe remove.** Schrijf een script `srm.sh` dat bestanden op een "veilige" manier verwijdert.

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