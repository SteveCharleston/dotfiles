return {
    "skywind3000/vim-quickui",

    keys = {
        { "<M-m>", "<cmd>call quickui#menu#open()<cr>", desc = "Toggle QuickUI Menu" },
        { "µ",     "<cmd>call quickui#menu#open()<cr>", desc = "Toggle QuickUI Menu" },
    },

    init = function()
        -- enable to display tips in the cmdline
        vim.g.quickui_show_tip = 1
        vim.g.quickui_border_style = 3
    end,

    config = function()
        vim.cmd([[
        " clear all the menus
        call quickui#menu#reset()

        " install a 'File' menu, use [text, command] to represent an item.
        call quickui#menu#install('&File', [
        \ [ "&New File", ':enew' ],
        \ [ "&Open File", ':CtrlP' ],
        \ [ "&Close", ':q' ],
        \ [ "--", '' ],
        \ [ "&Save", ':w'],
        \ [ "Save &All", ':wa' ],
        \ [ "--", '' ],
        \ [ "E&xit", ':qa' ],
        \ ])

        call quickui#menu#install("&Code", [
        \ ["Show &Errors", 'lopen'],
        \ ["&Next Error", 'ALENext'],
        \ ["&Previous Error", 'ALEPrevious'],
        \ ["GoTo &Definition", 'execute "normal \<Plug>(coc-definition)"'],
        \ ["GoTo &Type Definition", 'execute "normal \<Plug>(coc-type-definition)"'],
        \ ["GoTo &Implementation", 'execute "normal \<Plug>(coc-implementation)"'],
        \ ["Show &References", 'execute "normal \<Plug>(coc-references)"'],
        \ ["Rename &Symbol", 'execute "normal \<Plug>(coc-rename)"'],
        \ ["S&ort Imports", "call CocAction('runCommand', 'editor.action.organizeImport')"],
        \ ])

        call quickui#menu#install("&Option", [
        \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
        \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
        \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
        \ ["&Rainbow Parens", 'RainbowToggle'],
        \ ])

        call quickui#menu#install("&Tools", [
        \ ["&Gundo Tree", 'MundoToggle'],
        \ ["&Undo Tree", 'UndotreeToggle'],
        \ ["&Tagbar", 'TagbarToggle'],
        \ ["Tag&list", 'TlistToggle'],
        \ ["&Vista Taglist", 'TlistToggle'],
        \ ["&Dateien", 'TlistToggle'],
        \ ["&Calendar", 'CalendarH'],
        \ ])

        call quickui#menu#install("&Git", [
        \ ["&Status", 'Gstatus'],
        \ ["&History", 'GV'],
        \ ["&Branches", 'Twiggy'],
        \ ["&Complex Branches", 'Merginal'],
        \ ["Blame &Line", 'execute "normal \<Plug>(git-messenger)"'],
        \ ["Bl&ame", 'Gblame'],
        \ ])

        call quickui#menu#install("&VCS", [
        \ ["&Status", 'VCStatus'],
        \ ["&Add", 'VCAdd'],
        \ ["Add This &File", 'VCSAdd'],
        \ ["&Commit This File", 'VCSCommit'],
        \ ["&Diff to Head", 'VCSDiff'],
        \ ["&Blame", 'VCBlame'],
        \ ["&Log", 'VCSLog'],
        \ ["Repo &Info", 'VCInfo'],
        \ ])

        " register HELP menu with weight 10000 to make it the last menu
        call quickui#menu#install('H&elp', [
        \ ["&Cheatsheet", 'help index', ''],
        \ ['T&ips', 'help tips', ''],
        \ ['--',''],
        \ ["&Tutorial", 'help tutor', ''],
        \ ['&Quick Reference', 'help quickref', ''],
        \ ['&Summary', 'help summary', ''],
        \ ], 10000)
        ]])
    end,
}
