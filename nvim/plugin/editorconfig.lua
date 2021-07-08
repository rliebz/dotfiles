-- Prefer existing indentation over editorconfig
vim.g.sleuth_automatic = 0
vim.cmd([[call editorconfig#AddNewHook({->execute(':Sleuth')})]])
