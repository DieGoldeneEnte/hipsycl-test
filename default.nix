let

  pkgs = import ./nixpkgs.nix;
in
  pkgs.callPackage ./derivation.nix {
    openmp = pkgs.llvmPackages_9.openmp;
  }
