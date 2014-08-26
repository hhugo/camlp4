case "$OPAM_VERSION" in
1.1.*) ppa=avsm/ocaml41+opam11 ;;
*) echo Unknown $OPAM_VERSION; exit 1 ;;
esac

echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq opam

export OPAMYES=1
export OPAMVERBOSE=1
echo OPAM versions
opam --version
opam --git-version

opam init --comp=$OCAML_VERSION >/dev/null 2>&1
opam install ocamlfind
eval `opam config env`

echo Testing bytecode only installation
./configure && make && make install
make clean
echo Testing native code installation
./configure && make && make native && make install
