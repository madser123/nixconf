{ customUtils, ... }:
let multiline = customUtils.string.removeNewlines;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      line_break.disabled = false;
      add_newline = true;
      fill.symbol = " ";

      format = multiline ''
        [╭](fg:overlay0)
        $username
        $directory

        $git_branch
        $git_status

        $rust

        $fill

        $cmd_duration
        $time

        $line_break

        [╰](fg:overlay0)
        $character
      '';

      username = {
        format = multiline ''
          [](fg:peach)
          [](bg:peach fg:crust)
          [](fg:peach bg:overlay0)
          [ $user]($style)
          [](fg:overlay0)
        '';
        show_always = true;
        style_user = "bg:overlay0";
        style_root = "fg:red  bg:overlay0";
      };

      directory = {
        truncation_symbol = "..";
        read_only = "";
        home_symbol = "";

        style = "bg:overlay0";
        read_only_style = "bg:overlay0 fg:red";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = multiline ''
          [─](fg:overlay0)
          [](fg:mauve)
          [](bg:mauve fg:crust)
          [](fg:mauve bg:overlay0)
          [ $path]($style)
          [ $read_only]($read_only_style)
          [](fg:overlay0)
        '';
        repo_root_format = multiline ''
          [─](fg:overlay0)
          [](fg:mauve)
          [](bg:mauve fg:crust)
          [](fg:mauve bg:overlay0)
          [/$repo_root]($style)
          [ $path]($style)
          [ $read_only]($read_only_style)
          [](fg:overlay0)
        '';
      };

      git_branch = {
        symbol = "";
        format = multiline ''
          [─](fg:overlay0)
          [](fg:green)
          [$symbol $branch(:$remote_branch)](fg:crust bg:green)
          [](fg:green bg:overlay0)
        '';
      };

      git_status = {
        conflicted = " 🚨";
        ahead = " 🏎";
        behind = " 😰";
        diverged = " 😵";
        up_to_date = "[ ✓](bold fg:green bg:overlay0)";
        untracked = " 🤷";
        stashed = " 📦";
        modified = " 📝";
        staged = "[ +$count](fg:green bg:overlay0)";
        renamed = " 👅";
        deleted = " 🗑";

        format = multiline ''
          [$conflicted$stashed$deleted$renamed$modified$typechanged$untracked$staged$ahead_behind](bg:overlay0)
          [](fg:overlay0)
        '';
      };

      cmd_duration = {
        show_notifications = true;
        format = multiline ''
          [](fg:yellow)
          [󱐋](bold fg:crust bg:yellow)
          [](fg:yellow bg:overlay0)
          [ $duration](bg:overlay0)
          [─](fg:overlay0)
        '';
      };

      time = {
        disabled = false;
        format = multiline ''
          [](fg:sapphire)
          [](fg:crust bg:sapphire)
          [](fg:sapphire bg:overlay0)
          [ $time](bg:overlay0)
          [ ](fg:overlay0)
        '';
      };

      character = {
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:yellow)";
        vimcmd_replace_symbol = "[❮](bold fg:yellow)";
        vimcmd_visual_symbol = "[❮](bold fg:mauve)";
      };

    };
  };
}
