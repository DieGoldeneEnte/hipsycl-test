{
clangStdenv,
lib, fetchgit,
cmake,
clang,
llvm,
cudaSupport ? false, cudatoolkit,
python3,
boost,
openmp,
clangInclude
}:

clangStdenv.mkDerivation rec {
  pname = "hypSYCL";
  version = "0.8.0";

  src = fetchgit {
#    url = "https://github.com/illuhad/hipSYCL";
#    rev = "v${version}";
    url = "https://github.com/DieGoldeneEnte/hipSYCL";
    rev = "5d0ba2c401e35469dd0b73b7f200e1ea75bab300";
    sha256 = "0k9fgcyabcrj97imjl36l374zy87ck013z7iflwlw4c5czksgadj";
    fetchSubmodules = true;
  };

#  src = ../hipSYCL;

  cmakeFlags = [
    "-DCLANG_INCLUDE_PATH=${clangInclude}/include"
  ] ++ lib.optional cudaSupport "-DCUDA:TOOLKIT_ROOT_DIR=${cudatoolkit}";


  enableParallelBuilding = true;
  dontStrip = true;

  buildInputs = [
    cmake
    clang
    llvm
    openmp
    python3
    boost
  ] ++ lib.optional cudaSupport cudatoolkit;


  postPatch = ''
    patchShebangs /build
  '';
}
