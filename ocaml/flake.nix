{
  description = "A basic ocaml devshell";

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
        ocaml
        ocamlPackages.utop
      ];
      shellHook = ''
        echo "Ocaml devShell"
      '';
    };
  };
}
