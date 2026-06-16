# Labo Automatiseren van workflows met Makefiles

In dit labo leer je hoe je Makefiles kan gebruiken om workflows te automatiseren. Makefiles worden vaak gebruikt om C-code te compileren, maar kunnen ook voor andere doeleinden gebruikt worden. In dit labo zullen we Makefiles ook gebruiken om PDF-bestanden te genereren vanuit LaTeX en om Markdown-bestanden om te zetten naar een reveal.js-presentatie.

## Hello!

Ga naar de directory `makefiles/hello/` en bestudeer de inhoud van de bestanden die je daar vindt.

1. Voer 2x na elkaar het commando `make` uit. Is het resultaat 2x hetzelfde?
2. Voer het uitvoerbare bestand uit dat het resultaat is van het `make`-proces.
3. Voer `touch hello.c` uit. Wat doet dit commando? Voer opnieuw `make` uit. Wat merk je?
4. Het zou beter zijn als de afgedrukte boodschap afgesloten wordt met een newline. Pas hello.c aan, hercompileer met `make` en probeer het opnieuw uit.
5. Voeg een nieuwe regel (*target* in Makefile-terminologie) `clean:` toe die het gecompileerde bestand verwijdert. Test uit dat deze goed werkt en compileer opnieuw.
6. Als je bash-completion geïnstalleerd hebt, probeer dan het volgende: `make <TAB><TAB>`. Je zou nu de targets moeten zien die in de Makefile gedefinieerd zijn.

## Booleans

De directory `makefiles/booleans/` bevat een simplistische implementatie van het Linux-commando `true`.

1. Compileer het commando en test het door het uit te voeren. Zorg er voor dat je zeker bent dat je onze implementatie van `true` uitvoert en niet het `true`-commando dat al op het systeem aanwezig is. Hoe doe je dit trouwens?
2. Implementeer ook `false` en pas de Makefile aan door een target toe te voegen voor `false`.
3. Declareer een variabele `targets` die een lijst bevat van de executables die moeten gecompileerd worden.
4. Voeg een target `all:` toe die zowel `true` als `false` compileert (gebruik de variabele `targets`).
5. Vervang de targets voor `true` en `false` door een pattern rule.
6. Voeg een `clean:` target toe om de gecompileerde bestanden te verwijderen.

## PDF-documenten genereren

Een Data Engineer zal Makefiles wellicht niet gebruiken om C-code mee te compileren. Behalve de vorige basisoefeningen heeft het dus weinig meerwaarde om dit onderwerp verder uit te diepen. Make kan echter voor gelijk welk build-proces gebruikt worden waarbij je een doelbestand wilt kunnen genereren uit één of meerdere bronbestanden.

In dit deel van het labo zullen we PDF-bestanden genereren vanuit LaTeX. LaTeX is een tekstzetsysteem ontwikkeld door Donald Knuth en verbeterd door Leslie Lamport, dat in de exacte wetenschappen de de-facto standaard is voor het opmaken van publicaties met een professionele vormgeving. Ook in de bedrijfswereld wordt het gebruikt wanneer er nood is aan een workflow voor het automatiseren van documentgeneratie (bv. handleidingen, rapporten, enz.) gebaseerd op tekstbestanden. Voor de bachelorproef toegepaste informatica krijg je ook een LaTeX-sjabloon aangeleverd vanuit de opleiding.

In de directory `makefiles/latex/` vind je een voorbeeldbestand `example.tex`.

1. Creëer een Makefile voor het compileren van `example.tex` naar `example.pdf`. Als je dit manueel doet, zou het commando `xelatex example`" zijn. Verwerk dit commando in het recept.

2. Maak aan het begin van de Makefile variabelen aan voor het te gebruiken LaTeX-commando en voor eventuele opties die je wil meegeven. Initialiseer deze variabelen resp. met `xelatex` en `-synctex=1 -interaction=nonstopmode -shell-escape`. Gebruik deze variabelen in het recept.

3. Zet de target voor `example.tex` om naar een pattern rule zodat de target generiek wordt en we deze op elk nieuw .tex-bestand dat in deze directory zou aangemaakt worden kunnen toepassen.

4. Maak een variabele `sources` die de functie `wildcard` gebruikt om een lijst van alle .tex-bestanden in de huidige directory te maken. Maak ook een variabele PDFs die de functie `patsubst` gebruikt om de namen van alle bestanden in `sources` om te zetten in de namen van de resulterende PDF-bestanden.

5. Voeg een target `all:` toe die de lijst van alle PDF-bestanden als bron heeft. Dit moet de eerste target worden in de Makefile. Probeer dit uit door een nieuw LaTeX-bestand aan te maken en te controleren of na make all beide pdf's gegenereerd worden.

6. LaTeX genereert een heleboel hulpbestanden. Voeg een target `clean:` toe om deze allemaal te verwijderen. Je kan op het Internet een lijst vinden van bestandsextensies.

7. Voeg ook een target `mrproper:` toe die `clean` oproept en ook de resulterende PDF's verwijdert.

8. Baseer je op [dit blog-artikel](https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html) om een help-target toe te voegen die de gebruiker toont welke targets er in de Makefile gedefinieerd zijn met wat uitleg. Zorg er voor dat als je `make` zonder argumenten ingeeft, `make help` uitgevoerd wordt. Vb:

    ```console
    $ make
    The following build targets are available:
    help          Show this help message (default)
    all           Generate all PDFs
    clean         Clean up auxilary files
    mrproper      Clean up auxilary files and PDFs
    Individual targets:
    example.pdf
    ```

9. **Optioneel**: Soms moet de LaTeX-compilatie verschillende keren achter elkaar uitgevoerd worden. Als dit nodig is, vind je in het .log-bestand de tekst "Rerun to get cross-references right". Pas het recept aan zodat het LaTeX-commando herhaald wordt zolang dit patroon voorkomt in het log-bestand (gebruik een Bash while-lus).

Als je wilt vermijden dat LaTeX-hulpbestanden in je Github-repository terechtkomen, dan kan je in het bestand ".gitignore" in de hoofddirectory de nodige globbing-patronen toevoegen. Github houdt zelf een lijst bij van .gitignore-bestanden voor allerlei doeleinden, o.a. [TeX.gitignore](https://github.com/github/gitignore/blob/main/TeX.gitignore). Je kan deze lijst toevoegen aan het reeds aanwezige .gitignore-bestand in deze repository.

## Markdown naar Reveal-js

Bij het opmaken van de slides voor deze cursus worden ook Makefiles ingezet. De broncode in Markdown wordt via Pandoc omgezet naar een [reveal.js](https://revealjs.com/)-presentatie. Probeer dat proces te reproduceren.

1. Maak onder `topics/make` een subdirectory directory `slides/topics/`. Uit de Github-repo voor de slides van deze cursus heb je de bestanden `Makefile` en `hogent.css` nodig. Download deze naar jouw directory `slides/`.

2. Maak in `slides/topics/` een Markdown-bestand aan voor een presentatie(of kopieer een van de Markdown-bestanden met de slides over jouw favoriete onderwerp uit de cursus-repo). Start het build-proces. Maak aanpassingen waar nodig om het creëren van de slides (in de vorm van een .html-bestand) te laten slagen. Bekijk het resultaat in een webbrowser.

3. Bestudeer de Makefile, probeer de verschillende doelen uit, maak aanpassingen naar je eigen voorkeur, ...

4. **Optioneel:** Voeg een regel toe die Pandoc gebruikt om een PDF te genereren uit de Markdown bronbestanden. Deze PDFs kunnen dan dienst doen als handouts.
