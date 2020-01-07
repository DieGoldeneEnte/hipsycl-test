{
clangStdenv,
hipsycl,
openmp,
rocm-opencl-icd
}:

clangStdenv.mkDerivation {
  name = "test";
  src = ./src;

  buildInputs = [
    hipsycl
    openmp
  ];

  nativeBuildInputs = [ hipsycl ];

  buildPhase = ''
    syclcc-clang --hipsycl-platform=cpu -o hipsycl_test_cpu test.cpp
    #syclcc-clang --hipsycl-platform=cuda --hipsycl-gpu-arch=sm_30 -o hipsycl_test_cuda test.cpp
    #syclcc-clang --hipsycl-platform=rocm --hipsycl-gpu-arch=gfx803 -o hipsycl_test_rocm test.cpp
  '';

  installPhase = ''
    mkdir -p $out
    mv hipsycl_test_* $out/
  '';
}
