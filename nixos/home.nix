{ config, pkgs, ... }:

{
    home.username = "shane";
    home.homeDirectory = "/home/shane";
    home.stateVersion = "25.11";
    programs.home-manager.enable = true;
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
    };
    home.packages = with pkgs; [
    davinci-resolve
        
        ];
    programs.git = {
        enable = true;
        settings = {
            user.name = "Shane Scott";
            user.email = "shane.r.scott1981@gmail.com";
        };
    };
    programs.kitty = {
        enable = true;
        settings = {
            background_opacity = 0.8;
        };
    };
    programs.bash = {
        enable = true;
    };
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
        if status is-interactive
        fastfetch
        end
        '';
    };
}
