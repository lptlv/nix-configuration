{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nixpkgs pins

    # Other inputs
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nid = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nsops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    mango = {
      url="github:ernestocruz05/mango-ext/1to1-gest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    ngreeter.url = "github:noctalia-dev/noctalia-greeter";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    msnap = {
      url = "github:atheeq-rhxn/msnap";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nid,
      hjem,
      nsops,
      nix-cachyos-kernel,
      mango,
      noctalia,
      ngreeter,
      spicetify-nix,
      ...
    }:
      {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	  specialArgs = {
            inherit inputs;
        };
	  modules = [
	    ./configuration.nix
	    # User Interface
            mango.nixosModules.mango
	    noctalia.nixosModules.default
	    ngreeter.nixosModules.default

	    # Programs
	    spicetify-nix.nixosModules.spicetify

	    # Nixos utils
	    nid.nixosModules.default
	    hjem.nixosModules.default
	    nsops.nixosModules.sops

            ({ ... }: {
	            config = {
                nixpkgs.overlays = [ nix-cachyos-kernel.overlays.default ];
                nix.settings = {
                  trusted-public-keys = [
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                    "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                    /*"lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="*/
		    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
                  ];
                  substituters = [
                    "https://cache.nixos.org"
                    "https://nixpkgs-wayland.cachix.org"
                    /*"https://attic.xuyh0120.win/lantian"*/
		    "https://noctalia.cachix.org"
                  ];
                };
	      };
            })
          ];
        };
      };
}
