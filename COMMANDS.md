Cheat sheet for some useful commands
----------------------

  * Report a bug on a specific process: `ubuntu-bug [process id]`
  * Compile a list of locale definition files: `sudo locale-gen --purge`
  * Add [authentication key](https://help.ubuntu.com/community/Repositories/Ubuntu#Authentication_Tab) for package signatures: `sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys [key hash]`
  * Fetch public keys from MIT PGP Key Server: `gpg --keyserver pgp.mit.edu --recv-keys [key hash]`
  * Switch OCaml compiler version: `opam switch [version]`
  * Force and set resolution fol *old* screen monitors:

		xrandr --newmode $(gtf 1600 1200 60 | sed -ne 's/"//g;s/ Modeline //p')
		xrandr --addmode DP1 1600x1200_60.00
		xrandr --output DP1 --mode 1600x1200_60.00

  * 
