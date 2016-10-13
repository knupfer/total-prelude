{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "total-prelude";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base ];
  homepage = "https://github.com/knupfer/total-prelude";
  description = "Replace partial functions with total functions in the standard prelude";
  license = stdenv.lib.licenses.mit;
}
