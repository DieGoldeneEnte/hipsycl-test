let

  nixos-rocm = import (builtins.fetchGit {
    name = "own-nixos-rocm-20220-01-07";
    url = https://github.com/DieGoldeneEnte/nixos-rocm/;
    ref = "hipsycl";
    rev = "f77a4d76cb5d433314f6c16e9d04e4b58f395bb9";
  });
  #nixos-rocm = import ../nixos-rocm;

  nixpkgs = import (builtins.fetchGit {
    name = "nixos-master-2020-01-07";
    url = https://github.com/nixos/nixpkgs/;
    ref = "master";
    rev = "8a6baaecb5b55021491eca4e3e5a5ab49ae6049f";
  }) {
    overlays = [ nixos-rocm ];
    config = {
        rocmTargets = [ "gfx803" ];
        allowUnfree = true;
    };
  };
in nixpkgs
