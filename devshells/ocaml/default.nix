{ self, pkgs, ... }:
pkgs.mkShell {
  buildInputs = [ self.outputs.packages.${pkgs.system}.ocaml ];
}
