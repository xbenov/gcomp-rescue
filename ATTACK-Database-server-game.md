# Attack scenario

## Story:

You are a penetration tester hired by a small company. They have an internal network to which you can connect to and try to get their secret data. Your Kali machine is already connected to the network, which is **10.10.30.0/24**.

## Instructions:

Login to your attacking machine with username **kali** and password **kali**. Follow given tasks and perform a penetration test for the database and web system. Each task has a flag value you should be able to find if you’ve followed and performed the task instructions. There’s also a binary file in your **home directory** called `flag-check` which serves as a tool to check if you got the correct flag values. To use it, write your flags in a file using format “**# - FLAG**”, where # is the task number and FLAG is the flag value, and pass this file as an argument to the `flag-check` tool.

## Task 1: Discovering the network

### Task assignment:

Use `nmap` tool to ping scan the **10.10.30.0/24 network**. Find online machines (other than your machine) and write down their names and IP addresses. For each machine do a quick **port scan with version detection**. Write the output from nmap to a file.

You found that one of the machines runs a **web service**. Do a web service scan on this machine using the `nikto` tool. From the scan output you can determine that the server runs a **web application**. Try visiting the web application using a web browser.

The flag is the name of the web application that can be found on the web server.

### Hints:
<details>
  <summary>HINT 1</summary>
  
 -   man nmap
-   Look at the -sV option for nmap.
-   man nikto
-   Output from the nikto tool shows you some interesting directories it found, which suggest the presence of a well known web application.
</details>

## Task 2: Enumerate 

### Task assignment:

Now it’s time for some basic default or easy credentials checking. For this you can use whatever tool you fancy to find the unsecure login credentials to phpMyAdmin web application, or follow the rest of this task. 

There’s a mighty framework called **Metasploit**, which can be used for many penetration tests. Launch `msfconsole` tool, which is an interface for Metasploit, and search for “**phpmyadmin**”. There is a scanner type module for phpMyAdmin called **phpmyadmin_login**. Use this module. After selecting it, type `options` to show available options of this module.

Here we need to set **RHOSTS** to our target machine IP address, change the **TARGETURI** to the one which the web server uses, select a userpass wordlist in **USER_PASS** option to make things faster and also set the option **STOP_ON_SUCCESS** to true so that the scan stops on the first valid credentials found.

The wordlist you will use is `/usr/share/wordlists/metasploit/default_userpass_for_services_unhash.txt` .

After setting all these options, type `run` and let the scan do its work, until it finds something.

The flag are the login credentials to phpMyadmin in format “**username:password**”.

### Hints:
<details>
  <summary>HINT 1</summary>

-   Here are the msfconsole commands you will need to use: search, use, options, set, run
-   When you start msfconsole and search for “phpmyadmin“, you can type “use #”, where # is the number of the search result.
-   For the TARGETURI option, remember from Task 1 what was the main directory of the web application and just put it before the /index.php that’s set as default.
</details>

## Task 3: Exploit

### Task assignment:

In Task 2 we’ve found login credentials to phpMyAdmin web application. Log in to phpMyAdmin through a web browser with these credentials and look around the main page for the **version of phpMyAdmin**. 

You may not know this but after a quick search you would find that this is a vulnerable version of this application. There’s a **local file inclusion** which can be escalated to **remote code execution vulnerability**. 

Go to your trusty `msfconsole` and again search for "**phpmyadmin**" . There’s multiple remote code exploits but only one uses local file inclusion and it’s the one **from 2018**. Use it. Now go see what options are available and set the proper **PASSWORD, USERNAME and RHOSTS**. Check the **LHOST** and make sure it’s set to your **IP address 10.10.30.102**. After that, just type `run`. After a while (sometimes it takes a minute) a **meterpreter session** should be opened. 

Look up what commands you can use with meterpreter session if you want to have a look around. After the session started, type `ls` command to see where you are and what files are here. You will see that we are in the phpMyAdmin application folder. There’s one file here that should be interesting and it’s the main **configuration file of phpMyAdmin**. There’s some interesting **settings left behind** in that file that pose a great security risk. Find them.

The flag is login credentials to MySQL in the form “**username:password**”.

### Hints:
<details>
  <summary>HINT 1</summary>
 
 -   The exploit module is called “phpmyadmin_lfi_rce”
-   Set the user and password to the ones you found in Task 2
-   The configuration file of phpMyAdmin is called config.inc.php
-   Look a the bottom of the file
</details>
  

## Task 4: Get more information

### Task assignment:

Let’s see what kind of credentials we got. Use them in the **phpMyAdmin web application** or directly through `mysql` service. This user has access to the **mysql database**, which contains the important **user table**. Let’s look at it. We can see the credentials we already have but there’s **another user** which should provide better access. Write down or copy the **hashed value of his password**.

Now it’s time to crack some hashes. You can use the password hash cracking tool of your choice like `john` or `hashcat`. To speed things up, use the wordlist `/usr/share/wordlists/fastcrack.txt` and it’s better or sometimes necessary to specify the **type of hash** you are dealing with (make sure your tool knows it’s a MySQL password hash).

The flag is the password you uncovered by hash cracking.

### Hints:
<details>
  <summary>HINT 1</summary>

-   The user we are interested in is the root user with host set to “%”
-   For hashcat, the hash mode is 300 and the hash has no leading “*” character
-   For john, the format is “mysql-sha1” and the hash has a leading “*” character
</details>
  

## Task 5: Get the secret information

### Task assignment:

Now the easiest task. Hop in to phpMyAdmin using our new credentials which should provide us with the **highest privileges.**

We now have all the access to all databases. Get the **secret data from gcomp**.

The flag is in a database table row value in the format “**FLAG:************”, where ********* is a secret message.

### Hints:
<details>
  <summary>HINT 1</summary>
 
 Just get the flag in gcomp -> secret_data -> third row. It’s not that hard to find it.
</details>
  