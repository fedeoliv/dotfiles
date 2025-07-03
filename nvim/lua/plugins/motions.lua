return {
  -- move lines and selections up and down
  {
    "matze/vim-move",
    event = "VeryLazy",
  },

  -- replace existing text with contents from a register
  {
    "vim-scripts/ReplaceWithRegister",
    event = "VeryLazy",
  },

  -- w,e,b motions considering camelCase, snake_case and kebab-case as punctuation
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    vscode = true,
  },
}
