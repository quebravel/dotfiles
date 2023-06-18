# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# Solarized Dark scheme by Ethan Schoonover (modified by aramisgithub)
# Gruvbox Light
base00 = "#4fd6be"
base01 = "#41a6b5"
base02 = "#9aa5ce"
base03 = "#d5d6db"
base04 = "#565f89"
base05 = "#414868"
base06 = "#24283b"
base07 = "#1a1b26"
base08 = "#f7768e"
base09 = "#ff9e64"
base0A = "#c8d3f5"
base0B = "#9ece6a"
base0C = "#bb9af7"
base0D = "#c3e88d"
base0E = "#73daca"
base0F = "#bb9af7"
base0G = "#ff007c"
base0H = "#b4f9f8"
base0I = "#3e68d7"
base0J = "#f2f2f2"


# set qutebrowser colors
# Background color of the tab bar.
c.colors.tabs.bar.bg = base00
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.indicator.error = base08
c.colors.tabs.odd.fg = base05
c.colors.tabs.odd.bg = base03
c.colors.tabs.even.fg = base03
c.colors.tabs.even.bg = base04
c.colors.tabs.pinned.even.bg = base0C
c.colors.tabs.pinned.even.fg = base07
c.colors.tabs.pinned.odd.bg = base0B
c.colors.tabs.pinned.odd.fg = base07
c.colors.tabs.pinned.selected.even.bg = base02
c.colors.tabs.pinned.selected.even.fg = base05
c.colors.tabs.pinned.selected.odd.bg = base02
c.colors.tabs.pinned.selected.odd.fg = base05
c.colors.tabs.selected.odd.fg = base06
c.colors.tabs.selected.odd.bg = base00
c.colors.tabs.selected.even.fg = base06
c.colors.tabs.selected.even.bg = base00

# End tabs colors

# cor fg | sites no "o" open.
c.colors.completion.fg = base0I

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base0J

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = base03

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base06

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base0A

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base0J

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base02

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base0G
c.colors.completion.item.selected.bg = base0D
c.colors.completion.item.selected.border.top = base0B
c.colors.completion.item.selected.border.bottom = base0C

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = base07
# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0G

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00
c.colors.contextmenu.menu.fg =  base05
c.colors.contextmenu.selected.bg = base0C
c.colors.contextmenu.selected.fg = base0G
c.colors.contextmenu.disabled.bg = base01
c.colors.contextmenu.disabled.fg = base03

# Background color for the download bar.
c.colors.downloads.bar.bg = base01
c.colors.downloads.start.fg = base08
c.colors.downloads.start.bg = base0D
c.colors.downloads.stop.fg = base07
c.colors.downloads.stop.bg = base09
c.colors.downloads.error.fg = base08

# Foreground color of an error message.
c.colors.messages.error.fg = base00

# Background color of an error message.
c.colors.messages.error.bg = base08

# Border color of an error message.
c.colors.messages.error.border = base08

# Foreground color of a warning message.
c.colors.messages.warning.fg = base00

# Background color of a warning message.
c.colors.messages.warning.bg = base0E

# Border color of a warning message.
c.colors.messages.warning.border = base0E

# Foreground color of an info message.
c.colors.messages.info.fg = base05

# Background color of an info message.
c.colors.messages.info.bg = base00

# Border color of an info message.
c.colors.messages.info.border = base00

# Background color for prompts downloads.
c.colors.prompts.bg = base03
c.colors.prompts.fg = base05
c.colors.prompts.border = '0.5px solid #3e68d7'
c.colors.prompts.selected.bg = base03

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base06
c.colors.statusbar.normal.bg = base0A
# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base00

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = base0C

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base03

# Foreground color of the statusbar in command mode onde digita a URL.
c.colors.statusbar.command.fg = base06

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = base00

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = base05

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base00

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = base00

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base0E

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = base00

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base0D

# Background color of the progress bar.
c.colors.statusbar.progress.bg = base0D

# Default color of the URL in the statusbar.
c.colors.statusbar.url.fg = base07
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.hover.fg = base05
c.colors.statusbar.url.warn.fg = base0G
c.colors.statusbar.url.success.http.fg = base04
c.colors.statusbar.url.success.https.fg = base06

c.colors.keyhint.fg = base07
c.colors.keyhint.suffix.fg = base0G
c.colors.keyhint.bg = 'rgba(200, 211, 245, 97%)'

# Font color for hints.
c.colors.hints.fg = base07
c.colors.hints.bg = base00
c.colors.hints.match.fg = base0A
c.hints.border = "0px"

c.colors.statusbar.insert.fg = base00
c.colors.statusbar.insert.bg = base09

c.colors.webpage.bg = base03
