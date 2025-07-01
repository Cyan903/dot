import "colors" as colors;

export let data = #{
    for_vcs: LOCAL,

    linux: SYSTEM.hostname == "hwk",
    wayland: io::path_is_file(".wayland"),

    colors: colors::dracula,
};

export let eggs = #{
    //
    // ~/.local/bin/*
    //
    scripts: #{
        targets: "~/.local/bin",
        strategy: "merge",
        enabled: data.linux,
    },

    "scripts-xorg": #{
        targets: "~/.local/bin",
        strategy: "merge",
        enabled: data.linux && !data.wayland,
    },

    "scripts-wayland": #{
        targets: "~/.local/bin",
        strategy: "merge",
        templates: ["swaylock-wrapper"],
        enabled: data.linux && data.wayland,
    },

    //
    // ~/.local/bin/share/*
    //
    osuconfig: #{
        targets: "~/.local/share/osuconfig",
        strategy: "merge",
        enabled: data.linux && io::command_available("osu-wine"),
    },

    "anki-plugins": #{
        targets: "~/.local/share/Anki2/addons21",
        strategy: "merge",
        enabled: io::command_available("anki"),
    },

    //
    // ~/.config/*
    //
    X11: #{
        targets: "~/.config/X11",
        enabled: data.linux && !data.wayland,
    },

    alacritty: #{
        targets: "~/.config/alacritty",
        templates: ["theme.toml"],
        enabled: io::command_available("alacritty"),
    },

    awesome: #{
        targets: "~/.config/awesome",
        templates: ["theme/main/theme.lua", "module/system/bin/lock"],
        enabled: data.linux && !data.wayland && io::command_available("awesome"),
    },

    bash: #{
        targets: #{
            ".bashrc": "~/.bashrc",
            ".bash_profile": "~/.bash_profile",
        },

        enabled: data.linux && io::command_available("bash"),
    },

    fbterm: #{
        targets: "~/.config/fbterm",
        enabled: data.linux && io::command_available("fbterm"),
    },

    firefox: #{
        targets: "~/.config/firefox",
        templates: ["userHome.html"],
        enabled: io::command_available("firefox"),
    },

    ideavim: #{
        targets: "~/.config/ideavim",
        enabled: io::command_available("android-studio") || io::command_available("idea"),
    },

    niri: #{
        targets: "~/.config/niri",
        templates: ["config.kdl"],
        enabled: data.wayland && io::command_available("niri"),
    },

    nvim: #{
        targets: "~/.config/nvim",
        templates: ["lua/addons/plugins/lualine.lua"],
        enabled: io::command_available("nvim"),
    },

    rofi: #{
        targets: "~/.config/rofi",
        templates: ["config.rasi"],
        enabled: data.linux && io::command_available("rofi"),
    },

    screenlayout: #{
        targets: "~/.config/screenlayout",
        enabled: data.linux && !data.wayland,
    },

    sesh: #{
        targets: "~/.config/sesh",
        enabled: io::command_available("sesh") && io::command_available("tmux"),
    },

    shell: #{
        targets: "~/.config/shell",
        templates: ["script/login"],
        enabled: data.linux && (
            io::command_available("bash") ||
            io::command_available("zsh")
        ),
    },

    tmux: #{
        targets: "~/.config/tmux",
        templates: ["tmux.conf"],
        enabled: io::command_available("tmux"),
    },

    tridactyl: #{
        targets: "~/.config/tridactyl",
        enabled: io::command_available("firefox") || io::command_available("librewolf"),
    },

    waybar: #{
        targets: "~/.config/waybar",
        templates: ["style.css"],
        enabled: data.wayland && io::command_available("waybar"),
    },

    "xdg-desktop-portal": #{
        targets: "~/.config/xdg-desktop-portal",
        enabled: data.wayland,
    },

    yazi: #{
        targets: "~/.config/yazi",
        enabled: io::command_available("yazi"),
    },

    zsh: #{
        targets: #{
            ".": "~/.config/zsh",
            ".zprofile": "~/.zprofile",
            ".zshrc": "~/.zshrc",
        },

        enabled: data.linux && io::command_available("zsh"),
    },
};

// vim: syntax=rust
