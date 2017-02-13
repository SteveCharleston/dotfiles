let map = (shortcuts, command, custom=false) => {
    vimfx.set(`${custom ? 'custom.' : ''}mode.normal.${command}`, shortcuts)
}

let options = {
  "hints.chars": "0123456789",
  "hints.sleep": -1,
  "prevent_autofocus": true,
  "prev_patterns": "prev  previous  ‹  «  ◀  ←  <<  <  back  newer  nächste",
  "next_patterns": "next  ›  »  ▶  →  >>  >  more  older  vorherige",
  "mode.normal.scroll_half_page_down": "<c-d>",
  "mode.normal.scroll_half_page_up": "<c-u>",
  "mode.normal.tab_select_previous": "J    gT <c-p>",
  "mode.normal.tab_select_next": "K    gt <c-n>",
  "mode.normal.tab_select_most_recent": "gl <c-o>",
  "mode.normal.tab_close": "x d",
  "mode.normal.tab_restore": "X u"
}
Object.entries(options).forEach(([option, value]) => vimfx.set(option, value))

// search trought open buffers
let {commands} = vimfx.modes.normal
vimfx.addCommand({
        name: 'search_tabs',
        description: 'Search tabs',
        category: 'tabs',
        order: commands.focus_location_bar.order + 1,
}, (args) => {
    let {vim} = args
    let {gURLBar} = vim.window
    gURLBar.value = ''
    commands.focus_location_bar.run(args)
    // Change the `*` on the text line to a `%` to search tabs instead of bookmarks.
    gURLBar.value = '% '
    gURLBar.onInput(new vim.window.KeyboardEvent('input'))
})

// search for selected text
vimfx.addCommand({
        name: 'search_selected_text',
        description: 'Search for the selected text',
}, ({vim}) => {
    let {messageManager} = vim.window.gBrowser.selectedBrowser
    vimfx.send(vim, 'getSelection', null, selection => {
            let inTab = true // Change to `false` if you’d like to search in current tab.
            vim.window.BrowserSearch.loadSearch(selection, inTab)
    })
})

vimfx.addCommand({
        name: 'tab_close_left_tab',
        description: 'Close tab to the left',
        category: 'tabs',
        order: commands.tab_close_to_end.order + 1,
}, ({vim}) => {
    let {gBrowser} = vim.window
    let {currentIndex} = gBrowser.visibleTabs.indexOf(gBrowser.selectedTab)
    gBrowser.moveTabTo(gBrowser.selectedTab, gBrowser.selectedTab._tPos - 1)
    gBrowser.removeTab(gBrowser.selectedTab)
    //Array.slice(gBrowser.tabs, gBrowser.selectedTab._tPos - 1, gBrowser.selectedTab._tPos)
    //.forEach(tab => gBrowser.removeTab(tab))
})

map('b', 'search_tabs', true)
map('*', 'search_selected_text', true)
map('D', 'tab_close_left_tab', true)
