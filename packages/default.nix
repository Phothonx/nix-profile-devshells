{ pkgs, lib, ... }:
let
  packages = [
    "jupython"
    "ocaml"
  ];
in
lib.genAttrs packages (package: import ./${package} {inherit pkgs;})
