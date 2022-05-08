# Útočný scenár

## Príbeh:

Si penetračný tester najatý malou firmou. Ich firma má internú sieť, na ktorú sa môžeš pripojiť a skúsiť získať ich tajné dáta. Tvoj Kali stroj je už pripojený do tejto internej siete, ktorá má IP adresu **10.10.30.0/24**.

## Inštrukcie:

Prihlás sa do svojho útočného stroja s prihlasovacím menom **kali** a heslom **kali**. Riaď sa zadanými úlohami a vykonaj penetračný test databázového a webového systému. Každá úloha má svoju flag hodnotu, ktorú by si mal nájsť ak si sa riadil úlohami a vykonal potrebné inštrukcie. Vo svojom **home adresári** máš binárny súbor `flag-check`, ktorý slúži ako kontrolný nástroj flag hodnôt. Pre jeho použitie je potrebné si flag hodnoty zapísať do súboru vo formáte “**# - FLAG**”, kde # je číslo úlohy a FLAG je hodnota flagu. Následne treba tento súbor použiť ako argument binárky `flag-check`.

## Pravidlá:

-   Potrebná základná znalosť práce s príkazovým riadkom a operačným systémom Linux
    
-   Účastník cvičenia môže používať internet pre vyhľadávanie informácií
    
-   Všetky účty, služby alebo súbory, ktoré obsahujú názov “vagrant” musia byť účastníkom ignorované
    
-   Zasahovanie do systémov mimo zadania úlohy môže znemožniť správne fungovanie a preto je možné iba na vlastné riziko
    
-   Zasahovanie do pomocných nástrojov, konfigurácií ale účtov potrebných pre správne fungovanie infrastruktury cvičenia je zakázané
    
-   Hodnotenie cvičenia je možné získať z validačných binárnych súborov

## Úloha 1: Prieskum siete

### Zadanie úlohy:

Použite nástroj `nmap` na vykonanie **ping skenu siete 10.10.30.0/24**. Nájdite online stroje (iné od vášho stroja) a zapíšte si ich názvy a IP adresy. Pre každý stroj vykonajte rýchly **sken portov s detekciou verzií služieb**. Zapíšte tento výstup do súboru.

Zistili ste, že jeden stroj používa **webovú službu**. Vykonajte sken tejto webovej služby pomocou nástroja `nikto`. Z výstupu skenu sa dá identifikovať **webová aplikácia**, ktorý pravdepodobne beží na serveri. Vyskúšajte navštíviť túto webovú aplikáciu pomocou webového prehliadača.

Flag je názov (všetko malými znakmi) webovej aplikácie, ktorá je na webovom serveri.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   `man nmap`
-   Pozrite si prepínač `-sV` pri nástroji `nmap`.
-   `man nikto`
-   Výstup z nástroja `nikto` nám ukazuje zaujímavé adresáre, ktoré naznačujú prítomnosť známej webovej aplikácie.
</details>

## Úloha 2: Enumerácia

### Zadanie úlohy:

Je čas pre základné zisťovanie defaultných alebo jednoduchých prihlasovacích údajov. Môžete použiť ľubovoľný nástroj pre nájdenie prihlasovacích údajov do phpMyAdmin webovej aplikácie, alebo nasledujte toto zadanie.

Existuje mocný framework menom **Metasploit**, ktorý je používaný pri penetračnom testovaní. Spustite nástroj `msfconsole`, ktorý slúži ako rozhranie pre Metasploit a vyhľadajte “**phpmyadmin**”. Vo výsledkoch hľadania je skenovací modul s názvom **phpmyadmin_login**. Použite tento modul. Po jeho vybraní, napíšte `options` pre zobrazenie nastavení modulu.

Tu je treba nastaviť **RHOSTS** na IP adresu cieľového zariadenia, zmeniť **TARGETURI** na hodnotu, ktorú používa webový server, zvoliť slovníkový súbor prihlasovacích údajov v **USER_PASS** nastavení pre zrýchlenie hľadania a taktiež nastaviť **STOP_ON_SUCCESS** na hodnotu true, aby sa sken zastavil pri prvej nájdenej kombinácií. Slovníkový súbor s prihlasovacími údajmi, ktorý použijete je `/usr/share/wordlists/metasploit/default_userpass_for_services_unhash.txt`

Po nastavení modulu stačí napísať príkaz `run` a nechať sken prebehnúť pokým niečo nenájde.

Flag sú prihlasovacie údaje na phpMyAdmin vo formáte “**username:password**”.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Tu sú príkazy, ktoré sú potrebné pri `msfconsole`: `search`, `use`, `options`, `set`, `run`
-   Po spustení `msfconsole` a vyhľadaní “phpmyadmin” stačí napísať `use #`, kde # je číslo výsledku vyhľadávania
-   Pre nastavenie TARGETURI, spomeňte si na Úlohu 1, kde bola adresa webovej aplikácie a zadajte ju pred `/index.php`, ktoré je nastavené defaultne.
</details>

## Úloha 3: Exploit

### Zadanie úlohy:

V Úlohe 2 sme našli prihlasovacie údaje na phpMyAdmin. Prihláste sa do phpMyAdmin cez webový prehliadač pomocou nájdených prihlasovacích údajov, poobzerajte sa po hlavnej stránke a identifikujte **verziu webovej aplikácie phpMyAdmin**.

Pravdepodobne neviete ale po rýchlom vyhľadaní by ste zistili, že sa jedná o zraniteľnú verziu aplikácie. Verzia obsahuje “**local file inclusion**” zraniteľnosť, ktorá môže viesť k “**remote code execution**” zraniteľnosti.

Spustite znovu nástroj `msfconsole` a znovu vyhľadajte “**phpmyadmin**”. Vo výsledkoch hľadania je viacero “remote code execution” exploitov ale iba jeden používa “local file inclusion” a to ten z **roku 2018**. Použite ho. Pozrite si aké `options` sú k dispozícii a nastavte správne **PASSWORD, USERNAME a RHOSTS** hodnoty. Skontrolujte IP adresu v **LHOST** a uistite sa, že je to IP adresa vášho lokálneho stroja v sieti (**10.10.30.102**). Potom exploit spustite. Po chvíli (niekedy minútu alebo viac) sa otvorí **meterpreter session**.

Vyhľadajte si informácie, čo je to meterpreter session a aké príkazy tu môžete používať, ak sa chcete na stroji viac poobzerať. Hneď po vytvorení session zadajte príkaz `ls` aby ste zistili kde sa nachádzate a aké súbory tu sú. Zistíte, že ste v adresári webovej aplikácie phpMyAdmin. Nachádza sa tu jeden súbor, ktorý by mohol mať zaujímavé informácie, a to je hlavný **konfiguračný súbor phpMyAdmin**. Boli v ňom zanechané **citlivé informácie**, ktoré predstavujú bezpečnostné riziko. Nájdite ich.

Flag sú prihlasovacie údaje do MySQL vo formáte “**username:password**”.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Modul exploitu sa volá “phpmyadmin_lfi_rce”
-   Nastavte meno a heslo pomocu údajov nájdených v Úlohe 2
-   Konfiguračný súbor phpMyAdmin sa volá `config.inc.php`
-   Pozrite sa na koniec súboru
</details>    

## Úloha 4: Získanie viac informácií

### Zadanie úlohy:

Zistime aké prihlasovacie údaje sme získali. Prihláste sa s nimi do **phpMyAdmin** alebo priamo na MySQL pomocou `mysql` služby. Tento používateľ má prístup do **mysql databázy**, ktorá obsahuje dôležitú **user tabuľku**. Prezrite si ju. Tu môžeme vidieť už známe používateľské účty. Je tu však aj **ďalší účet**, ktorý by poskytol lepší prístup. Zapíšte si alebo skopírujte jeho **hashované heslo**.

Teraz môžeme začať s lámaním hesla. Môžete použiť ľubovoľný nástroj na lámanie hesla ako napríklad `john` alebo `hashcat`. Použijeme **slovníkový útok** s nasledujúcim slovníkom `/usr/share/wordlists/fastcrack.txt` , so špecifikovaním **typu hashovaného hesla**, ktoré chceme prelomiť (nástroj musí vedieť, že sa jedná o MySQL hashované heslo).

Flag je prelomené heslo.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Účet, ktorému chceme prelomiť heslo je root s hostom nastaveným na “%”
-   Pri `hashcat`, hashovací mód je 300 a hash nezačína so znakom “*”
-   Pri `john`, formát je “mysql-sha1” a hash začína so znakom “*”
</details>      

## Úloha 5: Tajné dáta

### Zadanie úlohy:

Teraz tá ľahká časť. Prihláste sa do phpMyAdmin ako **root** používateľ s heslom získaným v predchádzajúcej úlohe.

Máme plný prístup do všetkých databáz. Získajte tajné dáta firmy **gcomp**.

Flag sa nachádza v tabuľkovom zázname vo formáte “FLAG:**********”, kde ********* je tajná správa.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Stačí získať flag navigovaním do gcomp -> secret_data -> tretí záznam. Nie je to také ťažké.
</details>        
