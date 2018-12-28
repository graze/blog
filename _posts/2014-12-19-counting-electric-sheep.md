---
title: "Counting electric sheep"
date: 2014-12-19T14:32:02.000Z
author: john-smith
image: /content/images/2014/Aug/breadboard-1.jpg
tags: [ open-source, c ]
---

![box former][boxformer]

Mulled wine, log fires, Christmas carols... nothing can say "Merry Christmas!" quite like a box forming machine. And we have several heavily modified versions - thanks engineering team, season's greetings. They suck up bits of cardboard and spit out the graze boxes we know and love. **How many boxes do they make?** That is what I need to find out. There will be counting, there will be electric(ity). There will not be sheep.

Bolted next to the conveyor there is a light sensor that blinks each time a box flies out. After diving into the perpetual stream of boxes and into the inner workings of the machine, I found the trailing leads from the little blinker. According to the multimeter, it outputs a 24v signal each time the sensor senses. This is standard for [PLC](http://en.wikipedia.org/wiki/Programmable_logic_controller) equipment.

## The Plan

* build a circuit to drop the sensor's 24v down to a GPIO friendly 3.3v
* connect the 3.3v output to a Raspberry Pi's GPIO header
* record a timestamp each time we detect a signal
* send the timestamps to a DB somewhere
* release the data team up on the timestamps

## The Prototype

![breadboard][prototype]

What you see above is the prototype circuit. It will get prettier, I promise.

Luckily for me, someone had already done all of the hard work and designed the circuit over at the [Raspberry Pi forums](http://www.raspberrypi.org/forums/viewtopic.php?f=44&t=42938) (thanks Tage). It's based around an [optocoupler](http://en.wikipedia.org/wiki/Opto-isolator), which are great little devices for keeping two circuits electronically isolated, but still allowing them to communicate.

There's an LED to give an indication of what's going on, and instead of a box forming machine, I have a little switch and a car battery charger to test with.

## The Program

Some design considerations

* zero configuration, including networking
* uniquely identifiable - so we can tell box forming machines apart
* network resilience - able to continue recording in the event of a network failure

With the above in mind, a small C program was written: **signalCounter**. If you want to read more about it, head over to the [github page](https://github.com/graze/signalCounter/) and take a look at its README.

## The future

Next up, connecting the whole thing up and seeing if it works. Then, assuming it does, getting some pretty PCBs printed and rolling them out to the all of our box forming machines.

Look out for the way more pretty PCBs in the next installment of *Box Former Counting Machine - A Graze Tech Blog Post*.

[boxFormer]: /content/images/2014/12/box-former-1.jpg
[prototype]: /content/images/2014/Aug/breadboard-1.jpg
