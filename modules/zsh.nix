{ config, lib, pkgs, ... }:

{
  options.modules.zsh.enable = lib.mkEnableOption "Enable modular Zsh configuration";

  config = lib.mkIf config.modules.zsh.enable {
    home.packages = with pkgs; [
        fzf
        zsh
        zsh-autosuggestions
        zsh-powerlevel10k
        zsh-syntax-highlighting
        zsh-you-should-use
    ];

    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        plugins = [
            {
                name = "powerlevel10k";
                src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
                file = "powerlevel10k.zsh-theme";
            }
            {
                name = "you-should-use";
                src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
            }
        ];
        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
                "podman"
                "ssh-agent"
                "zsh-interactive-cd"
            ];
        };
        initContent = ''
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '';
    };

    home.file.".p10k.zsh".source = ../dotfiles/.p10k.zsh;
  };
}
