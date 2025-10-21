# Hst. 4 - script102

## Positionele parameters

1. Schrijf een script `params.sh` dat volgende zaken afdrukt (zie voorbeeld hieronder):

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

2. Schrijf een script `all-params.sh` dat elke positionele parameter op een aparte lijn afdrukt. Gebruik hiervoor een for-lus. Als de gebruiker geen argumenten opgegeven heeft, drukt het script een foutboodschap af (zie voorbeeld hieronder) en sluit het script af met foutcode (exit-status verschillend van 0).

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

3. Schrijf een script `sort-passwd.sh` dat het password-bestand afdrukt in tabelvorm (gebruik hiervoor het commando `column -t`)

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

## Netwerkinstellingen opvragen

Schrijf een script `ip-info.sh` dat essentiële informatie over de IP-configuratie van het systeem geeft, meer bepaald:

- Voor elke interface (behalve de loopback) het IP-adres met bijhorend netwerkmasker in CIDR notatie
    - Tip: gebruik de `-brief` optie van het `ip`-commando
- De default gateway (en de netwerkinterface langs waar pakketten naar "buiten" gestuurd kunnen worden)
    - Tip: gebruik `ip`
- De DNS-server(s)
    - Tip: gebruik `resolvectl`

Wees creatief in de uitvoer: gebruik kleuren en/of emoji's om de informatie duidelijk te maken.

Een voorbeeld. De exacte interfaces en IP-adressen kunnen voor jouw situatie afwijken:

```console
osboxes@osboxes:~$ ./ip-info.sh 
📫 IP addresses 📫
enp0s3           UP             10.0.2.15/24 fe80::bbb0:3744:a35d:cdbc/64 
enp0s8           UP             fe80::17d1:a3a8:10f:f05/64 
enp0s9           UP             192.168.56.101/24 fe80::f4a8:eb4b:e94d:8220/64 

🌐 Default gateway 🌐
10.0.2.2 dev enp0s3

📗 DNS server(s) 📗
Global:
Link 4 (enp0s9):
Link 3 (enp0s8):
Link 2 (enp0s3): 10.0.2.3
```
