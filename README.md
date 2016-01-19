# Nightly libcollections

[![Build Status](https://travis-ci.org/phil-opp/nightly-libcollections.svg?branch=master)](https://travis-ci.org/phil-opp/nightly-libcollections)

Rust's [collections library](https://doc.rust-lang.org/collections/) as a cargo crate. Updated daily using [nightli.es](https://nightli.es).

_Note_: You need to [cross compile libcore](https://github.com/phil-opp/nightly-libcore) before. This works only for targets with `"no-compiler-rt": true`.

## Quick Installation
To install a cross-compiled `libcollections` and its dependencies (`liballoc` and `librustc_unicode`), download the installation script:

```
wget -q https://raw.githubusercontent.com/phil-opp/nightly-libcollections/master/install-libcollections.sh
```
The script should work for multirust and for standard rust installations (but I only tested multirust). Use at your own risk!

To install `liballoc`, `librustc_unicode`, and `libcollections` for target `your-target-name`, run:

```
sh install-libcollections.sh your-target-name
```
Note that `your-target-name`, `your-target-name.json`, and `./your-target-name` are different targets to Rust.

After a successful installation the script deletes itself.

## Manual Installation
Copy your `your-target-name.json` file into the cloned folder and run:

```
cargo build --release --target=your-target-name
```

Then put the resulting `target/your-target-name/release/libcollections.rlib` in your Rust lib folder. For multirust, that folder is:

```
~/.multirust/toolchains/nightly/lib/rustlib/your-target-name/lib
```

You also need to install the dependencies of `libcollections`: [liballoc](https://github.com/phil-opp/nightly-liballoc) and [librustc](https://github.com/phil-opp/nightly-librustc_unicode) 

## Uninstall
To “unistall”, just remove the `libcollections.rlib`. For multirust, it is in

```
~/.multirust/toolchains/nightly/lib/rustlib/your-target-name/lib
```
