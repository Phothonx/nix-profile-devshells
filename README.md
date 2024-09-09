# nix profile devshells
> [!NOTE]
> *This flake is very opinionated and made for my personal use (maybe i'm just too dumb to use direnv)*\
> *Moreover i'm not very experienced with nix*

These devshells are made so they can also be referenced by profiles making them:
- 🛡️ **permanent** - to garbage-collect without relying on nix-direnv
- 💾 **offline** - always ready to use and without unexpected downloads

## Setup

<details>
  <summary><b>Flake registry</b></summary>
  
  Add the this flake to your system flake inputs
  
  ```
  inputs.nix-profile-devshells.url = "github:Phothonx/nix-profile-devshells";
  inputs.nix-profile-devshells.inputs.nixpkgs.follows = "nixpkgs";
  ```

  *You can also change the the nixpkgs it follows*

  Add the input to the registry
  
  ```
  nix.registry.dev.flake = inputs.nix-profile-devshells;
  ```

</details>

<details>
  <summary><b>Use the template</b></summary>
  
  Get the template
  
  ```nix flake init -t github:Phothonx/nix-profile-devshells```

  Make sure the nixpkgs from the registry is the same as your system config
  
  ```
  registry.nixpkgs.flake = inputs.nixpkgs;
  ```

  (or else the nixpkgs input will be garbage-collected from the store 🍃)\
  *You can also change the the nixpkgs registry to whichever you want from your inputs*
</details>


## Usage
*you can reference the flake anywhere using his registry name if you used the registry setup*

Install the devshell's packages in your profile if you want to preserve it\
```nix profile install .#devshell-name```

Use it like a normal devshell\
```nix develop .#devshell-name```
