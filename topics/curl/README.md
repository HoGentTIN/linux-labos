# Labo curl

Curl laat je toe om vanop de command line een web- of fileserver aan te spreken.

1. Gebruik curl om je publieke IP-adres op te vragen bij `icanhazip.com`

2. Gebruik curl om de url <https://theuselessweb.site/hmpg/> op te halen.

    1. Laat eerst afdrukken op de terminal - wat zie je?
    2. Sla de pagina op in een bestand
    3. Open het gedowloade bestand in een webbrowser. Vergelijk met het origineel. Lukt dit zoals je zou verwachten?
    4. Dowload de pagina opnieuw. Wordt het reeds bestaande bestand overschreven of niet? Gedraagt curl zich hier anders dan het gelijkaardige commando wget?

3. Wat gebeurt er als je https:// in de vorige URL weglaat?

   1. Wat zie je nu als je het resultaat op de terminal laat afdrukken?
   2. Zoek de optie om de HTTP headers te tonen en zoek in de uitvoer naar de status van het resultaat van de query. Welke statuscode krijg je hier? Welke krijg je met de https-URL?
   3. Kan je er voor zorgen dat curl zo'n redirect automatisch volgt?

4. Met curl kan je ook met een FTP-server interageren. Tegenwoordig wordt dat minder gedaan, maar soms komt dit wel nog van pas.

    1. Ga naar <http://ftp.belnet.be/debian/> en bekijk het bestand README.
    2. Gebruik nu curl om dit README-bestand te downloaden via FTP (dus NIET via http(s)!).
    3. Probeer hetzelfde, maar nu geef je een gebruikersnaam op (anonymous) en een leeg wachtwoord (of willekeurig woord).

        In dit geval zal dit hetzelfde resultaat geven als zonder gebruikersnaam/wachtwoord, maar we willen hier de mogelijkheid laten zien van het opgeven van gebruikersnaam en wachtwoord.

5. Curl is ook bij uitstek nuttig om met REST-API's te communiceren

    1. Haal de URL <https://en.wikipedia.org/api/rest_v1/page/random/summary> op, volg eventuele redirects. Wat is het verschil van de uitvoer met een "gewone" webpagina?
    2. Je kan de uitvoer beter leesbaar maken door te "pipen" naar `jq`.
    3. Als je de uitvoer van curl omleidt, dan wordt er een progress bar getoond. Zoek de optie om deze te verbergen

6. Gebruik `curl` om via het Open Data Portaal van Stad Gent het real-time aantal vrije plaatsen in de openbare Gentse fietsenstallingen op te halen.

    1. Als je de evolutie van het aantal vrije plaatsen in de tijd zou willen bijhouden, dan herhaal je deze query op geregelde tijdstippen (later zien we hoe je dat doet). Zorg er voor dat het resultaat opgeslagen wordt in een bestand met een "timestamp" in de naam, bv: `fietsenstallingen-JJJJMMDD-uummss.json`. Tip: gebruik het commando `date` en command substitution.

        **LET OP!** Als een URL het symbool & bevat (of andere speciale tekens die voor Bash een speciale waarde kunnen hebben), dan moet je aanhalingstekens rond de URL zetten!

7. Maak deze [21 oefeningen op curl](https://jvns.ca/blog/2019/08/27/curl-exercises/) (opgesteld door [Julia Evans](https://jvns.ca/)) om te oefenen op de verschillende soorten requests die je met curl kan uitvoeren, hoe je data kan meesturen, headers instellen, enz.

    **Let op:** deze oefeningen maken gebruik van <https://httpbin.org/> een website die specifiek is opgezet om te experimenteren met het gedrag van REST-API's. Deze site is tegenwoordig heel vaak onbeschikbaar ("503 temporarily unavailable"). Je kan in plaats daarvan gebruik maken van een andere API, bijvoorbeeld <https://httpbun.com/> (met endpoint `anything` ipv `anything`) of <https://postman-echo.com/>.
