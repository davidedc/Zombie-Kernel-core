if [ ! -d ../../Zombie-Kernel ]; then
  echo
  echo ----------- error -------------
  echo You miss the overarching Zombie-Kernel directory.
  echo Please check the helper script that sorts this out
  echo for you, and the docs for
  echo what the directory structure for
  echo building Zombie-Kernel should be, here:
  echo '\t'http://
  echo
  exit
fi

if [ ! -d ../Zombie-Kernel-builds ]; then
  echo
  echo ----------- warning! -------------
  echo You miss the destination Zombie-Kernel-builds directory.
  echo I\'ll create one for you, but ideally you should have
  echo checked-out such directory from
  echo '\t'http://
  echo For more info please check the "how to build" docs in here:
  echo '\t'http://
  echo
  mkdir ../Zombie-Kernel-builds
fi

if [ ! -d ../Zombie-Kernel-builds/latest ]; then
  mkdir ../Zombie-Kernel-builds/latest
fi

# cleanup the contents of the build directory
rm -rf ../Zombie-Kernel-builds/latest/*

if [ ! -d ../Zombie-Kernel-builds/latest/js ]; then
  mkdir ../Zombie-Kernel-builds/latest/js
fi

if [ ! -d ../Zombie-Kernel-builds/latest/icons ]; then
  mkdir ../Zombie-Kernel-builds/latest/icons
fi

if [ ! -d ../Zombie-Kernel-builds/latest/js/libs ]; then
  mkdir ../Zombie-Kernel-builds/latest/js/libs
fi

if [ ! -d ../Zombie-Kernel-builds/latest/js/sourceCode ]; then
  mkdir ../Zombie-Kernel-builds/latest/js/sourceCode
fi

if [ ! -d ../Zombie-Kernel-builds/latest/delete_me ]; then
  mkdir ../Zombie-Kernel-builds/latest/delete_me
fi

# copy the test files
mkdir ../Zombie-Kernel-builds/latest/js/tests/


# generate the zombie-kernel coffee file in the delete_me directory
# note that this file won't contain much code.
# All the code of the morphs is put in other .coffee files
# which just contain the coffeescript source as the text!
python ./buildSystem/build.py

# turn the coffeescript file into js in the js directory
coffee -b -c -o ../Zombie-Kernel-builds/latest/js/ ../Zombie-Kernel-builds/latest/delete_me/zombie-kernel.coffee 

# compile all the files containing the coffeescript source for the morphs.
# this creates javascript files which contain the original coffeescript source as text.
coffee -b -c -o ../Zombie-Kernel-builds/latest/js/sourceCode/ ../Zombie-Kernel-builds/latest/js/sourceCode/

if [ "$?" != "0" ]; then
    tput bel;
    echo "!!!!!!!!!!! error: coffeescript compilation failed!" 1>&2
    exit 1
fi

# copy the html files
cp src/index.html ../Zombie-Kernel-builds/latest/

# copy the interesting js files from the submodules
cp auxiliary\ files/FileSaver\ submodule/FileSaver.js ../Zombie-Kernel-builds/latest/js/libs/
cp auxiliary\ files/JSZip\ submodule/dist/jszip.min.js ../Zombie-Kernel-builds/latest/js/libs/
cp auxiliary\ files/CoffeeScript\ submodule/coffee-script.js ../Zombie-Kernel-builds/latest/js/libs/

# copy aux icon files
cp auxiliary\ files/additional-icons/*.png ../Zombie-Kernel-builds/latest/icons/

# the tests files are copied from a directory
# structure so it's cleaner, but they
# are copied recursively ignoring the directory
# structure they come from, so a simple cp
# doesn't cut it, we need the find below
mkdir ../Zombie-Kernel-builds/latest/js/tests/assets
cp -r ../Zombie-Kernel-tests/tests/* ../Zombie-Kernel-builds/latest/js/tests/assets
find ../Zombie-Kernel-builds/latest/js/tests -iname '*[!0123456789][!0123456789][!0123456789][!0123456789][!0123456789][!0123456789][!0123456789].js' -exec mv \{\} ../Zombie-Kernel-builds/latest/js/tests \;

rm -rdf ../Zombie-Kernel-builds/latest/delete_me

say -v Bells "e"