{ self, pkgs, lib, ... }:
let
  devshells = [
    "jupython"
    "ocaml"
  ];
in
lib.genAttrs devshells (devshell: import ./${devshell} {inherit self pkgs;})
