{ nixpkgs ? import (
  (import <nixpkgs> {}).fetchgit {
    url = https://github.com/NixOS/nixpkgs.git;
    rev = "7a6e2837efee709964e731cecd3d36f8f2a2d28e";
    sha256 = "13s2yzr9n2qb8aziyc5xjxfh3f70g34nxlv495h6q69p0zzfdfw3";
  }) {}
}:
nixpkgs.haskellPackages.callPackage ./total-prelude.nix {}
