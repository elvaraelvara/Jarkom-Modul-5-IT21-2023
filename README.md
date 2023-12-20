# Praktikum Modul 5 Jarkom 2023
| Nama                           | NRP      |
|--------------------------------|-------------|
| Maria Teresia Elvara Bumbungan | 5027211042  |
| Nathania Elirica Aliyah        | 5027211057  |

## Soal Nomor 0 


- Tugas pertama, buatlah peta wilayah sesuai berikut ini, Untuk menghitung rute-rute yang diperlukan, gunakan perhitungan dengan metode VLSM. Buat juga pohonnya, dan lingkari subnet yang dilewati.


![Topologi](https://i.ibb.co/9TSnQcg/image.png)

![Tree](https://i.ibb.co/wr6m4x7/tree.png)

- Kemudian buatlah rute sesuai dengan pembagian IP yang kalian lakukan. (Lebih detail https://intip.in/SubnetIT21Modul5 )
  
Routing VLSM

![Tree](https://i.ibb.co/RDM0FCn/image.png)


Pembagian IP

![Tree](https://i.ibb.co/TP10m9p/image.png)

![Tree](https://i.ibb.co/k2bhmkP/image.png)


- Tugas berikutnya adalah memberikan ip pada subnet SchwerMountain, LaubHills, TurkRegion, dan GrobeForest menggunakan bantuan DHCP.

*Konfigurasi tiap node*

**Aura**

```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.74.14.133
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.74.14.129
    netmask 255.255.255.252
```

**Fern**
```
auto eth0
iface eth0 inet static
    address 10.74.14.2
    netmask 255.255.255.128
    gateway 10.74.14.1

auto eth1
iface eth1 inet static
    address 10.74.14.149
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.74.14.145
    netmask 255.255.255.252
```

**Frieren**

```
auto eth0
iface eth0 inet static
    address 10.74.14.134
    netmask 255.255.255.252
    gateway 10.74.14.133
    
auto eth1
iface eth1 inet static
    address 10.74.14.137
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.74.14.141
    netmask 255.255.255.252
```
**GrobeForest**
```
auto eth0
iface eth0 inet dhcp
```
***Heiter**
```
auto eth0
iface eth0 inet static
    address 10.74.14.130
    netmask 255.255.255.252
    gateway 10.74.14.129

auto eth1
iface eth1 inet static
    address 10.74.0.1
    netmask 255.255.248.0

auto eth2
iface eth2 inet static
    address 10.74.8.1
    netmask 255.255.252.0
```
**Himmel**
```
auto eth0
iface eth0 inet static
    address 10.74.14.142
    netmask 255.255.255.252
    gateway 10.74.14.141

auto eth1
iface eth1 inet static
    address 10.74.12.1
    netmask 255.255.254.0

auto eth2
iface eth2 inet static
    address 10.74.14.1
    netmask 255.255.255.128
```
**LaubHills**
```
auto eth0
iface eth0 inet dhcp
```
**Revolte**
```
auto eth0
iface eth0 inet static
    address 10.74.14.150
    netmask 255.255.255.252
    gateway 10.74.14.149
```
**Ritcher**
```
auto eth0
iface eth0 inet static
    address 10.74.14.146
    netmask 255.255.255.252
    gateway 10.74.14.145
```
**SchwerMountain**
```
auto eth0
iface eth0 inet dhcp
```
**Sein**
```
auto eth0
iface eth0 inet static
    address 10.74.8.2
    netmask 255.255.252.0
    gateway 10.74.8.1
```
**Stark**
```
auto eth0
iface eth0 inet static
    address 10.74.14.138
    netmask 255.255.255.252
    gateway 10.74.14.137
```
**TurkRegion**
```
auto eth0
iface eth0 inet dhcp
```

*Konfigurasi DHCP*

**DHCP-Relay**
```
# Himmel Heiter

#!/bin/bash

apt update

apt-get install isc-dhcp-relay rsyslog -y

echo "# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS=\"10.74.14.150\"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES=\"eth0 eth1 eth2\"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=\"\"" >/etc/default/isc-dhcp-relay

service rsyslog start

echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf

service isc-dhcp-relay restart
service isc-dhcp-relay status
```

**DHCP-Sever**
```
# Revolte

#!/bin/bash

echo "nameserver 192.168.122.1" >/etc/resolv.conf

apt update
apt install isc-dhcp-server rsyslog -y

echo "# Defaults for isc-dhcp-server (sourced by /etc/init.d/isc-dhcp-server)
# Path to dhcpd's config file (default: /etc/dhcp/dhcpd.conf).
#DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf
# Path to dhcpd's PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid
# Additional options to start dhcpd with.
#       Don't use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=\"\"
# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. \"eth0 eth1\".
INTERFACESv4=\"eth0\"
INTERFACESv6=\"\"" >/etc/default/isc-dhcp-server

echo "
# Subnet A1
subnet 10.74.14.128 netmask 255.255.255.252 {
}

# Subnet A2
subnet 10.74.0.0 netmask 255.255.248.0 {
    range 10.74.0.2 10.74.7.254;
    option routers 10.74.0.1;
    option broadcast-address 10.74.7.255;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A3
subnet 10.74.8.0 netmask 255.255.252.0 {
    range 10.74.8.3 10.74.11.254;
    option routers 10.74.8.1;
    option broadcast-address 10.74.11.255;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A4
subnet 10.74.14.132 netmask 255.255.255.252 {
}

# Subnet A5
subnet 10.74.14.136 netmask 255.255.255.252 {
}

# Subnet A6
subnet 10.74.14.140 netmask 255.255.255.252 {
}

# Subnet A7
subnet 10.74.12.0 netmask 255.255.254.0 {
    range 10.74.12.2 10.74.13.254;
    option routers 10.74.12.1;
    option broadcast-address 10.74.13.255;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A8
subnet 10.74.14.0 netmask 255.255.255.128 {
    range 10.74.14.3 10.74.14.126;
    option routers 10.74.14.1;
    option broadcast-address 10.74.14.127;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A9
subnet 10.74.14.144 netmask 255.255.255.252 {
}

# Subnet A10
subnet 10.74.14.148 netmask 255.255.255.252 {
}
" >/etc/dhcp/dhcpd.conf

rm /var/run/dhcpd.pid

service isc-dhcp-server restart
service rsyslog start

service isc-dhcp-server status
```

*Konfigurasi DNS*

**DNS**
```
#!/bin/bash

echo "nameserver 192.168.122.1" >/etc/resolv.conf

apt update
apt install bind9 dnsutils -y

# Backup existing file
cp /etc/bind/named.conf.options /etc/bind/named.conf.options/bak

# Configuration data
echo 'options {
    listen-on-v6 { none; };
    directory "/var/cache/bind";

    # Forwarders
    forwarders {
        192.168.122.1;
    };

    # If there is no answer from the forwarders, dont attempt to resolve recursively
    forward only;

    dnssec-validation no;

    auth-nxdomain no;    # conform to RFC1035
    allow-query { any; };
};' >/etc/bind/named.conf.options

service bind9 restart
service bind9 status
```
## Soal Nomor 1
Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Aura menggunakan iptables, tetapi tidak ingin menggunakan MASQUERADE.

**Aura**
```
IPETH0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 10.74.0.0/20
```

- `IPETH0` diatur untuk menyimpan alamat IP dari antarmuka `eth0` pada server Aura. Ini dilakukan dengan menggunakan perintah `ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1` , yang mengambil alamat IP dari antarmuka `eth0`.
- `iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 10.74.0.0/20` untuk menambahkan aturan NAT pada tabel nat, khususnya pada rantai POSTROUTING, mengaplikasikan Source NAT (SNAT) pada paket yang keluar melalui antarmuka `eth0`, dengan mengganti alamat sumber menjadi alamat IP dari `eth0`, dan hanya berlaku untuk range IP 10.74.0.0/20.

## Output Soal Nomor 1

**Ritcher**
![Soal1Ritcher](https://i.ibb.co/6FYQ5Qb/no1-richter.png)

**Ritcher**
![Soal1Client](https://i.ibb.co/L8DBPQT/no1-client.png)

Konfigurasi iptables berhasil, memungkinkan akses keluar pada topologi dengan ping google.com

## Soal Nomor 2
Kalian diminta untuk melakukan drop semua TCP dan UDP kecuali port 8080 pada TCP.

**Semua Node**
```
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -j DROP
iptables -A INPUT -p udp -j DROP
```
- Pada setiap node, perintah iptables `-A INPUT -p tcp --dport 8080 -j ACCEPT `pertama kali mengizinkan paket TCP yang ditujukan ke port 8080. Kemudian, perintah `iptables -A INPUT -p tcp -j DROP` dan` iptables -A INPUT -p udp -j DROP` menetapkan aturan untuk menolak semua paket TCP dan UDP selain dari port 8080, mengamankan infrastruktur dengan memblokir akses ke port dan protokol yang tidak diinginkan.

## Output Soal Nomor 2
**TCP**
- Sender
` nc -l -p 8080`

![Soal2](https://i.ibb.co/6sJztVt/no2-sender-tcp.png)

- Receiver

` nc 10.74.12.4 8080 `

![Soal2](https://i.ibb.co/jbGkYXK/no2-receiver-tcp.png)

**UDP**
- Sender
` nc -u -l -p 8080`

![Soal2](https://i.ibb.co/gPfyxhn/no2-sender-udp.png)

- Receiver

` nc -u 10.74.12.4 8080 `

![Soal2](https://i.ibb.co/gyd4bJG/no2-receiver-udp.png)


Konfigurasi iptables berhasil memungkinkan koneksi TCP pada port 8080, sedangkan koneksi TCP dan UDP lainnya berhasil ditolak.

## Soal Nomor 3
Kepala Suku North Area meminta kalian untuk membatasi DHCP dan DNS Server hanya dapat dilakukan ping oleh maksimal 3 device secara bersamaan, selebihnya akan di drop.

**DHCP (Revolte) dan DNS Server (Richter)**
```
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
```
- `iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT` mengizinkan koneksi yang telah terbentuk (ESTABLISHED,RELATED).
- `iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DRO` membatasi jumlah koneksi ping (ICMP) yang dapat dilakukan secara bersamaan menjadi maksimal 3 perangkat, dan selebihnya akan di-drop.


## Soal Nomor 4
Lakukan pembatasan sehingga koneksi SSH pada Web Server hanya dapat dilakukan oleh masyarakat yang berada pada GrobeForest.

**Web Server (Stark & Sein)**
```
iptables -A INPUT -p tcp --dport 22 -s 10.74.8.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP
```

- `iptables -A INPUT -p tcp --dport 22 -s 10.74.8.0/22 -j ACCEPT` mengizinkan koneksi SSH (port 22) hanya dari jaringan GrobeForest dengan rentang alamat IP 10.74.8.0/22.
- `iptables -A INPUT -p tcp --dport 22 -j DROP` menetapkan bahwa koneksi SSH dari sumber lain (di luar jaringan GrobeForest) akan ditolak.



## Output Soal Nomor 4
**Stark**

`nc -l -p 22` 


**Client**

`nc 10.74.14.138 22`


**GrobFores**

`nc 10.74.14.138 22`

![Soal4](https://i.ibb.co/vDgp4Gw/no4.png)

koneksi SSH ke Web Server (Stark) hanya diizinkan dari jaringan GrobeForest, sehingga mencoba menggunakan nc dari client di GrobeForest ke port 22 pada Web Server akan berhasil, sedangkan mencoba dari client di luar GrobeForest atau menggunakan port yang berbeda akan menghasilkan penolakan koneksi.

## Soal Nomor 5
Selain itu, akses menuju WebServer hanya diperbolehkan saat jam kerja yaitu Senin-Jumat pada pukul 08.00-16.00.

**Sein Stark**
```
iptables -A INPUT -m time --timestart 08:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -j REJECT
```
-  `iptables -A INPUT -m time --timestart 08:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT` mengizinkan akses selama jam kerja pada hari Senin-Jumat dari pukul 08:00 hingga 16:00. 
- `iptables -A INPUT -j REJECT` menetapkan bahwa akses akan ditolak pada waktu selain yang telah ditentukan sebelumnya.

## Output Soal 5
- Berhasil

**GrobeForest**

`ping 10.74.14.138`

![Soal5Berhasil](https://i.ibb.co/0nJqxN5/no5-berhasil.png)


- Gagal
**Stark**

`date --set"2023-12-20 17:00:00`

**GrobeForest**

`ping 10.74.138`

![Soal5Gagal](https://i.ibb.co/2KmFJsG/no5-gagal.png)

Akses menuju WebServer (Sein & Stark) hanya diizinkan selama jam kerja Senin-Jumat dari pukul 08:00 hingga 16:00, sedangkan pada situasi di luar jam kerja atau ping dari sumber Stark pada waktu yang tidak diizinkan.

## Soal Nomor 6
Lalu, karena ternyata terdapat beberapa waktu di mana network administrator dari WebServer tidak bisa stand by, sehingga perlu ditambahkan rule bahwa akses pada hari Senin - Kamis pada jam 12.00 - 13.00 dilarang (istirahat maksi cuy) dan akses di hari Jumat pada jam 11.00 - 13.00 juga dilarang (maklum, Jumatan rek).

**WebServer**

```
iptables -I INPUT 3 -m time --timestart 12:00 --timestop 13:00 --weekdays Mon,Tue,Wed,Thu -j REJECT
iptables -I INPUT 4 -m time --timestart 11:00 --timestop 13:00 --weekdays Fri -j REJECT
```

- `iptables -I INPUT 3 -m time --timestart 12:00 --timestop 13:00 --weekdays Mon,Tue,Wed,Thu -j REJECT` dan `iptables -I INPUT 4 -m time --timestart 11:00 --timestop 13:00 --weekdays Fri -j REJECT` menetapkan bahwa pada hari Senin hingga Kamis pada jam 12:00 - 13:00 serta pada hari Jumat pada jam 11:00 - 13:00, akses akan ditolak.

## Output Soal Nomor 6
- berhasil

**GrobeForest**

`ping 10.74.14.138`

![Soal6Berhasil](https://i.ibb.co/Vtyrh4W/no6-berhasil.jpg)

- Gagal

**Stark**

`date --set"2023-12-20 12:02:00"`

**GrobeForest**

`ping 10.74.138`

![Soal6Gagal](https://i.ibb.co/SrND6cG/no6-gagal.png)

Web Server pada waktu yang ditentukan (Senin-Kamis 12:00-13:00 dan Jumat 11:00-13:00) ditolak.

## Soal Nomor 7 
Karena terdapat 2 WebServer, kalian diminta agar setiap client yang mengakses Sein dengan Port 80 akan didistribusikan secara bergantian pada Sein dan Stark secara berurutan dan request dari client yang mengakses Stark dengan port 443 akan didistribusikan secara bergantian pada Sein dan Stark secara berurutan.


**heiter & frieren**
```
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.74.8.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.74.8.2
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.74.8.2 -j DNAT --to-destination 10.74.14.138
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 10.74.14.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.74.14.138
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 10.74.14.138 -j DNAT --to-destination 10.74.8.2

while true; do nc -l -p 80 -c 'echo "Sein"'; done
while true; do nc -l -p 80 -c 'echo "Stark"'; done
while true; do nc -l -p 443 -c 'echo "Sein"'; done
while true; do nc -l -p 443 -c 'echo "Stark"'; done
```

- `iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.74.8.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.74.8.2` menerapkan DNAT (Destination NAT) untuk distribusi load balancing pada port 80 ke Web Server Sein dan Stark secara bergantian setiap dua request.

- `iptables -A PREROUTING -t nat -p tcp --dport 80 -d 10.74.8.2 -j DNAT --to-destination 10.74.14.138 `menetapkan DNAT ke Web Server Sein pada port 80 jika request bukan pada urutan yang berada di dalam setiap dua request.

- `iptables -A PREROUTING -t nat -p tcp --dport 443 -d 10.74.14.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.74.14.138 ` menerapkan DNAT untuk distribusi load balancing pada port 443 ke Web Server Sein dan Stark secara bergantian setiap dua request.

- `iptables -A PREROUTING -t nat -p tcp --dport 443 -d 10.74.14.138 -j DNAT --to-destination 10.74.8.2` menetapkan DNAT ke Web Server Stark pada port 443 jika request bukan pada urutan yang berada di dalam setiap dua request.

- `while true; do nc -l -p 80 -c 'echo "Sein"'; done` menggunakan netcat untuk mensimulasikan server Sein pada port 80 yang akan selalu merespon dengan teks "Sein".

- `while true; do nc -l -p 80 -c 'echo "Stark"'; done` menggunakan netcat untuk mensimulasikan server Stark pada port 80 yang akan selalu merespon dengan teks "Stark".

- `while true; do nc -l -p 443 -c 'echo "Sein"'; done` menggunakan netcat untuk mensimulasikan server Sein pada port 443 yang akan selalu merespon dengan teks "Sein".

- `while true; do nc -l -p 443 -c 'echo "Stark"'; done` menggunakan netcat untuk mensimulasikan server Stark pada port 443 yang akan selalu merespon dengan teks "Stark".

## Soal Nomor 8 
Karena berbeda koalisi politik, maka subnet dengan masyarakat yang berada pada Revolte dilarang keras mengakses WebServer hingga masa pencoblosan pemilu kepala suku 2024 berakhir. Masa pemilu (hingga pemungutan dan penghitungan suara selesai) kepala suku bersamaan dengan masa pemilu Presiden dan Wakil Presiden Indonesia 2024.

**Sein dan Stark**
```
iptables -A INPUT -p tcp --dport 80 -s 10.74.14.148/30 -m time --datestart 2023-12-10 --datestop 2024-02-15 -j DROP
```

-  menolak akses TCP pada port 80 dari subnet yang berasal dari masyarakat Revolte (10.74.14.148/30) selama periode pemilu kepala suku 2024.

## Output Soal Nomor 8
- Berhasil
**GrobeForest**

`nmap 10.74.8.2 80`

![Soal8Berhasil](https://i.ibb.co/zNcp842/soal8-client-berhasil.png)

- Gagal

**Revolte**

`nmap 10.74.8.2 80`

![Soal8Gagal](https://i.ibb.co/wWnPcWT/soal8-revolte-gagal.png)

Akses ke WebServer (Sein dan Stark) dari subnet masyarakat Revolte (10.74.14.148/30) melalui port 80 ditolak selama periode pemilu kepala suku 2024.

## Soal Nomor 9

Sadar akan adanya potensial saling serang antar kubu politik, maka WebServer harus dapat secara otomatis memblokir  alamat IP yang melakukan scanning port dalam jumlah banyak (maksimal 20 scan port) di dalam selang waktu 10 menit. 
(clue: test dengan nmap)

**Sein dan Stark**
```
iptables -N portscan
iptables -A INPUT -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP
iptables -A FORWARD -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP
iptables -A INPUT -m recent --name portscan --set -j ACCEPT
iptables -A FORWARD -m recent --name portscan --set -j ACCEPT
```

-  Membuat aturan untuk mendeteksi dan memblokir serangan port scanning dengan menggunakan modul recent. Jika terdapat lebih dari 20 scan port dalam waktu 10 menit, `iptables -A INPUT -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP dan iptables -A FORWARD -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP` akan memblokir alamat IP tersebut.
- `iptables -A INPUT -m recent --name portscan --set -j ACCEPT dan iptables -A FORWARD -m recent --name portscan --set -j ACCEPT` menetapkan bahwa alamat IP yang melakukan scanning port dalam jumlah maksimal 20 dalam waktu 10 menit akan diizinkan.

## Output Soal Nomor 9
**Client**

`ping 10.74.8.2 -c 25`

![Soal9](https://i.ibb.co/L1WTLDM/soal9.png)

Akses dari client yang melakukan lebih dari 20 percobaan scanning port (dalam contoh ini, dengan perintah ping 10.74.8.2 -c 25) ke WebServer (Sein dan Stark) dalam waktu 10 menit akan diblokir.

## Soal Nomor 10

Karena kepala suku ingin tau paket apa saja yang di-drop, maka di setiap node server dan router ditambahkan logging paket yang di-drop dengan standard syslog level. 

**Sein**
```
iptables -A INPUT -j LOG --log-level debug --log-prefix 'Dropped Packet' -m limit --limit 1/second --limit-burst 10

iptables -L
```

-  iptables pada server Sein menambahkan aturan logging untuk setiap paket yang di-drop, dengan level syslog debug, prefix 'Dropped Packet', dan pembatasan logging sebanyak 10 paket per detik dengan batasan burst 10, yang dapat dilihat dengan menjalankan perintah `iptables -L.`

## Output Nomor 10

![Soal10](https://i.ibb.co/fSb30Tv/no10.png)

Berhasil menambahkan ntuk setiap paket yang di-drop, dengan level syslog debug dan prefix 'Dropped Packet'.
