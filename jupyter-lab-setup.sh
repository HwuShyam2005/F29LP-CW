#!/bin/bash

CONFIG_FILE="${HOME}/.config/jupyter-config-done"
mkdir -p ${HOME}/.config

if ! [ -f  ${CONFIG_FILE} ]
then 
        echo "Running jupyter setup script for the first time. Please be patient..."

	echo '#use "topfind";;' >> ~/.ocamlinit

	echo 'Topfind.log:=ignore;;' >> ~/.ocamlinit

	yes "1" | opam init

	eval `opam env --switch=default`

	yes "y" | opam install ocamlbuild merlin utop user-setup ocamlfind ounit dune qcheck jupyter

	/home/$USER/.opam/default/bin/ocaml-jupyter-opam-genspec

	/opt/anaconda3/bin/jupyter kernelspec install --user --name "ocaml-jupyter-$(opam var switch)" /home/$USER/.opam/default/share/jupyter
	
	touch ${CONFIG_FILE}
else
	echo "Jupyter already set up."
fi

echo "Starting..."

export OPAM_SWITCH_PREFIX='/home/$USER/.opam/default'

export LD_LIBRARY_PATH='/home/$USER/.opam/default/lib/stublibs:/usr/local/share/opam/default/lib/jupyter:/usr/local/share/opam/default/lib/stublibs'

export CAML_LD_LIBRARY_PATH='/home/$USER/.opam/default/lib:/usr/local/share/opam/default/lib/stublibs:/usr/local/share/opam/default/lib:/usr/lib/ocaml'

export OPAMCLI=2.3.0

jupyter notebook
