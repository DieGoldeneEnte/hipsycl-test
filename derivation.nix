{
clangStdenv,
lib,
cudaSupport ? false, cudatoolkit,
hipsycl,
openmp
}:

clangStdenv.mkDerivation {
  name = "test";
  src = ./src;

  buildInputs = [
    hipsycl
    openmp
  ] ++ lib.optional cudaSupport [
    cudatoolkit
  ];

  nativeBuildInputs = [ hipsycl ];

  buildPhase = ''
    syclcc-clang --hipsycl-gpu-arch=sm_30 -o hipsycl_test test.cpp
  '';

  installPhase = ''
    mkdir -p $out
    mv hipsycl_test $out/
  '';
}
