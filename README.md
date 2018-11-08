D language bindings to libgit2
==============================

These are static bindings to the [libgit2](https://github.com/libgit2/libgit2) library. It directly exposes the C interface. For a higher level library with an idiomatic D interface, see [dlibgit](https://github.com/s-ludwig/dlibgit).

Use the static-library configuration of this package to build and statically link against matching
versions of libgit2.a and it's dependencies.
Use the static-library-networking configuration if you want to use networking functionality of libgit2 (e.g. cloning repositories). It will link against the system's default openssl library.
