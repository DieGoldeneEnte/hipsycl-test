let
    nixpkgs = import (builtins.fetchGit {
        name = "nixos-unstable-2019-12-19";
        url = https://github.com/nixos/nixpkgs/;
        ref = "nixos-unstable";
        rev = "d942688fc137169b577e7bf0c09e01a2ac919b73";
    }) {};

    allPkgs = nixpkgs // pkgs;
    callPackage = path: overrides:
        let f = import path;
        in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);

    pkgs = with nixpkgs; rec {
        clang = nixpkgs.clang_9;
        llvm = nixpkgs.llvm_9;
        llvmPackages = nixpkgs.llvmPackages_9;
        openmp = llvmPackages_9.openmp;
        libclang = llvmPackages_9.libclang;
        clangStdenv = nixpkgs.overrideCC nixpkgs.clangStdenv clang;

        cudatoolkit = nixpkgs.cudaPackages.cudatoolkit_9;

        hipsycl = callPackage ./dependencies/hipSYCL.nix {};
    };
in
callPackage ./derivation.nix {}
