# Labo's Linux

Deze repository hoort bij de cursussen Linux ("OpsLinux") en Linux for Data Scientists ("DataLinux") in de professionele bacheloropleiding toegepaste informatica aan HOGENT. In deze repository vind je al het nodige om te kunnen werken aan de labo's rond scripting en automatisering.

In deze cursussen zal je een Linux-VM moeten aanmaken om je vaardigheden in te oefenen. Om efficiënt te kunnen werken aan deze labo-taken, is het nuttig om deze Github-repository te klonen binnen deze Linux-VM (voor de scripting-opgaven). Let er op dat je wijzigingen altijd gesynchroniseerd houd met `git push` en `git pull --rebase`.

Hier vind je nog meer aanwijzingen ivm het gebruik van Git: [git-instructies.md](git-instructies.md).

⚠️⚠️⚠️ **LET OP!** Repositories van studenten(groepen) kunnen worden opgeruimd voor het begin van het volgende academiejaar. **Zorg dus tijdig voor een backup!**

## Labo-oefeningen

- [script101](script101/README.md) - intro scripting
- [script102](script102/README.md) - basis scripting
- [script103](script103/README.md) - systeembeheertaken automatiseren
- [script201](script201/README.md) - geavanceerde scripting
- [automatisering](automation/README.md) - reproduceerbare virtuele omgeving voor het opzetten en configureren van Linux-VMs (**Enkel OpsLinux**)
    - Voor deze opdracht moet je de repository ook eens klonen op je fysiekle systeem.
- [troubleshooting](troubleshooting/README.md) - demo-omgeving voor de les over troubleshooting (**Enkel OpsLinux**)
- [docker](dockerlab/assignment-containers.md) (**Enkel DataLinux**)
- data-workflow (**Enkel DataLinux** - opdracht gepubliceerd op Chamilo)

## Labo-verslagen bijhouden

Maak in je repository zelf nieuwe Markdown-bestanden aan om je oplossingen bij te houden.

- Tip: gebruik "[fenced code blocks](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks)" om codefragmenten op te maken met syntaxkleuren. Geef "language identifier" `bash` op voor (delen van) scripts en `console` voor interacties op de terminal.
- VS Code heeft features en plugins die het bewerken van Markdown vereenvoudigen:
    - `Ctrl+Shift+V` of `Ctrl+K V`: "preview" van de opgemaakte tekst, zoals die er op Github zou uitzien.
    - `Alt+Shift+F` (Windows) of `Ctrl+Shift+I` (Linux): document formatteren (bv. tabellen mooi uitlijnen).
    - Markdown All in One (You Zhang): plugin met uitgebreide ondersteuning voor Markdown.
    - markdownlint (David Anson): plugin die zorgt voor een consistente "codeerstijl" in Markdown-documenten.
