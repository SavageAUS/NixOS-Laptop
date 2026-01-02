{ config, pkgs, ... }:

{
    home.username = "shane";
    home.homeDirectory = "/home/shane";
    home.stateVersion = "25.11";
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
    };
    home.packages = with pkgs; [
        
        ];
    programs = {
        git = {
            enable = true;
            settings = {
                user.name = "Shane Scott";
                user.email = "shane.r.scott1981@gmail.com";
            };
        };
        kitty = {
            enable = true;
            settings = {
                background_opacity = 0.8;
                dynamic_background_opacity = true;
                };
        };
        bash = {
            enable = true;
            shellAliases = {
                btw = "echo i use nixos btw";
                };
        };
    };
}
