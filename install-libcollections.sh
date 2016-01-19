#!/bin/sh
# Exit if anything fails
set -e
DIR=$( pwd )

usage="Usage: sh $0 your-target-name"

if [[ "$#" -ne 1 ]]; then
echo $usage >&2
exit 1
fi

if [[ "$1" == "-h" || "$1" == "help" || "$1" == "-help" || "$1" == "--help" ]]; then
echo $usage >&2
exit 0
fi

target="$1"

extension="${target##*.}"
if [[ extension == "json" ]]; then
  targetWithExtension="$target"
else
  targetWithExtension="$target.json"
fi

if multirust which rustc > /dev/null; then
  rustcDir=$( multirust which rustc )
elif which rustc > /dev/null; then
  rustcDir=$( which rustc )
else
  echo "Could not detect rust installation!" >&2
  exit 1
fi

libraries=$( echo "$rustcDir" | sed s,"bin/rustc","lib/rustlib/$target/lib", )

echo "Installing for $target to"
echo "$libraries"
echo ""

git clone --depth 1 https://github.com/phil-opp/nightly-liballoc.git
if [ -f "$targetWithExtension" ]; then
  cp "$targetWithExtension" "nightly-liballoc/$targetWithExtension"
fi
cd nightly-liballoc
echo ""
if cargo build --release --target=$target --verbose; then
  echo ""
  mkdir -p "$libraries"
  cp "target/$target/release/liballoc.rlib" "$libraries/"
  cd ..
  rm -rf nightly-liballoc
else
  echo "Cargo build failed!" >&2
  cd ..
  rm -rf nightly-liballoc
  exit 1
fi

git clone --depth 1 https://github.com/phil-opp/nightly-librustc_unicode.git
if [ -f "$targetWithExtension" ]; then
  cp "$targetWithExtension" "nightly-librustc_unicode/$targetWithExtension"
fi
cd nightly-librustc_unicode
echo ""
if cargo build --release --target=$target --verbose; then
  echo ""
  mkdir -p "$libraries"
  cp "target/$target/release/librustc_unicode.rlib" "$libraries/"
  cd ..
  rm -rf nightly-librustc_unicode
else
  echo "Cargo build failed!" >&2
  cd ..
  rm -rf nightly-librustc_unicode
  exit 1
fi

git clone --depth 1 https://github.com/phil-opp/nightly-libcollections.git
if [ -f "$targetWithExtension" ]; then
  cp "$targetWithExtension" "nightly-libcollections/$targetWithExtension"
fi
cd nightly-libcollections
echo ""
if cargo build --release --target=$target --verbose; then
  echo ""
  mkdir -p "$libraries"
  cp "target/$target/release/libcollections.rlib" "$libraries/"
  cd ..
  rm -rf nightly-libcollections
  echo "done, removing the installation script"
  rm "$0"
else
  echo "Cargo build failed!" >&2
  cd ..
  rm -rf nightly-libcollections
  exit 1
fi
