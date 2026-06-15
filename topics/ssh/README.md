# Labo SSH

Voor deze labo-opdracht zal je een account krijgen op een Linux-server onder beheer van een van de lesgevers. Je gebruikersnaam is je HOGENT-loginnaam (bv. 972018tg) en je wachtwoord je studentennummer zoals vermeld op je studentenkaart (bv. 201912345). Wanneer je verschillende keren na elkaar een mislukte inlogpoging doet, zal jou tijdelijk de toegang ontzegd worden.

Deze accounts kunnen pas aangemaakt worden als je correct bent ingeschreven voor deze cursus! Als dit bij het begin van het semester nog niet het geval is, zal je dus nog even moeten wachten...

**LET OP! Deze accounts blijven niet eeuwig bestaan.** Voer het labo tijdig uit, of je zal geen toegang meer hebben. Eens je account verwijderd is, heeft het geen zin om nog verlenging te vragen. Zet in dat geval zelf twee virtuele machines op waarop OpenSSH-server geïnstalleerd is.

## Werken met SSH en ssh-agent

In deze labo-oefeningen gaan we dieper in op key-based authentication (wat veiliger is dan password based login). De oefening wordt uitgevoerd op de Linux VM enerzijds (genaamd **M**), en op de twee servers waar je een account voor gekregen hebt (genaamd **S1**, IP-adres 157.193.215.170, en **S2**, IP-adres 157.193.215.172).

De letter vooraan elke stap in de opdracht omschrijft wat je waar moet uitvoeren.

Als er gevraagd wordt welk wachtwoord gebruikt wordt, kan het antwoord ook zijn 'geen wachtwoord'.

1. **M** Normaal heb je al een SSH-sleutelpaar aangemaakt om je Git-repo voor de labo-opdrachten te kunnen synchroniseren met Github: `id_ed25519` en `id_ed25519.pub` in de directory `~/.ssh/`. Voer het commando `ssh-keygen -lf ~/.ssh/id_ed25519.pub` uit. Dit commando toont je een "fingerprint" van je publieke sleutel.

2. **M** Vraag de bestandspermissies op van de bestanden in de directory `~/.ssh/` en van de directory zelf. Merk in het bijzonder het verschil op tussen de permissies van de private sleutel en de publieke sleutel. Waarom is dit verschil belangrijk? Welke permissies zijn correct voor deze bestanden en voor de .ssh-directory?

3. **M** Maak een nieuw RSA sleutelpaar aan met `ssh-keygen`. Kies een wachtwoord (passphrase) om de private sleutel geëncrypteerd op te slaan. Overschrijf je bestaande sleutel niet! Anders verlies je de toegang tot je Github-account. Sla de nieuwe sleutel op in de `.ssh`-directory, en kies een andere naam (bv. `id_ed25519_lab`).

4. **M** Controleer of je kan inloggen op **S1**: `ssh USER@157.193.215.170` (met USER je gebruikersnaam op dat systeem). Controleer dat de fingerprint van de server overeenkomt met `SHA256:BOynDiyHnBBHNhhmxZR0x3MkZCT21+HtUief94gP0tU`.

5. **M** We kennen **S1** enkel via het IP-adres, er is geen DNS-naam voor deze server. We kunnen dit "probleem" omzeilen via de SSH client-configuratie. Maak een bestand `.ssh/config` aan en geef het volgende inhoud (met USER jouw gebruikersnaam):

    ```apache
    Host S1
        HostName 157.193.215.170
        User USER
    ```

    Log nu in met `ssh S1`.

6. **M** Kopieer de publieke sleutel die je in stap 1 hebt aangemaakt naar **S1**. Dat kan met het commando `scp KEYFILE USER@157.193.215.170:~/`. (Merk op dat voor deze stap er ook een specifiek commando bestaat: `ssh-copy-id`. Wij voeren het proces hier manueel uit zodat je beter begrijpt hoe SSH werkt)

7. Log in op **S1** (welk wachtwoord moet je nu gebruiken?) en controleer dat de sleutel zich in je home-directory bevindt. Maak in `~/.ssh/` een bestand aan met de naam `authorized_keys` en voeg de inhoud van het publieke sleutelbestand toe aan `authorized_keys`. Log uit.

8. **M** Log opnieuw in op `S1`. Je zou een pup-up moeten krijgen. Welk wachtwoord moet je hier invullen?

9. **S1** Controleer of je kan inloggen op **S2** (met welk wachtwoord?): `ssh USER@157.193.215.172`. Kopieer het bestand `authorized_keys` van **S1** naar **S2** en zorg dat het terecht komt in de juiste directory. Als je de directory nog moet aanmaken, let dan op de permissies! Welke moeten dit zijn? Je kan ook op **S1** een SSH-configuratiebestand aanmaken om het inloggen op **S2** te vereenvoudigen.

10. Log uit tot je je terug op **M** bevindt. Voeg je private sleutel toe aan een SSH-agent met `ssh-add KEYFILE`. Je kan een lijst opvragen van geregistreerde sleutels met `ssh-add -L`. Log in op **S1**. Welk wachtwoord moet je ingeven?

11. **S1** Log verder in op **S2**. Welk wachtwoord moet je ingeven? Log uit tot je terug op **M** zit

12. **M** Gebruik nu bij het inloggen op **S1** de optie `-A` (agent forwarding) of voeg de lijn `ForwardAgent yes` toe aan je SSH config. Welk wachtwoord moet je gebruiken? Toon de actieve sleutels in de SSH Agent. Log verder in op **S2** (zonder `-A`). Welk wachtwoord moet je nu gebruiken? Toon de actieve sleutels in de SSH Agent. Kan je dit verklaren?

## SSH en Git

Heb je al een SSH-sleutelpaar aangemaakt om je Git-repo voor de labo-opdrachten te kunnen synchroniseren met Github? Zo nee, dan verwijzen we opnieuw naar [de instructies](../../info/git-instructies.md).

Controleer of je publieke sleutel correct werkt met het commando `ssh -T git@github.com`.

Als je sleutel correct werkt, zou je een bericht zoals dit moeten krijgen:

```console
student@linux$ ssh -T git@github.com
Hi USER! You've successfully authenticated, but GitHub does not provide shell access.
```

Als je deze foutmelding krijgt:

```console
student@linux$ ssh -T git@github.com
git@github.com: Permission denied (publickey).
```

Dan heb je je publieke sleutel niet correct toegevoegd aan je Github-account. Controleer dat je de juiste publieke sleutel hebt toegevoegd (de *volledige* inhoud van het .pub-bestand, incl. emailadres of gebruikersnaam achteraan), dat je private sleutel correct is opgeslagen in `~/.ssh/` en dat de permissies correct zijn ingesteld.
