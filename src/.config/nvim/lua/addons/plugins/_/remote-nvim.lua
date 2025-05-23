-- Remote development
-- :help remote-nvim
return {
    "amitds1997/remote-nvim.nvim",

    enabled = false,

    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
    },

    config = true,
}
