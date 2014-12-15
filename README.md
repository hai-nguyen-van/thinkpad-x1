Enhancing Ubuntu 12.04 LTS on a ThinkPad X1 machine
==============

*Design* and *User Experience* (UX/UI) are topics that developers should never underestimate. In this way, customizing your favorite Linux distribution should give you a better work experience. Here are some tips I gathered and applied to [Ubuntu 12.04 LTS (Precise Pangolin)](http://releases.ubuntu.com/12.04/) on my [Lenovo ThinkPad X1](http://www.lenovo.com/mp/x1/index.html).

![Alt text](https://raw.githubusercontent.com/EmptyStackExn/enhancing-ubuntuprecise-thinkpadx1/master/images/desktop.png "A screenshot of my desktop")

----------------------


Encrypting your Hard Drive ([howtogeek.com](http://www.howtogeek.com/116032/how-to-encrypt-your-home-folder-after-installing-ubuntu/))
----------------------

Research centers and governmental agencies [recommend research data encryption](https://aresu.dsi.cnrs.fr/spip.php?rubrique99) to avoid sensitive information leakage. For this reason, [eCryptfs](http://ecryptfs.org/) made it easy and may not be greedy as the [Intel® Core™ i5-2520M Processor](http://ark.intel.com/fr/products/52229/Intel-Core-i5-2520M-Processor-3M-Cache-up-to-3_20-GHz) provides hardware [Intel® AES-NI](http://www.intel.com/content/www/us/en/architecture-and-technology/advanced-encryption-standard--aes-/data-protection-aes-general-technology.html?_ga=1.149398710.168035845.1418680010) support.

 1. Install required tools: `sudo apt-get install ecryptfs-utils cryptsetup`
 2. Create a temporary user with `Administrator` rights
 3. Log on it and run `sudo ecryptfs-migrate-home -u [user]`
 4. Encrypt the swap partition: `sudo ecryptfs-setup-swap`



Disclaimer
----------------------

THE PROVIDER MAKES NO REPRESENTATIONS ABOUT THE SUITABILITY, USE, OR PERFORMANCE OF THESE TIPS OR ABOUT ANY CONTENT OR INFORMATION MADE ACCESSIBLE BY THESE, FOR ANY PURPOSE.

Hai Nguyen Van <nguyen-van@lri.fr>


