Cheat sheet for some useful commands
----------------------

  * Report a bug on a specific process with `ubuntu-bug [process id]`
  * Compile a list of locale definition files `sudo locale-gen --purge`
  * Add [authentication key](https://help.ubuntu.com/community/Repositories/Ubuntu#Authentication_Tab) for package signatures: `sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys [key hash]`
  * Fetch public keys from MIT PGP Key Server : `gpg --keyserver pgp.mit.edu --recv-keys [key hash]`
  * Switch OCaml compiler version : `opam switch [version]`
