function _G.ReloadConfig(module_name)
  module_name = module_name or ""

  for name, _ in pairs(package.loaded) do
    if name:match("^" .. module_name) then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration has been reloaded!", vim.log.levels.INFO)
end


