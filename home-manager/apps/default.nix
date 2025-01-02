{ config, pkgs, specialArgs, ... }:
let
  inherit (specialArgs) hasUI;
in
{
  imports =
    let
      ui_imports = [];

    in
      [
	./nvim/nvim.nix
      ];
}
