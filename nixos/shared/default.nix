{ inputs, lib, config, pkgs, specialArgs, ... }: {
    imports = [];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };

    programs.nix-ld.enable = true;
}
