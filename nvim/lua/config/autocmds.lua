-- au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Jump to last position when reopening a file",
    pattern = "*",
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 1 and last_pos <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    pattern = "*",
    callback = function()
        vim.hl.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

-- Yank-ring: store yanked text in registers 1-9.
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
    if vim.v.event.operator == 'y' then
        for i = 9, 1, -1 do -- Shift all numbered registers.
        vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
        end
    end
    end,
})
