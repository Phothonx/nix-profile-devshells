{ pkgs, ... }:
pkgs.buildEnv {
  name = "ocaml";
  paths = with pkgs; [
    ocaml
    ocamlPackages.utop
  ];
}
