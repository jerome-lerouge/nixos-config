{ config, pkgs, ...}:

{ 
  home.packages = with pkgs; [
    fish
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      "lla" = "eza -lah --no-quotes --time-style long-iso";
    };
 };
}
