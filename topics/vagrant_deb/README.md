# Labo Vagrant (Debian VMs)

De bedoeling van deze labo-opdracht is om een reproduceerbare omgeving met verschillende virtuele machines op te zetten, meer bepaald een database- en een webserver.

We gebruiken daarbij [Vagrant](https://www.vagrantup.com/), een command-line applicatie waarmee je VirtualBox-VMs kan aanmaken met specifieke instellingen (Linux distro, IP-adres, software-installatie, ...).

Deze specifieke opstelling is gebaseerd op [vagrant-shell-skeleton](https://github.com/bertvv/vagrant-shell-skeleton/).

## Aan de slag

Zorg eerst dat je Vagrant en VirtualBox geïnstalleerd hebt. Als je dat nog niet gedaan hebt, maak een lokale kopie van deze Github-repository *op je fysieke systeem* en open een terminal in de directory met het bestand `Vagrantfile`.

We hebben al 2 VMs voorgedefinieerd:

```console
> vagrant status
Current machine states:

db                        not created (virtualbox)
web                       not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

Je kan later nog VMs toevoegen door het bestand [vagrant-hosts.yml](vagrant-hosts.yml) te bewerken.

Start de VM met de naam `db` op zoals hieronder getoond. Merk op dat dit even kan duren. De eerste keer dat je dit doet wordt er een zgn. "base box" gedownload, een minimale installatie van Debian 13 die voor elke nieuwe VM zal hergebruikt worden.

```console
> vagrant up db
Bringing machine 'db' up with 'virtualbox' provider...
==> db: Importing base box 'bento/debian-13'...
...
    db: [LOG]  Securing the database
    db: [LOG]  Creating database and user
    db: [LOG]  Creating database table and add some data
```

Op deze `db`-VM is ook al MariaDB geïnstalleerd. Dit gebeurt via het script [provisioning/db.sh](provisioning/db.sh). Dit script wordt automatisch uitgevoerd bij het creëren van de VM, maar je kan het ook manueel uitvoeren met `vagrant provision db` als de VM al opgestart is.

Dit script roept op zijn beurt het script [common.sh](provisioning/common.sh) aan, waarin enkele variabelen en functies gedefinieerd zijn en waar je algemene installatie-stappen kan plaatsen die voor alle VMs gelden.

We hebben hier onder andere enkele variabelen gedefinieerd voor de databasenaam, database-gebruiker en het wachtwoord voor de webapplicatie die we op de `web`-VM zullen installeren. Omdat ook `web.sh` dit script aanroept, moeten we deze variabelen maar één keer definiëren, en kunnen we er in beide provisioning-scripts gebruik van maken.

Merk op dat je, om Vagrant te gebruiken, de VirtualBox GUI niet meer nodig hebt! Je kan inloggen op de VM met:

```console
> vagrant ssh db

This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Activate the web console with: systemctl enable --now cockpit.socket

[vagrant@db ~]$ 
```

Je bent ingelogd als gebruiker `vagrant` met wachtwoord `vagrant` (dat je echter bijna nooit nodig zal hebben). Deze gebruiker heeft `sudo`-rechten zonder dat er een wachtwoord vereist is. De `root`-gebruiker heeft ook als wachtwoord `vagrant`.

Nog enkele nuttige commando's:

- `vagrant halt VM` - sluit de gespecifieerde VM af
- `vagrant reload VM` - de gespecifieerde VM rebooten
- `vagrant destroy VM` - de gespecifieerde VM vernietigen
- `vagrant provision VM` - voer het installatiescript van de VM (die opgestart moet zijn) uit. Je vindt dit script in de directory `provisioning`, en het heeft dezelfde naam als de VM (bv. `db.sh` voor de `db`-VM). Als je een VM toevoegt, moet je ook een nieuw provisioning-script voorzien. Een provisioning-script wordt uitgevoerd als root, dus het is niet nodig bij elk commando `sudo` te gebruiken.

## Opdracht

1. De database op de `db`-VM is al geïnstalleerd, maar is nog leeg. Zorg er voor dat de SQL-code uit de labo-opdracht [webserver_deb](../webserver_deb/README.md) wordt toegevoegd aan het provisioning-script van de `db`-VM, zodat de database automatisch wordt gevuld met wat demo-data. Vervang alle hard-coded waarden (zoals databasenaam, gebruikersnaam, wachtwoord) in het SQL-script door de variabelen die al gedefinieerd zijn in het provisioning-script.

2. Als je de `web`-VM opstart zal je merken dat deze VM nog grotendeels "leeg" is. Zorg er voor dat dit een volwaardige webserver wordt. Dit proces moet volledig geautomatiseerd gebeuren. Je vult de nodige stappen aan in het script [provisioning/web.sh](provisioning/web.sh).

   1. Installeer Apache met ondersteuning voor HTTPS en PHP
   2. Installeer de demo PHP-pagina uit de labo-opdracht [webserver_deb](../webserver_deb/README.md) die een query uitvoert op de database en het resultaat toont op de webpagina. Vervang daarbij ook alle hard-coded waarden door de variabelen die al gedefinieerd zijn in het provisioning-script.
   3. Test het resultaat! De website zou te zien moeten zijn in een webbrowser op je fysieke systeem op het IP-adres van de `web`-VM (zie `vagrant-hosts.yml`).

## Enkele aanwijzingen

- Het provisioning-script moet volledig automatisch lopen en mag geen invoer van de gebruiker vragen. Gebeurt dit toch, dan zal het meteen stoppen.
- De inhoud van deze Git-repository wordt binnen de VM gemount onder de directory `/vagrant`. Je kan hier gebruik van maken om bestanden te kopiëren naar de VM.
- Werk in kleine stappen! Maak een kleine wijziging aan het script en voer het uit met `vagrant provision VM`. Controleer of dit het gewenste resultaat heeft. In een aparte terminal kan je inloggen op de VM en een en ander uitproberen.
- Probeer regelmatig in de webbrowser of de website daar kan getoond worden.
- Als je denkt dat je klaar bent, doe je `vagrant destroy web` en `vagrant up web`. Je webserver zou in één keer moeten geïnstalleerd worden met alle nodige configuratiewijzigingen. Zonder verdere manuele handelingen moet je de website meteen te zien krijgen in de browser.
