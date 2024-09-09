{
  inputs = {
    # should be declared in USER registry with :
    # nix.registry.nixpkgs.flake = inputs.nixpkgs;
    nixpkgs.url = "nixpkgs";
    # this is not mandatory but it will ensure this version of nixpkgs is always present on your computer
    # (by using the same as your system)
    # ( eg: event if you are offline ) 
  };
  outputs = { self, nixpkgs, ... }:
  let
    lib = nixpkgs.lib;
    
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
    # Packages used by devshells that you can choose to install in your nix profile
    # to use them offline/prevent garbage collect
    packages = forEachSystem (pkgs: import ./packages { inherit pkgs lib; });
    # The devshells accessing these packages with the self argument
    devShells = forEachSystem (pkgs: import ./devshells { inherit self pkgs lib; });

    templates.default = {
      path = ./template;
    };
  };
}
