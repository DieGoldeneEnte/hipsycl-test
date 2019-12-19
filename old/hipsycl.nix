{
stdenv,
fetchgit,
cmake,
bash,
llvmPackages_latest,
cudatoolkit,
python3,
boost,
}:

stdenv.mkDerivation rec {
  pname = "hipsycl";
#  version = "0.8.0-rc1";
  version = "0.8.0";
  src = fetchgit {
    url = "https://github.com/illuhad/hipSYCL";
    rev = "v${version}";
#    sha256 = "1b9fbwkvya4a4d7ci27lys9pnqpvh7xdb5srs7lchbdykpfaj4xq";
    sha256 = "1bd2ah63z1d461a96wx72pga2srq7lgh1xxly8yshfy7p3qipq7d";
    deepClone = true;
  };

  LLVM_DIR = "${llvmPackages_latest.llvm}";
  cmakeFlags = [
    "-DCLANG_INCLUDE_PATH=${llvmPackages_latest.clang-unwrapped}/include/"
  ];

  buildInputs = [ cmake bash llvmPackages_latest.clang cudatoolkit python3 boost];

  postPatch = ''
    patchShebangs /build/hipSYCL/bin/syclcc-clang
  '';
}
