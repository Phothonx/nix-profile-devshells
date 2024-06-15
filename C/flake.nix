{
  description = "A basic C devshell";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        libgcc
        gdb
      ];
      shellHook = ''
        echo "C devShell"
      '';
    };
  };
}
