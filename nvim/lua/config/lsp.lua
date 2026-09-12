local function is_nixos()
  return vim.uv.fs_stat("/etc/NIXOS") ~= nil
end

if is_nixos() then
  -- NixOS: LSPs are installed system-wide via Nix and already on $PATH.
  -- Configure lspconfig directly, skip Mason entirely.
    local servers = { "clangd", "eslint", "jedi_language_server", "nil", "rust_analyzer" }
  -- Add whichever servers you've installed via Nix.
  -- Since they're already on $PATH, you don't need to specify `cmd`.
    vim.lsp.enable(servers)
end
