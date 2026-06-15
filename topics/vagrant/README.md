# Linux: labo automatisering

De bedoeling van deze labo-opgave is om een reproduceerbare omgeving met verschillende virtuele machines op te zetten.

We gebruiken daarbij [Vagrant](https://www.vagrantup.com/), een command-line applicatie waarmee je VirtualBox-VMs kan aanmaken met specifieke instellingen (Linux distro, IP-adres, software-installatie, ...).

## Aan de slag

Zorg eerst dat je Vagrant en VirtualBox geïnstalleerd hebt. Maak een lokale kopie van deze Github-repository en open een console in deze directory. Je moet je in elk geval in de directory bevinden met het bestand `Vagrantfile`.

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

Start de VM met de naam "db" op zoals hieronder getoond. Merk op dat dit even kan duren. De eerste keer dat je dit doet wordt er een zgn. "base box" gedownload, een minimale installatie van AlmaLinux 9 die voor elke nieuwe VM zal hergebruikt worden.

```console
> vagrant up db
Bringing machine 'db' up with 'virtualbox' provider...
==> db: Importing base box 'bento/almalinux-9'...
...
    db: [LOG]  Securing the database
    db: [LOG]  Creating database and user
    db: [LOG]  Creating database table and add some data
```

Op deze "db"-VM is ook al MariaDB geïnstalleerd met een databank-tabel met wat demo-data. Dit gebeurt via het script [provisioning/db.sh](provisioning/db.sh). Je kan in het script de nodige namen en wachtwoorden van de database-gebruikers terugvinden.

Merk op dat je, om Vagrant te gebruiken, de VirtualBox GUI niet meer nodig hebt! Je kan inloggen op de VM met:

```console
> vagrant ssh db

This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Activate the web console with: systemctl enable --now cockpit.socket

[vagrant@db ~]$ 
```

Je bent ingelogd als gebruiker `vagrant` met wachtwoord `vagrant` (dat je echter bijna nooit nodig zal hebben). Deze gebruiker heeft `sudo`-rechten. De `root`-gebruiker heeft ook wachtwoord `vagrant`.

Nog enkele nuttige commando's:

- `vagrant halt VM` - sluit de gespecifieerde VM af
- `vagrant reload VM` - de gespecifieerde VM rebooten
- `vagrant destroy VM` - de gespecifieerde VM vernietigen
- `vagrant provision VM` - voer het installatiescript van de VM (die opgestart moet zijn) uit. Je vindt dit script in de directory `provisioning`, en het heeft dezelfde naam als de VM (bv. `db.sh` voor de "db"-VM). Als je een VM toevoegt, moet je ook een nieuw provisioning-script voorzien. Een provisioning-script wordt uitgevoerd als root, dus het is niet nodig bij elk commando `sudo` te gebruiken.

## Opdracht

Als je de "web"-VM opstart zal je merken dat deze VM nog grotendeels "leeg" is. Zorg er voor dat dit een volwaardige webserver wordt. Dit proces moet volledig geautomatiseerd gebeuren. Je vult de nodige stappen aan in het script [provisioning/web.sh](provisioning/web.sh).

- Installeer Apache (met ondersteuning voor HTTPS)
- Configureer de firewall
- Configureer SELinux waar nodig
- Installeer een demo PHP-pagina die een query uitvoert op de database en het resultaat toont op de webpagina

## Enkele aanwijzingen

- Het provisioning-script moet volledig automatisch lopen en mag geen invoer van de gebruiker vragen. Gebeurt dit toch, dan zal het meteen stoppen.
- De inhoud van deze Git-repository wordt binnen de VM gemount onder de directory `/vagrant`. Je kan hier gebruik van maken om bestanden te kopiëren naar de VM.
- Werk in kleine stappen! Maak een kleine wijziging aan het script en voer het uit met `vagrant provision VM`. Controleer of dit het gewenste resultaat heeft. In een aparte terminal kan je inloggen op de VM en een en ander uitproberen.
- Probeer regelmatig in de webbrowser van je Linux-Mint VM of de website daar kan getoond worden.
- Als je denkt dat je klaar bent, doe je `vagrant destroy web` en `vagrant up web`. Je webserver zou in één keer moeten geïnstalleerd worden met alle nodige configuratiewijzigingen. Zonder verdere manuele handelingen moet je de website zien in de Linux-Mint VM.

## Bron

Deze opstelling is gebaseerd op [vagrant-shell-skeleton](https://github.com/bertvv/vagrant-shell-skeleton/).
