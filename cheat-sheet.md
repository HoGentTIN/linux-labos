# Cheat sheet en checklists

Naam student: NAAM

Vul dit document zelf aan met commando's die je nuttig vindt, of waarvan je merkt dat je het verschillende keren moeten opzoeken hebt. Idem voor checklists voor troubleshooting, m.a.w. procedures die je kan volgen om bepaalde problemen te identificeren en op te lossen. Voeg waar je wil secties toe om de structuur van het document overzichtelijk te houden. Werk dit bij gedurende heel het semester!

Je vindt hier alvast een voorbeeldje om je op weg te zetten. Zie [https://github.com/bertvv/cheat-sheets](https://github.com/bertvv/cheat-sheets) voor een verder uitgewerkt voorbeeld.

## Commando's

| Taak                   | Commando |
| :---                   | :---     |
| IP-adress(en) opvragen | `ip a`   |

## Git workflow

Eenvoudige workflow voor een éénmansproject met synchronisatie naar een "remote repository".

| Taak                                        | Commando                  |
| :---                                        | :---                      |
| Huidige toestand project                    | `git status`              |
| Bestanden toevoegen/klaarzetten voor commit | `git add FILE...`         |
| Bestanden "committen"                       | `git commit -m 'MESSAGE'` |
| Synchroniseren naar Github                  | `git push`                |
| Wijzigingen op Github binnenhalen           | `git pull`                |

## Checklist netwerkconfiguratie

1. Is het IP-adres correct? `ip a`
2. Is de router/default gateway correct ingesteld? `ip r -n`
3. Is er een DNS-server? `cat /etc/resolv.conf`

