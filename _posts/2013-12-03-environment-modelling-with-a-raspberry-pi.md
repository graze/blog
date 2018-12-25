---
title: "Environment modelling with a raspberry pi"
date: 2013-12-03T15:50:00.000Z
author: csaba-pacsko
tags: [ raspberry-pi, nagios, snmp ]
---

Every graze site has a comms room for the local servers (DC slaves, DB slaves, local webservers/fileshares, etc.) and for the networking gear. As well as monitoring the devices in the comms room we need to monitor the health of the comms room itself.

To achieve this we have previously used the APC environmental monitoring solution: **Netbotz**.

We have good experience with them, except for the slightly tricky setup. They're providing us with metrics through SNMP ([Simple Network Management Protocol](http://en.wikipedia.org/wiki/Simple_Network_Management_Protocol) - the industrial standard for monitoring protocols) which we're using already for gathering the monitoring data from the Cisco routers and switches, so it was easy to implement them to our existing Nagios/Cacti/Datadog configuration.

The only problem is the price. You cannot buy one for less than £500, but depending on your needs, they could cost more than £1000. As we're growing as a business we will need more and more of them at the new sites, and not only for comms rooms. We're happy to spend money on infrastructure that makes our service better, but if we can get the same quality in a cheaper product we'll definitely go for it. Especially if it's open-source (the Netbotz is not).

---
So for my [hacker-time project](/2013/05/21/hacker-time) I decided to find a cheaper solution for this problem.

One of the most basic metrics is the temperature. And for a comms room this one is the most important. The Netbotz units can give us the humidity, airflow, noise level, but the temperature is the most descriptive: if it goes up then something went wrong somewhere and you can end up with "frozen" devices.

My first idea was using a programmable microcontroller, something like the Arduino. In the past I have spent a couple of years programming PLCs part-time (in my home town the geothermal central heating system of the city and the public institutions are still using the solution    I helped to develop and maintain) so the concept of the Arduino was familiar for me. I even have one at home, so I thought it's the perfect tool for this project. For those who don't know: the [Arduino](http://en.wikipedia.org/wiki/Arduino) is an open source hardware board with an Atmel microcontroller chip, and has a bunch of analogue and digital input and output pins. You can program it in C, and it has a huge open-source community.

I spent a couple of hours playing with it, and everything went well, except the networking and the SNMP part. For the networking you can add an Ethernet daughterboard on the Arduino (interchangeable add-on modules, known as shields), and using the Ethernet library it's not too difficult to hang them on a wired network. But the SNMP part is tricky: I should have done all the programming. I don't mind a challenge but as I don't have much time I tried to find a solution to this problem. That's when the Raspberry Pi came up.

I'm pretty sure that everybody knows the Raspberry Pi. It's a nice piece of hardware designed for providing a cheap computer for kids to learn about computers and programming. But it's become popular because it's extremely useable. It's not meant for replacing your desktop/laptop computer but people have found a vast number of uses for them. I use it very successfully as a DLNA server for my TV and sometimes as a media player when my TV can't play a messed up .mkv - it can play full HD videos without a glitch. And we use them at graze for big screen monitoring, filled with graphs and stats of the servers and business processes.

The operating system of the RPi is Linux, the "official" distribution is called Raspbian, and as it's based on my favorite Debian, I like it a lot.

The most important detail from my perspective is that it's got a [GPIO (General Purpose Input/Output)](http://en.wikipedia.org/wiki/General-purpose_input/output) interface which you can use to plug your Arduino in - so the RPi will be responsible for the networking and for being an SNMP server. But as I've read more about the GPIO interface I realised that I didn't really need the Arduino anymore: the thermo sensor can be connected directly to the GPIO pins of the Raspberry.

To get the simplest solution I removed the Arduino from the equation and started to focus on the Raspberry Pi alone.

There are limitations of the Raspberry Pi GPIO functionality but it's still perfect for our needs: you can connect the standard one-wire digital thermo sensors (like the DS18B20) with a 4.7kOhm [pull-up resistor](http://en.wikipedia.org/wiki/Pull-up_resistor) between the 3.3V and the Data line (with the DHT11 Single-Bus Digital Temperature and Relative Humidity Sensor you don't need to solder anything because it's got the resistor integrated - testing this will be the next step of my hardware design of the TempBerry).

## Hardware setup

The hardware you need:

+ a Raspberry Pi
+ a DS1820B temperature sensor
+ a 4.7K Ohm resistor (or 3x1.6k in my case)
+ a soldering kit

For the testing I used:

+ a breadboard
+ a GPIO cable

Using these you don't need to solder anything, but the finished device won't be useable in real life because this setup is quite fragile.

![graze at SMR](/content/images/2014/Apr/tempberry-1.jpg)

Plug the GPIO cable to the Rasberry Pi GPIO interface and the other end to the middle of the breadboard. Connect the red wire of the sensor to the pin 1 of the GPIO (that pin is labeled with a "1" on the RPi, the pin 2 is the one next to it on the right hand side, the 3rd one is the one under pin 1, and so on), the black wire goes to the GND pin, which is pin 6, and the yellow/white data cable of the sensor to the first free GPIO data pin, which is pin 7 in our case. You need to plug the 4.7k resistor between pin 1 and pin 7 of the GPIO.

![graze at SMR](/content/images/2014/Apr/tempberry-2.jpg)

## Software setup

The software you need:

+ the latest Raspbian Linux
+ the w1-gpio module
+ the w1-therm module

Fortunately the GPIO modules are part of the default Raspbian install.

I won't cover the networking setup of the Raspbian. Google it if you're not familiar with this.

The following steps happen in the linux command line of the configured Raspbian (Bash preferable) and you need to be root which is not the suggested way for the every-day usage though.

So you got the command line of the RPi - let's become root, but keeping our own environment:

```bash
/usr/bin/sudo bash
```

Load the GPIO modules:

```bash
/sbin/modprobe w1-gpio
/sbin/modprobe w1-therm
```

Make the modules permanent and loaded automatically after a reboot:

```bash
/bin/echo -e -n "w1-gpio\nw1-therm\n" >> /etc/modules
```

Check if the modules are loaded:

```bash
/sbin/lsmod | /bin/grep w1
```

You should see something like this:

```
w1_therm            	2987  0
w1_gpio             	1308  0
wire               	24629  2 w1_gpio,w1_therm
```

The devices connected to the GPIO will appear in the following directory:

```bash
/bin/ls -l /sys/bus/w1/devices/
```

If you did a good job on the breadboard (or with the soldering kit) and connected the right wires to the correct pins then you should see something like this:

```
lrwxrwxrwx 1 root root 0 Nov 29 12:22 28-0000054d96ae -> ../../../devices/w1_bus_master1/28-0000054d96ae
lrwxrwxrwx 1 root root 0 Dec  2 16:43 w1_bus_master1 -> ../../../devices/w1_bus_master1
```

Every device has an identifier number (the serial number) and GPIO modules are creating the necessary folders and files for all recognised devices. The metrics are in the w1_slave files in the directories named by the serial numbers. In this case we need to look at this file:

```bash
/bin/cat /sys/bus/w1/devices/28-0000054d96ae/w1_slave
```

If the sensor is working correctly you should see something like this:

```
a5 01 4b 46 7f ff 0b 10 f7 : crc=f7 YES
a5 01 4b 46 7f ff 0b 10 f7 t=26312
```

The interesting value is `t=26312`, which is in fact 26.312 Celsius.

We need only this number so let's create a one-liner to show only this value:

```bash
/bin/cat /sys/bus/w1/devices/28*/w1_slave|grep "t="|/usr/bin/awk '{print $10}'|/bin/sed 's/t=//g'|/bin/sed 's/\(..\)\(...\)/\1.\2/'
```

You could use this one-liner everywhere, but putting it into a script makes your life easier:

```bash
/usr/bin/vi /usr/local/bin/therm.sh
```

```bash
#!/bin/bash
/bin/cat /sys/bus/w1/devices/28*/w1_slave|grep "t="|/usr/bin/awk '{print $10}'|/bin/sed 's/t=//g'|/bin/sed 's/\(..\)\(...\)/\1.\2/'
```

Make it executable:

```bash
/bin/chmod +x /usr/local/bin/therm.sh
```

And run it:

```bash
/usr/local/bin/therm.sh
```

The result:

    26.437

We're half-way there. Now we need to expose this data to our Nagios server with SNMP by installing the snmp daemon from the Raspbian/Debian repository:

```bash
/usr/bin/apt-get update && /usr/bin/apt-get install snmpd
```

The default SNMP config would work, but as it's full of examples and I like to keep things simple, let's rename it:

```bash
mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.old
```

We only need the built-in script execution functionality of the SNMP daemon so let's create a new, simple config:

```bash
/usr/bin/vi /etc/snmp/snmpd.conf
```

```
agentAddress udp:161
rocommunity public 10.10.10.10
extend .1.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743 therm /bin/bash /usr/local/bin/therm.sh
```

With this we're defining only the used network interface(s), protocol and port (all configured interfaces, udp and 161), a read-only community string (public) and the client who can access the exported SNMP OIDs - which is our Nagios server (10.10.10.10), and the last line is executing our script and putting the data from it on an OID ([read more on SNMP, MIBs and OIDs](http://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)).

The most important line: the parameters of the **extend** function:

- the OID (I used the Netbotz OIDs to keep our Nagios configuration as simple as possible, basically you can use any free OID, or you can even register your own namespace)
- the name of your script
- and the executable command

Save the config file and restart snmpd:

```bash
/etc/init.d/snmpd restart
```

## Testing

Now we can test it from the Nagios server with snmpwalk:

```bash
/usr/bin/snmpwalk -v2c -c cacti 10.10.10.11 .1.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743
```

You should get something like this:

```
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.1.0 = INTEGER: 1
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.2.5.116.104.101.114.109 = STRING: "/bin/bash"
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.3.5.116.104.101.114.109 = STRING: "/usr/local/bin/therm.sh"
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.4.5.116.104.101.114.109 = ""
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.5.5.116.104.101.114.109 = INTEGER: 5
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.6.5.116.104.101.114.109 = INTEGER: 1
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.7.5.116.104.101.114.109 = INTEGER: 1
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.20.5.116.104.101.114.109 = INTEGER: 4
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.2.1.21.5.116.104.101.114.109 = INTEGER: 1
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.3.1.1.5.116.104.101.114.109 = STRING: "26.500"
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.3.1.2.5.116.104.101.114.109 = STRING: "26.500"
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.3.1.3.5.116.104.101.114.109 = INTEGER: 1
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.3.1.4.5.116.104.101.114.109 = INTEGER: 0
iso.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.4.1.2.5.116.104.101.114.109.1 = STRING: "26.500"
```

Test with the Nagios plugin itself:

```
/usr/lib/nagios/plugins/check_snmp -H 10.10.10.11 -o .1.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.4.1.2.5.116.104.101.114.109.1 -w 27 -c 29 -C cacti -l Temp -u C -t 20
```

The response should be something similar:

```
SNMP OK - Temp 26.5 C | Temp=26.5
```

## Nagios config

If everything went well, we can add our new host and service to Nagios:

```bash
vi /etc/nagios/conf.d/tempberry.graze.com.cfg
```

```
define host {
  use                     generic-host
  host_name               tempberry.graze.com
  address                 10.10.10.11
  hostgroups     	      linux-servers,
  alias                   netbotz-2.dunstable.graze.com
  max_check_attempts      3
  check_command           check-icmp
  max_check_attempts      5
}

define service {
  check_command           check_snmp!-o .1.3.6.1.4.1.5528.100.4.1.1.1.8.1095346743.4.1.2.5.116.104.101.114.109.1 -w 29 -c 30 -C cacti -l Temp -u C -t 20
  host_name               tempberry.graze.com
  use                     generic-service
  service_description     Check Comms Room Temp
  notifications_enabled   1
  max_check_attempts      5
}
```

Check the syntax of the Nagios config:

```bash
/usr/sbin/nagios3 -v /etc/nagios3/nagios.cfg
```

And if there is no error then reload the config:

```bash
service nagios3 reload
```

The total cost of this project was less than £50 so the future savings on our environmental monitoring infrastructure will be significant.

![graze at SMR](/content/images/2014/Apr/tempberry-3.jpg)

