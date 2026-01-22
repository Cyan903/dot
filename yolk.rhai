import "colors" as colors;
import "hosts" as hosts;
import "utils" as utils;

const S = SYSTEM.hostname;

export let data = #{
    for_vcs: LOCAL,

    wayland: utils::wayland(S),
    colors: utils::color(S),
};

export let eggs = #{
    //
    // ~/.local/bin/*
    //
    "scripts": #{
        targets: "~/.local/bin",
        strategy: "merge",
        enabled: utils::enabled(S, #{
            requires: [],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "xscripts": #{
        targets: "~/.local/bin",
        strategy: "merge",
        enabled: utils::enabled(S, #{
            requires: [],
            tags: ["linux", "X11"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    //
    // ~/.local/share/*
    //
    "osuconfig": #{
        targets: "~/.local/share/osuconfig",
        strategy: "merge",
        enabled: utils::enabled(S, #{
            requires: ["osu-wine"],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "anki-plugins": #{
        targets: "~/.local/share/Anki2/addons21",
        strategy: "merge",
        enabled: utils::enabled(S, #{
            requires: ["anki"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    //
    // ~/.config/*
    //
    "X11": #{
        targets: "~/.config/X11",
        enabled: utils::enabled(S, #{
            requires: [],
            tags: ["linux", "X11"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "alacritty": #{
        targets: "~/.config/alacritty",
        templates: ["theme.toml"],
        enabled: utils::enabled(S, #{
            requires: ["alacritty"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "awesome": #{
        targets: "~/.config/awesome",
        templates: ["theme/main/theme.lua", "module/system/bin/lock"],
        enabled: utils::enabled(S, #{
            requires: ["awesome"],
            tags: ["linux", "X11"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "bash": #{
        targets: #{
            ".bashrc": "~/.bashrc",
            ".bash_profile": "~/.bash_profile",
        },

        enabled: utils::enabled(S, #{
            requires: ["bash"],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "fbterm": #{
        targets: "~/.config/fbterm",
        enabled: utils::enabled(S, #{
            requires: ["fbterm"],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "firefox": #{
        targets: "~/.config/firefox",
        templates: ["userHome.html"],
        enabled: utils::enabled(S, #{
            requires: ["firefox", "librewolf"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "ideavim": #{
        targets: "~/.config/ideavim",
        enabled: utils::enabled(S, #{
            requires: ["android-studio", "idea"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "mako": #{
        targets: "~/.config/mako",
        templates: ["config"],
        enabled: utils::enabled(S, #{
            requires: ["mako"],
            tags: ["linux", "wayland"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "mpv": #{
        targets: "~/.config/mpv",
        enabled: utils::enabled(S, #{
            requires: ["mpv"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "mvi": #{
        targets: "~/.config/mvi",
        enabled: utils::enabled(S, #{
            requires: ["mpv"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "niri": #{
        targets: "~/.config/niri",
        templates: ["config.kdl"],
        enabled: utils::enabled(S, #{
            requires: ["niri"],
            tags: ["linux", "wayland"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "nvim": #{
        targets: "~/.config/nvim",
        templates: ["lua/addons/plugins/lualine.lua"],
        enabled: utils::enabled(S, #{
            requires: ["nvim"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "rofi": #{
        targets: "~/.config/rofi",
        templates: ["config.rasi"],
        enabled: utils::enabled(S, #{
            requires: ["rofi"],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "screenlayout": #{
        targets: "~/.config/screenlayout",
        enabled: utils::enabled(S, #{
            requires: [],
            tags: ["linux", "X11"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "sesh": #{
        targets: "~/.config/sesh",
        enabled: utils::enabled(S, #{
            requires: ["sesh", "tmux"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "shell": #{
        targets: "~/.config/shell",
        templates: ["script/login"],
        enabled: utils::enabled(S, #{
            requires: ["bash", "zsh"],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "tmux": #{
        targets: "~/.config/tmux",
        templates: ["tmux.conf"],
        enabled: utils::enabled(S, #{
            requires: ["tmux"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "tridactyl": #{
        targets: "~/.config/tridactyl",
        enabled: utils::enabled(S, #{
            requires: ["firefox", "librewolf"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "waybar": #{
        targets: "~/.config/waybar",
        templates: ["style.css", "bin/swaylock-wrapper"],
        enabled: utils::enabled(S, #{
            requires: ["waybar"],
            tags: ["linux", "wayland"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "xdg-desktop-portal": #{
        targets: "~/.config/xdg-desktop-portal",
        enabled: utils::enabled(S, #{
            requires: [],
            tags: ["linux", "wayland"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "yazi": #{
        targets: "~/.config/yazi",
        enabled: utils::enabled(S, #{
            requires: ["yazi"],
            tags: [],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },

    "zsh": #{
        targets: #{
            ".": "~/.config/zsh",
            ".zprofile": "~/.zprofile",
            ".zshrc": "~/.zshrc",
        },

        enabled: utils::enabled(S, #{
            requires: ["zsh"],
            tags: ["linux"],
            hosts: [
                hosts::devices.puter,
            ],
        }),
    },
};

// vim: syntax=rust
