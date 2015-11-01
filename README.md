ThinkPad X1 with Ubuntu Tweaks
==============

> Developers should not underestimate customizing their work tool. In this way, configuring your favorite Linux distribution should give you a better work experience. Here is a cheatsheet that gathers tips I applied to [Ubuntu 12.04 LTS (Precise Pangolin)](http://releases.ubuntu.com/12.04/) with [GNOME 3 Fallback Session (Classic)](https://launchpad.net/ubuntu/precise/+package/gnome-session-fallback) on my [Lenovo ThinkPad X1](http://www.lenovo.com/mp/x1/index.html).

![A screenshot of my desktop](img/desktop.png "A screenshot of my desktop")

----------------------

Table of contents
----------------------

#### 1. :bulb: [Tweaks and tips to configure Ubuntu](TIPS.md)
#### 2. :loop: [A cheatsheet for some UNIX commands](COMMANDS.md)
#### 3. :nut_and_bolt: Various dotfiles (based on my needs) in [`dotfiles`](dotfiles/) : Bash, Emacs
#### 4. Various useful scripts in [`scripts`](scripts), you can use in your `$PS1` variable or with a keyboard shortcut
   * :tropical_fish: [`tunnel_ssh_make.sh`](tunnel_ssh_make.sh) : opens a SSH tunnel with a browser on it (pretty useful when you need to download files from various providers)
   * :vhs: [`notify_smart.sh`](scripts/notify_smart.sh) : small indicator with colors for SMART analysis on plugged drives
   * :shell: [`gnome-panel-reset.sh`](scripts/gnome-panel-reset.sh) : resets GNOME Panel and buggy `indicator-applet-complete`
   * :traffic_light: [`swap-memory-guard.sh`](scripts/swap-memory-guard.sh) : monitors RAM and swap to prevent memory exhaustion
   * :camera: [`move-latest-screenshot.sh`](scripts/move-latest-screenshot.sh) : moves latest screenshot to the desktop (due to buggy GNOME Screenshot)
   * :alarm_clock: [`time-zone-switch.sh`](scripts/time-zone-switch.sh) : switches time zone w.r.t. GeoIP


----------------------

See also
----------------------

* [Ubuntu Start Project, Launchpad](https://launchpad.net/ubuntustart)
* [What To Do After A Fresh Ubuntu Install Script For Ubuntu 10.04 Lucid Lynx, Web Upd8](http://www.webupd8.org/2010/04/what-to-do-after-fresh-ubuntu-install.html)
* [Things to do after installing Ubuntu 12.04 Precise Pangolin, How to Ubuntu](http://howtoubuntu.org/things-to-do-after-installing-ubuntu-12-04-precise-pangolin)

Disclaimer
----------------------
THE PROVIDER MAKES NO REPRESENTATIONS ABOUT THE SUITABILITY, USE, OR PERFORMANCE OF THESE TIPS OR ABOUT ANY CONTENT OR INFORMATION MADE ACCESSIBLE BY THESE, FOR ANY PURPOSE.

Hai Nguyen Van <nguyen-van@lri.fr>



