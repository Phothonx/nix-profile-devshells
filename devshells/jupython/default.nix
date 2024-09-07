{ self, pkgs, ... }:
pkgs.mkShell {
  buildInputs = [ self.outputs.packages.${pkgs.system}.jupython ];
  shellHook = ''
    jupyter notebook &
  '';
}
