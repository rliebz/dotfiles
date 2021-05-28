function reload()
  for pack, _ in pairs(package.loaded) do
    if string.match(pack, '^cfg%.') then
      package.loaded[pack] = nil
    end
  end
end
