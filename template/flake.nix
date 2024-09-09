{
  inputs = {
    # should be declared in USER registry with :
    # nix.registry.nixpkgs.flake = inputs.nixpkgs;
    nixpkgs.url = "nixpkgs";
    # this is not mandatory but it will ensure this version of nixpkgs is always present on your computer
    # by using the same as your system
    # ( eg: event if you are offline ) 
  };
  outputs = { self, nixpkgs, ... }:
  let
    lib = nixpkgs.lib;
    
    # Supported systems
    systems = [
      "x86_64-linux"
    ];

    # (pkgs -> attrsetValue) -> AttrsForEachSystems
    forEachSystem = f: lib.genAttrs systems (system: f (pkgsGen system) );
    # system -> pkgs
    pkgsGen = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
  in
  {
    # Packages used by the devshell that you can choose to install in your nix profile
    # to use them offline/prevent garbage collect
    packages = forEachSystem (pkgs: {
      # see https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/buildenv/default.nix
      default = pkgs.buildEnv {
        name = "devshell-packages";
        paths = with pkgs; [
          # Add your packages here
        ];
      };
    });

    # The devshells accessing these packages with the self argument
    devShells = forEachSystem (pkgs: {
      default = pkgs.mkShell {
        name = "devshell-name";
        buildInputs = [ self.outputs.packages.${pkgs.system}.default ];
        shellHook = ''
          # some shellhook
        '';
      };
    });
  };
}
