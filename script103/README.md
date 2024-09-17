# Hst 6. script103

Vanaf nu begin je elk script met de volgende drie lijnen:

```bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
```

## Tests

### 1. Safe remove

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

### 2. Analyseer Github repo

Schrijf een script `analyse-github-repo.sh` waaraan je één argument meegeeft dat de naam van een directory moet zijn waarin zich een Github-repository zou moeten bevinden. Het script analyseert de repository en geeft waar nodig enkele aanbevelingen.

- Controleer het aantal argumenten, dat moet exact 1 zijn. Geef anders een foutboodschap en stop het script.

- Controleer of het argument een directory is. Geef anders een foutboodschap en stop het script.

- Controleer of de directory een Github-repository is (bevat een subdirectory `.git/`). Geef anders een foutboodschap en stop het script.

- Tel het aantal commits (bijvoorbeeld: `git log --pretty=oneline` en tel het aantal lijnen) en afhankelijk van het resultaat geef je een aanmoediging (pas de tekst gerust aan):
    - 0 commits: "Komaan, niet wachten, maak een eerste commit!"
    - 1 commit: "Alvast 1 commit, goed begonnen!"
    - 2-10 commits: "Je hebt al AANTAL commits gemaakt, doe zo verder!"
    - meer dan 10 commits: "Fantastisch werk, al AANTAL commits!"

- Controleer of er lokale wijzigingen zijn met `git status -s` (toont 1 lijn per bestand met wijzigingen). Afhankelijk van de uitvoer geef je een aanmoediging:
    - uitvoer is een lege string: "Geen lokale wijzigingen, goed bezig!"
    - uitvoer is niet leeg: "Je hebt nog lokale wijzigingen, commit ze zo snel mogelijk!"

- Controleer of er een leesbaar bestand met de naam `README.md` bestaat. Geef een aanmoediging:
    - bestand bestaat: "README.md bestaat, goed zo!"
    - bestand bestaat niet: "README.md bestaat niet, maak er één aan met wat uitleg over je project!"

- Doe hetzelfde voor een bestand `LICENSE.md` en `.gitignore`.

- Ga met een for-loop over alle bestanden in de root van je Github-directory
    - als het een directory is, druk je af "DIRECTORY wordt overgeslagen" (we gaan niet recursief in directories om te vermijden dat je `find ... -exec` moet gebruiken)
    - als het een block special of character special bestand is, druk je af "BESTAND is een speciaal bestand, hoort deze thuis in de repository?"
    - controleer het bestandstype met `file BESTAND`
    - als het bestandstype gelijk is aan "ASCII text, with CRLF line terminators", geef dan de melding "BESTAND heeft DOS regeleindes, zet om met `dos2unix`"
    - als het eerste woord van het type begint met "ELF", geef dan de melding "BESTAND is een binaire executable, hoort deze thuis in de repository?"
    - in alle andere gevallen druk je niets af en ga je gewoon verder met de volgende bestanden

- Zoek naar shellscripts in de Github-repository. Als je er vindt, controleer dan of ze uitvoerbaar zijn:
    - indien niet uitvoerbaar: "Shellscript SCRIPT is niet uitvoerbaar, maak het uitvoerbaar met `chmod +x SCRIPT`"
    - indien uitvoerbaar: "Shellscript SCRIPT is uitvoerbaar, goed zo!"

- **Uitbreiding:**
    - maak de uitvoer aantrekkelijker met ANSI-kleuren en/of emoji's of hoofdingen tussen de verschillende controles.
    - voeg zelf nuttige controles toe
