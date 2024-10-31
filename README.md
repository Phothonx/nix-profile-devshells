# nix devshells
> [!NOTE]
> *This flake is opinionated and made for my personal use*
> *Moreover i'm not very experienced with nix*

> [!IMPORTANT]
> I import nixpkgs in every flake to allow unfree pkgs. (to change) I need to avoid 1000 instances of nixpkgs ;)

## Setup

<details>
  <summary><b>Flake registry</b></summary>
  
  Add the this flake to your system flake inputs
  
  ```
  inputs.nix-devshells.url = "github:Phothonx/nix-devshells";
  inputs.nix-devshells.inputs.nixpkgs.follows = "nixpkgs";
  ```

  *You can also change the the nixpkgs it follows*

  Add the input to the registry to use easily
  
  ```
  nix.registry.dev.flake = inputs.nix-devshells;
  ```

</details>

<details>
  <summary><b>Use a template</b></summary>
  
  Get the template
  
  ```nix flake init -t dev#[TEMPLATE]```

  Make sure the nixpkgs from the registry is the same as your system config by putting this in your config
  
  ```
  registry.nixpkgs.flake = inputs.nixpkgs;
  ```

  (or else the nixpkgs input could be garbage-collected from the store 🍃)\
  *You can also change the the nixpkgs registry to whichever you want from your inputs*
</details>


## Usage

Add it to a profilewith ```--profile .``` to make it gc proof
Then it'll create a local profile symlink, to delete when you want

```nix develop .#devshell-name --profile . -c fish```
