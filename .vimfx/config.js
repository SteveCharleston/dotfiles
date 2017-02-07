let options = {
  "hints.chars": "0123456789",
  "config_file_directory": "/home/steven/dotfiles/.vimfx/",
  "mode.normal.scroll_half_page_down": "<c-d>",
  "mode.normal.scroll_half_page_up": "<c-u>",
  "mode.normal.tab_select_previous": "J    gT <c-p>",
  "mode.normal.tab_select_next": "K    gt <c-n>",
  "mode.normal.tab_select_most_recent": "gl <c-o>",
  "mode.normal.tab_close": "x d",
  "mode.normal.tab_restore": "X u"
}
Object.entries(options).forEach(([option, value]) => vimfx.set(option, value))
