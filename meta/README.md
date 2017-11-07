pkgforge-helper
==========

[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Helper repo for building packages with [pkgforge](https://github.com/akerl/pkgforge)

## Usage

The easiest way is to submodule this into your package and then symlink the Makefile to the root:

```
git submodule add git://github.com/amylum/pkgforge-helper
ln -s pkgforge-helper/Makefile ./
```

Then you'd run `make` to build your thing using [dock0/pkgforge](https://github.com/dock0/pkgforge), or `make manual` to open a bash shell in the container.

In theory you could also pull down the Makefile and just vendor it in as well, if you hate submodules.

## License

pkgforge-helper is released under the MIT License. See the bundled LICENSE file for details.

