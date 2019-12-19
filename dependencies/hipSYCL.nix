{
clangStdenv,
fetchgit,
cmake,
clang,
llvm,
cudatoolkit,
python3,
boost,
openmp
}:

clangStdenv.mkDerivation rec {
  pname = "hypSYCL";
  version = "0.8.0-rc1";

  src = fetchgit {
    url = "https://github.com/illuhad/hipSYCL";
    rev = "v${version}";
    sha256 = "1z5zvry3wl55a59s5gzq1qppayqsk49y09q68yf51g47ldzkgrqv";
    fetchSubmodules = true;
  };

  cmakeFlags = [
    "-DCLANG_INCLUDE_PATH=${clang}/resource-root/include"
  ];
  enableParallelBuilding = false;

  buildInputs = [ cmake clang llvm openmp cudatoolkit python3 boost ];


  postPatch = ''
    patchShebangs /build/hipSYCL/bin/syclcc-clang
  '';
}
