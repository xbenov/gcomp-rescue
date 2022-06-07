#!/bin/sh

# CREATE CA
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 > /etc/mysql/ssl/ca-key.pem
openssl req -new -x509 -nodes -days 365 -key /etc/mysql/ssl/ca-key.pem -out /etc/mysql/ssl/ca-cert.pem -subj "/C=SK/ST=BB/L=Bratislava/O=STU/CN=DB CA"

# CREATE SERVER
openssl req -newkey rsa:4096 -nodes -keyout /etc/mysql/ssl/server-key.pem -out /etc/mysql/ssl/server-req.pem -subj "/C=SK/ST=BB/L=Bratislava/O=STU/CN=10.10.30.81"
openssl x509 -req -in /etc/mysql/ssl/server-req.pem -days 365 -CA /etc/mysql/ssl/ca-cert.pem -CAkey /etc/mysql/ssl/ca-key.pem -CAcreateserial -out /etc/mysql/ssl/server-cert.pem

# CREATE CLIENT
openssl req -newkey rsa:4096 -nodes -keyout /etc/mysql/ssl/client-key.pem -out /etc/mysql/ssl/client-req.pem -subj "/C=SK/ST=BB/L=Bratislava/O=STU/CN=10.10.30.71"
openssl x509 -req -in /etc/mysql/ssl/client-req.pem -days 365 -CA /etc/mysql/ssl/ca-cert.pem -CAkey /etc/mysql/ssl/ca-key.pem -CAcreateserial -out /etc/mysql/ssl/client-cert.pem

# FIX RSA
openssl rsa -in /etc/mysql/ssl/server-key.pem -out /etc/mysql/ssl/server-key.pem
openssl rsa -in /etc/mysql/ssl/client-key.pem -out /etc/mysql/ssl/client-key.pem
