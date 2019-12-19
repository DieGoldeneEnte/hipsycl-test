  { stdenv, hipsycl }:

stdenv.mkDerivation {
    name = "test";
    src = ./.;

    buildInputs = [ hipsycl ];

    buildPhase = "echo $PWD";

    installPhase = ''
        mkdir -p $out
        touch $out/test
    '';
}
