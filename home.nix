{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
  ];
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "apaz074";
  home.homeDirectory = "/home/apaz074";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ 
    nerd-fonts.jetbrains-mono
    devbox
  ];

  fonts.fontconfig.enable = true;

  modules.zsh.enable = true;

  services.podman = {
    enable = true;
    settings.registries.search = [ "docker.io" "ghcr.io" "quay.io" "registry.redhat.io" ];
  };

  programs.git = {
    enable = true;
    userName = "Arnoldo Paz Medrano";
    userEmail = "apaz074@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/apaz074/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
