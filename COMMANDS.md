Cheat sheet for some useful *NIX commands
====================

  * **Safely** reboot your machine when the system/GUI does not respond with the [magic SysRq key](http://web.archive.org/web/20070527215139/http://www.ibm.com/developerworks/linux/library/l-magic.html)

		ALT + PrintScreen + [R - E - I - S - U - B]

  * Change desktop cursor

		sudo update-alternatives --config x-cursor-theme
		dconf-editor # change variable cursor-theme in org.gnome.desktop.interface 

  * Scroll up/down a Terminal

		SHIFT + PageUp/PageDown

  * Update the icons cache (where `ICON_THEME` is the icon theme for which you installed the new icon)

		sudo gtk-update-icon-cache -f /usr/share/icons/[ICON_THEME]

  * Record desktop screencasts into GIF (`ppa:fossfreedom/byzanz`)

		byzanz-record --duration=15 --x=200 --y=300 --width=700 --height=400 out.gif

  * Report a bug on a specific process

		ubuntu-bug [process id]

  * Decrypt a OpenPGP file

		gpg --output [output file] --decrypt [input file].pgp

  * Add [authentication key](https://help.ubuntu.com/community/Repositories/Ubuntu#Authentication_Tab) for package signatures

		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys [key hash]

  * Fetch public keys from MIT PGP Key Server

		gpg --keyserver pgp.mit.edu --recv-keys [key hash]

  * Switch OCaml compiler version

		opam switch [version]

  * Force and set resolution for *old* screen monitors:

		xrandr --newmode $(gtf 1600 1200 60 | sed -ne 's/"//g;s/ Modeline //p')
		xrandr --addmode DP1 1600x1200_60.00
		xrandr --output DP1 --mode 1600x1200_60.00

  * Git global setup

		git config --global user.name "Hai Nguyen Van"
		git config --global user.email "hai.nguyen-van@lri.fr"


  * Multi-lingual speech synthesizer

		espeak -v french "Salut"

  * Compile a list of locale definition files

		sudo locale-gen --purge

  * Watch for incoming connections on a certain port (refresh every 1 sec)

		watch -d -n 1 "netstat -an | grep :8080"

  * Search the manual page names and descriptions

		apropos [keyword]

  * Trace system calls and signals

		strace

  * Trace disk space hogs
  
		ncdu
		

Some interesting external links
-----------------------

  * [_Give me that one command you wish you knew years ago. I'll start._](http://www.reddit.com/r/linux/comments/mi80x/give_me_that_one_command_you_wish_you_knew_years/), Reddit
