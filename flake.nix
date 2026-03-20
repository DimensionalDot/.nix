{
  description = "A very basic flake";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake/beta";
            inputs.nixpkgs.follows = "nixpkgs";
        };
  };

  outputs = { nixpkgs, ... } @ inputs: {
        nixosConfigurations.giedi = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
                ./hardware/giedi.nix
                ({ inputs, ... }: {
                    environment.systemPackages = [
                        inputs.zen-browser.packages."x86_64-linux".beta
                    ];
                })
            ];
        };
  };
}
