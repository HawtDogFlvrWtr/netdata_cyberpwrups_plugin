# README #

## Overview ##
<!-- MarkdownTOC depth=0 -->

- [About](#about)
- [Requirements](#requirements)
- [Installation](#installation)
	- [General](#general)
	- [Installation Example](#installation-example)
- [Charts](#charts)
- [Known Bugs/Issues](#known-bugsissues)
- [FAQ](#faq)
- [License](#license)
- [Version History](#version-history)
- [Contact](#contact)

<!-- /MarkdownTOC -->

## About ##

[NetData](https://github.com/firehol/netdata/) plugin that polls Cyberpower UPS data.

## Requirements ##

* PowerPanel® Personal Linux (https://www.cyberpowersystems.com/product/software/powerpanel-for-linux/)

## Installation ##

### General ###

Install PowerPanel® Personal Linux on the system running netdata.

With default NetData installation copy the cyberups.chart.sh script to `/usr/libexec/netdata/charts.d/` and the cyberups.conf config file to `/etc/netdata/charts.d/`.

Then restart NetData to activate the plugin.

To disable the cyberpwrups plugin, edit `/etc/netdata/charts.d.conf` and add `cyberups: no`.


### Installation Example ###

Example for standard NetData installation under Ubuntu:

```
cd /tmp/

git clone https://github.com/HawtDogFlvrWtr/netdata_cyberpwrups_plugin --depth 1

sudo cp netdata_cyberpwrups_plugin/cyberups.chart.sh /usr/libexec/netdata/charts.d/

sudo cp netdata_cyberpwrups_plugin/cyberups.conf /etc/netdata/charts.d/
```

## Charts ##

This information is extracted:

- Load percentage
- Charge percentage
- Remaining runtime
- Input Voltage
- Output Voltage

## Known Bugs/Issues ##

Bugs:
* No known bugs at the moment

Issues:
* The netdata user doesn't have permissions to run pwrstat to get the information needed. To resolve this, create the file /etc/sudoers.d/netdata with the content "netdata ALL = NOPASSWD: /usr/sbin/pwrstat" 

## FAQ ##

> Cyberups doesn't appear in netdata. What did I do wrong?

There is a good chance, you didn't add the sudoers file needed for the netdata user to run the application. Please refer to the known bugs/issues section above

## License ##
MIT License                                                                                                                                                                                                        
                                                                                                                                                                                                                   
Copyright (c) 2018 Christopher Phipps                                                                                                                                                                              
                                                                                                                                                                                                                   
Permission is hereby granted, free of charge, to any person obtaining a copy                                                                                                                                       
of this software and associated documentation files (the "Software"), to deal                                                                                                                                      
in the Software without restriction, including without limitation the rights                                                                                                                                       
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell                                                                                                                                          
copies of the Software, and to permit persons to whom the Software is                                                                                                                                              
furnished to do so, subject to the following conditions:                                                                                                                                                           
                                                                                                                                                                                                                   
The above copyright notice and this permission notice shall be included in all                                                                                                                                     
copies or substantial portions of the Software.                                                                                                                                                                    
                                                                                                                                                                                                                   
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR                                                                                                                                         
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                                                                                                                                           
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE                                                                                                                                        
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                                                                                                                                             
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,                                                                                                                                      
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE                                                                                                                                      
SOFTWARE.

## Version History ##

v0.1:
* initial release


## Contact ##

Who do I talk to?

* Repo owner or admin
* Other community or team contact
