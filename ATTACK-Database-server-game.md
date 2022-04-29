# Attack scenario

## Story:

You are a penetration tester hired by a small company. They have an internal network to which you can connect to and try to get their secret data. Your Kali machine is already connected to the network, which is **10.10.30.0/24**.

## Instructions:

Login to your attacking machine with username **kali** and password **kali**.

## Task 1: Discovering the network

### Task assignment:

Use **nmap** tool to **ping scan the 10.10.30.0/24 network**. Find online machines (other than your machine) and write down their names and IP addresses. For each machine do a quick **port scan with version detection**. Write the output from nmap to a file.

You found that one of the machines runs Apache service. Do a **web server scan** on this machine using the **nikto** tool. There’s some interesting directories that suggest the **presence of a well known web application**. Try visiting the web application using a web browser.

The flag is the name of the web application that can be found on the web server.

### Hints:

<details>
  <summary>HINT</summary>
  hint jeden
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
 >! hint

## Task 3: Exploit

### Task assignment:

In Task 2 we’ve found login credentials to phpMyAdmin web application. Log in to phpMyAdmin through a web browser with these credentials and look around the main page for the **version of phpMyAdmin**. 

You may not know this but after a quick search you would find that this is a vulnerable version of this application. There’s a **local file inclusion** which can be escalated to **remote code execution vulnerability**. 

Go to your trusty `msfconsole` and again search for "**phpmyadmin**" . There’s multiple remote code exploits but only one uses local file inclusion and it’s the one **from 2018**. Use it. Now go see what options are available and set the proper **PASSWORD, USERNAME and RHOSTS**. Check the **LHOST** and make sure it’s set to your **IP address 10.10.30.102**. After that, just type `run`. After a while (sometimes it takes a minute) a **meterpreter session** should be opened. 

Look up what commands you can use with meterpreter session if you want to have a look around. After the session started, type `ls` command to see where you are and what files are here. You will see that we are in the phpMyAdmin application folder. There’s one file here that should be interesting and it’s the **config.inc.php**, the configuration file of phpMyAdmin. There’s some interesting **settings left behind** in that file that pose a great security risk. Find them.

The flag is login credentials to MySQL in the form “**username:password**”.

### Hints:
>! hint
  

## Task 4: Get more information

### Task assignment:

Let’s see what kind of credentials we got. Try them in the phpMyAdmin web application to log in to MySQL. This user has access to the **mysql database**, which contains the important **user table**. Let’s look at it. We can see the credentials we already have but there’s **another user** which should provide better access. Write down or copy the **hashed value of his password**.

Now it’s time to crack some hashes. You can use the password hash cracking tool of your choice like `john` or `hashcat`. To speed things up, use the wordlist `/usr/share/wordlists/fastcrack.txt` and it’s better or sometimes necessary to specify the **type of hash** you are dealing with (make sure your tool knows it’s a MySQL password hash).

The flag is the password you uncovered by hash cracking.

### Hints:
  >! hint
  

## Task 5: Get the secret information

### Task assignment:

Now the easiest task. Hop in to phpMyAdmin using our new credentials which should provide us with the **highest privileges.**

We now have all the access to all databases. Get the **secret data from gcomp**.

The flag is in a database table row value in the format “**FLAG:************”, where ********* is a secret message.

### Hints:
>! hint
  