{ style, customUtils, ... }:
let multiline = customUtils.string.removeNewlines;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      line_break.disabled = false;
      add_newline = true;
      palette = "default";
      fill.symbol = " ";

      palettes.default = {
        # Basic colors
        bg = "#${style.background}";
        dark = "#${style.darker}";
        green = "#${style.success}";

        # Warnings
        user_root = "#${style.danger}";
        read_only = "#${style.danger}";

        # Module specific
        user = "#${style.primary}";
        dir = "#${style.secondary}";
        git = "#${style.success}";
        time = "#${style.secondary}";
        duration = "#${style.caution}";

        # Language specific
        rust = "#${style.danger}";

        # Character
        ch_success = "#${style.success}";
        ch_error = "#${style.danger}";
        ch_vim = "#${style.success}";
        ch_vros = "#${style.secondary}";
        ch_vrs = "#${style.secondary}";
        ch_vvs = "#${style.caution}";
      };

      format = multiline ''
        [╭](fg:bg)
        $username
        $directory

        $git_branch
        $git_status

        $rust

        $fill

        $cmd_duration
        $time

        $line_break

        [╰](fg:bg)
        $character
      '';

      username = {
        format = multiline ''
          [](fg:user)
          [](bg:user fg:dark)
          [](fg:user bg:bg)
          [ $user]($style)
          [](fg:bg)
        '';
        show_always = true;
        style_user = "bg:bg";
        style_root = "fg:user_root  bg:bg";
      };

      directory = {
        truncation_symbol = "..";
        read_only = "";
        home_symbol = "";

        style = "bg:bg";
        read_only_style = "bg:bg fg:read_only";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = multiline ''
          [─](fg:bg)
          [](fg:dir)
          [](bg:dir fg:dark)
          [](fg:dir bg:bg)
          [ $path]($style)
          [$read_only]($read_only_style)
          [](fg:bg)
        '';
        repo_root_format = multiline ''
          [─](fg:bg)
          [](fg:dir)
          [](bg:dir fg:dark)
          [](fg:dir bg:bg)
          [/$repo_root]($style)
          [$path]($style)
          [ $read_only]($read_only_style)
          [](fg:bg)
        '';
      };

      git_branch = {
        symbol = "";
        format = multiline ''
          [─](fg:bg)
          [](fg:git)
          [$symbol $branch(:$remote_branch)](fg:dark bg:git)
          [](fg:git bg:bg)
        '';
      };

      git_status = {
        conflicted = "🚨";
        ahead = "🏎";
        behind = "😰";
        diverged = "😵";
        up_to_date = "[ ✓](bold fg:green bg:bg)";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[ +$count](fg:green bg:bg)";
        renamed = "👅";
        deleted = "🗑";

        format = multiline ''
          [$conflicted$stashed$deleted$renamed$modified$typechanged$untracked$staged$ahead_behind](bg:bg)
          [](fg:bg)
        '';
      };

      cmd_duration = {
        show_notifications = true;
        format = multiline ''
          [](fg:duration)
          [󱐋](bold fg:dark bg:duration)
          [](fg:duration bg:bg)
          [ $duration](bg:bg)
          [─](fg:bg)
        '';
      };

      time = {
        disabled = false;
        format = multiline ''
          [](fg:time)
          [](fg:dark bg:time)
          [](fg:time bg:bg)
          [ $time](bg:bg)
          [ ](fg:bg)
        '';
      };

      character = {
        success_symbol = "[❯](bold fg:ch_success)";
        error_symbol = "[](bold fg:ch_error)";
        vimcmd_symbol = "[❮](bold fg:ch_vim)";
        vimcmd_replace_one_symbol = "[❮](bold fg:ch_vros)";
        vimcmd_replace_symbol = "[❮](bold fg:ch_vrs)";
        vimcmd_visual_symbol = "[❮](bold fg:ch_vvs)";
      };

    };
  };
}
