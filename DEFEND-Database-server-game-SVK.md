# Obranný scenár

## Príbeh:

Firma si ťa najala na nájdenie a opravu potenciálnych bezpečnostných chýb v ich databázovom a webovom systéme, ktorý sa snažil zriadiť neskúsený syn vlastníka firmy bez akejkoľvek odbornej pomoci. Ich interná sieť má zatiaľ iba webový a databázový server. Oba servery používajú Debian 10 ako operačný systém. IP adresa **webového servera je 10.10.30.71** a server používa Apache 2 službu pre webový manažment s phpMyAdmin webovou aplikáciou pre vzdialenú správu databáz. IP adresa **databázového servera je 10.10.30.81** a server používa MySQL/MariaDB službu na správu databáz. Firma ti poskytla prihlasovacie údaje používané v ich systéme vo formáte “**username : password**” pre nasledujúce účty:

 -   **Webový server (10.10.30.71)**
	 -   OS používatelia
	     -   gcomp-web : pass123
	     -   webdev : webdev
 -   **Databázový server (10.10.30.81)**
     -   OS používatelia
	     -   gcomp-dat : password123
	     -   datservice : SomethingStronger
	     -   test : test
     -   MySQL
	     -   root :
	     -   gcomp : AVeryStrongP455
	     -   test : test
      

## Inštrukcie:

Prihlás sa do svojho správcovského stroja s prihlasovacím menom **manager** a heslom **manager-gcomp**. Riaď sa zadanými úlohami a vykonávaj potrebné zmeny. Úspešnosť jednotlivých úloh si môžeš skontrolovať **spustením binárnych súborov** v adresári `/home/manager/check_tasks`.

## Pravidlá:

-   Potrebná základná znalosť práce s príkazovým riadkom a operačným systémom Linux
    
-   Účastník cvičenia môže používať internet pre vyhľadávanie informácií
    
-   Všetky účty, služby alebo súbory, ktoré obsahujú názov “vagrant” musia byť účastníkom ignorované
    
-   Zasahovanie do systémov mimo zadania úlohy môže znemožniť správne fungovanie a preto je možné iba na vlastné riziko
    
-   Zasahovanie do pomocných nástrojov, konfigurácií ale účtov potrebných pre správne fungovanie infrastruktury cvičenia je zakázané
    
-   Hodnotenie cvičenia je možné získať z validačných binárnych súborov


## Úloha 1: MySQL/MariaDB konfigurácia

### Zadanie úlohy:

Na **databázovom serveri** sa prihláste do služby `mysql` ako **root** používateľ, ktorý nemá heslo.

Vypíšte a prezrite si **user tabuľku**, pričom opravte nasledovné základné bezpečnostné problémy:

-   Pridajte heslo pre root používateľa, ktorý sa pripája lokálne
-   Odstráňte root používateľa, ktorý sa pripája vzdialene
-   Odstráňte anonymných používateľov
-   Odstráňte používateľa test a databázu test
    

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Pre použitie `mysql` služby zadajte `mysql -u USER`, kde USER je prihlasovacie meno.
-   Jednoduchý dopyt pre výpis user tabuľky je `SELECT user,host,password FROM mysql.user`
-   Použite internetový vyhľadávač pre nájdenie dopytov, ktoré vykonajú požadované jednoduché úlohy.
</details>

## Úloha 2: phpMyAdmin konfigurácia

### Zadanie úlohy:

Na **webovom serveri** zmeňte **alias pre phpMyAdmin** webovú aplikáciu v konfiguračnom súbore služby Apache.

Následne otvorte **phpMyAdmin konfiguračný súbor** a prezrite si v ňom nastavenia.

Nastavte **blowfish secret** a **odstráňte zanechané prihlasovacie údaje** pre pripojenie do MySQL, ktoré boli v súbore ponechané.

Nezabudnite po vykonaní zmien reštartovať Apache službu.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Cesta k phpMyAdmin konfiguračnému súboru: 	`/usr/share/phpmyadmin/config.inc.php`
-   Cesta k Apache konfiguračnému súboru:  
    `/etc/apache2/apache2.conf`
</details>    

## Úloha 3: SSL komunikácia

### Zadanie úlohy:

Chceme zabezpečiť komunikáciu medzi phpMyAdmin a MySQL pomocou SSL. K dispozícií už máme **certifikačné súbory a súbory s kľúčmi pre server a klienta**. Môžeme ich nájsť na **databázovom serveri v adresári**  `/etc/mysql/ssl` .

Potrebuje presunúť alebo **prekopírovať CA certifikát, klient certifikát a klient kľúč na webový server**. Vytvorte si na webovom serveri vhodne umiestnený adresár pre tieto súbory, tak aby ste do neho mohli zapisovať (pri kopírovaní môžete mať problém s právami, ktorý sa dá riešiť viacerými spôsobmi).

Nezabudnite nastaviť **vlastníka a skupinu** pre všetky **súbory používané pri SSL** aby Apache, ktorý beží pod používateľom `www-data` a MySQL, ktorý beží pod používateľom `mysql`, vedeli čítať tieto súbory.

Ďalej otvorte a **editujte MySQL konfiguračný súbor**  `/etc/mysql/mariadb.conf.d/50-server.cnf`, kde **nastavte a zapnite SSL** komunikáciu. V konfiguračnom súbore môžete nájsť aj nejaké defaultné zakomentované SSL nastavenia. Tu dávajte ale pozor na `ssl = on`, čo nie je správne nastavenie. Správne nastavenie pre zapnutie SSL je `ssl = true`.

Podobne **nastavte SSL** komunikáciu **na strane webového servera**, kde editujete **konfiguračný súbor phpMyAdmin** webovej aplikácie.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Na kopírovanie súborov môžete použiť `scp` alebo `rsync`.
-   V konfiguračných súboroch stačí nastaviť cesty k potrebným SSL súborom a zapnúť SSL.
-   Pamätajte, že databázový server používa server certifikát a klúč a webový server používa klient certifikát a klúč.
-   Pre zmenu vlastníka a skupiny súborov, použite príkaz `chown`.
</details>    

## Úloha 4: Bezpečnosť OS používateľských účtov

### Zadanie úlohy:

Na **webovom a databázovom serveri** sa nachádzajú používateľské **účty so slabým heslom**. Na jednom serveri sa taktiež nachádza účet, ktorý je **očividne nepotrebný a má byť odstránený**.

**Nastavte politiku hesiel** aby používatelia museli používať silnejšie heslá. Použite **cracklib PAM modul** pre nastavenie týchto politík:

-   Počet opakovaní: 	3
-   Minimálna dĺžka:  	12
-   Počet veľkých písmen:  aspoň 2
-   Počet malých písmen:  aspoň 4
-   Počet číslic:  aspoň 3
-   Počet špec. znakov:  aspoň 1
-   Rozdielne znaky od predchádzajúceho:  4
-   Heslo nemôže obsahovať prihlasovacie meno
-   Politika hesiel platí aj pre root používateľa
    
Po nastavení nových politík hesiel **zmeňte heslá všetkých používateľov**.

Prezrite si skupiny používateľov. **Iba používateľské účty s prefixom gcomp v ich mene musia mať skupinu sudo**.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   Politika hesiel sa konfiguruje v tomto súbore: `/etc/pam.d/common-password`
-   `man pam_cracklib`
-   `man gpasswd`
</details>        

## Úloha 5: Prístupové práva súborov

### Zadanie úlohy:

Pri niektorých súboroch je potrebné nastaviť prístup, vlastníka a skupinu.

Na webovom serveri sa presuňte do adresára `/var/www` a nastavte **všetkým adresárom a súborom** (použite rekurziu) **vlastníka**  `webdev` a **skupinu**  `www-data`. Taktiež nastavte **prístupové práva** všetkým adresárom a súborom tak, aby **vlastník mal všetky práva, skupinový používatelia mohli čítať a vykonávať a ostatní používatelia nemali žiadne práva**. Taktiež aplikujte rovnaké prístupové práva, vlastníka a skupinu pre súbor `/usr/share/phpmyadmin/config.inc.php`.

Na databázovom serveri sa presuňte do adresára `/etc/mysql` a nastavte všetkým adresárom a súborom (použite rekurziu) **vlastníka** `datservice` a **skupinu** `mysql`. Taktiež nastavte **prístupové práva** všetkým adresárom a súborom tak, aby **vlastník mal všetky práva, skupinový používatelia mohli čítať a vykonávať a ostatní používatelia nemali žiadne práva**.

### Nápovedy:

<details>
  <summary>NÁPOVEDA</summary>
  
-   `man chown`
-   `man chmod`
-   Potrebné prístupové práva sa dajú nastaviť oktetovým číslom 750
</details>          
