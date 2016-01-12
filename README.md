# Nightly libcollections

[![Build Status](https://travis-ci.org/phil-opp/nightly-libcollections.svg?branch=master)](https://travis-ci.org/phil-opp/nightly-libcollections)

Rust's [collections library](https://doc.rust-lang.org/collections/) as a cargo crate. Updated daily using [nightli.es](https://nightli.es).

## Cross compiling
_Note_: You need to [cross compile libcore](https://github.com/phil-opp/nightly-libcore) and [liballoc](https://github.com/phil-opp/nightly-liballoc) before. This works only for targets with `"no-compiler-rt": true`.

Copy your `your-target-name.json` file into the cloned folder and run:

```
cargo build --release --target=your-target-name
```

Then put the resulting `target/your-target-name/release/libcollections.rlib` in your Rust lib folder. For multirust, that folder is:

```
~/.multirust/toolchains/nightly/lib/rustlib/your-target-name/lib
```

Now it should be possible to compile `no_std` crates for `your-target-name`. Note that `./your-target-name` and `your-target-name` are different targets to Rust.
