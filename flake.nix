{
  description = "My personal deshells";

  inputs = {
    # should be declared in USER registry with the nixos option:
    # nix.registry.nixpkgs.flake = inputs.nixpkgs;
    nixpkgs.url = "nixpkgs";
    # this is not mandatory but it will ensure this version of nixpkgs is always present on your computer
    # by using the same as your system
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "x86_64-linux"
    ];

    lib = nixpkgs.lib;

    # system -> pkgs
    pkgsGen = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    # (pkgs -> attrsetValue) -> AttrsForEachSystems
    forEachSystem = f: lib.genAttrs systems (system: f (pkgsGen system));
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    templates = {
      python = {
        path = ./python;
        description = "Basic python devshell";
      };

      scipython = {
        path = ./scipython;
        description = "Python devshell for science";
      };

      jupython = {
        path = ./jupython;
        description = "Same as scipython but with jupyter";
      };

      ocaml = {
        path = ./ocaml;
        description = "Basic ocaml devshell";
      };

      C = {
        path = ./C;
        description = "Basic C devshell";
      };
    };
  };
}
