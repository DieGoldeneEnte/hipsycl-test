let

  pkgs = import ./nixpkgs.nix;

  amd-hipsycl-test = pkgs.callPackage ./derivation.nix {
    hipsycl = pkgs.amd-hipsycl;
    openmp = pkgs.llvmPackages_9.openmp;
  };
  hipsycl-test = pkgs.callPackage ./derivation.nix {
    hipsycl = pkgs.hipsycl;
    openmp = pkgs.llvmPackages_9.openmp;
  };
in
  [
    #amd-hipsycl-test
    hipsycl-test
  ]
