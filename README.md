# rotBright - touch rotation brightness

#### Linux bash scripts to get display, brightness, touchscreen (and pen) in tune 
Linux distributions tend to neglect thorough special key handling, brightness control, touchscreen and pen support,  
especially notebook, tablet and convertible users suffer from half-cooked, incorrect or missing implementation.

In many cases devices are recognized correctly, so let's use what we got and try to mend it for daily use.

- - -

### download  
download repository from GitHub,  
unzip and copy for example to: ~/rotBright

**or**

copy script to current directory  
`wget https://raw.github.com/qrti/rotBright/master/script/*.sh`

**or**

check if git is installed  
`$ git --version`

if git is not installed  
`$ sudo apt-get install git-all`

clone shrink repository to current directory  
`$ git clone https://github.com/qrti/rotBright.git`

- - -

### configure  
figure out your machines touch (and pen) device  
`$ xinput -list`

edit the script  
`$ nano rotate.sh`

replace the preconfigured entries with your data
```
DEVICE0="ELAN22A6:00 04F3:22A6"         # Asus T102HA touchscreen
DEVICE1="ELAN22A6:00 04F3:22A6 Pen"     #             pen
```

leave the second entry empty to configure only one device
```
DEVICE0="YOUR_DEVICE:xx xxxx:xxxx"      # your touchscreen
DEVICE1=
```

display rotation might set brightness to maximum, so it has to be restored as well  
executing rotate.sh will also call bright.sh and restore brightness if
```
RESTBRIGHT=true                         # restore brightness
```

- - -

### execute  
change directory  
`$ cd ~/rotBright`

make scripts executable once  
`chmod a+x rotate.sh`  
`chmod a+x bright.sh`

execute rotation script  
`$ ./rotate.sh [+|normal|inverted|left|right|restore]`

|+   |normal |inverted |left |right | restore |       |
|----|-------|---------|-----|------|---------|-------|
|+90°|   0°  |   180°  | 90° | 270° |last used|current|

(counter clockwise)

execute brightness script  
`$ ./bright.sh [-|+|[10-100]|restore]`

|   -  |    +   | 10-100 | restore |       |
|------|--------|--------|---------|-------|
|darker|brighter|absolute|last used|current|

- - -

### keyboard shortcuts
for convenient use you can bind rotation and brightness control to keys,  
unfortunately on most laptops the special function key in combination with F1..F12 will not work,  
so try to figure out unused combinations with CTRL and/or ALT

example for brightness advance  
`preferences/keyboard/shortcuts/custom shortcuts/add custom shortcut`

```
name: Bright+
command: /home/USERNAME/rotBright/bright.sh +
key: CTRL-F6
```
replace USERNAME with your username

- - -

### auto restore
to automatically restore last used rotation and brightness at system start do the following

`preferences/startup applications/custom command`

```
name: Restore Rotation and Brightness 
command: /home/USERNAME/rotBright/rotate.sh restore
startup delay: 15
```
replace USERNAME with your username  
on fast systems startup delay can be reduced

- - -

### remarks  
\- developed under Linux Mint 18.3 on Asus T102HA Mini Transformer with Visual Studio Code  
\- not tested on other machines but might work well on various notebooks, tablets and convertibles

__inspired by__  
https://www.linux.com/learn/how-configure-touchscreen-linux  
https://askubuntu.com/questions/368317/rotate-touch-input-with-touchscreen-and-or-touchpad  
https://gist.github.com/mildmojo/48e9025070a2ba40795c  
https://ubuntuforums.org/archive/index.php/t-2313209.html  
https://wiki.debian.org/InstallingDebianOn/Asus/T100TA#Screen_power_management

Donations are welcome!

[![https://www.paypal.com](https://www.paypalobjects.com/webstatic/en_US/btn/btn_donate_pp_142x27.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=E7JNEDMHAJ3TJ)

- - -

### history  
V0.5  
initial version

- - -

### copyright  
rotBright is published under the terms of MIT license

Copyright (c) 2018 [qrt@qland.de](mailto:qrt@qland.de)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
