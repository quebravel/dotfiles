# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# Solarized Dark scheme by Ethan Schoonover (modified by aramisgithub)

# Gruvbox
base00 = "#282828"
base01 = "#3c3836"
base02 = "#504945"
base03 = "#665c54"
base04 = "#bdae93"
base05 = "#d5c4a1"
base06 = "#ebdbb2"
base07 = "#fbf1c7"
base08 = "#fb4934"
base09 = "#fe8019"
base0A = "#fabd2f"
base0B = "#b8bb26"
base0C = "#8ec07c"
base0D = "#83a598"
base0E = "#d3869b"
base0F = "#d65d0e"

# set qutebrowser colors
# Background color of the tab bar.
c.colors.tabs.bar.bg = base00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = base03

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = base03

# Background color of unselected even tabs.
c.colors.tabs.even.bg = base04

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = base0C

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = base07

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = base0B

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = base07

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = base02

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = base05

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = base02

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = base05

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base06

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base00

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base06

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base00

# End tabs colors

# cor fg | sites no "o" open.
c.colors.completion.fg = base07

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base00
c.colors.completion.even.bg = base01

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base06
c.colors.completion.category.bg = base03

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base04

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base01
c.colors.completion.item.selected.bg = base09
c.colors.completion.item.selected.border.top = base0A
c.colors.completion.item.selected.border.bottom = base0F

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = base07
# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0B

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00
c.colors.contextmenu.menu.fg =  base05
c.colors.contextmenu.selected.bg = base0C
c.colors.contextmenu.selected.fg = base01
c.colors.contextmenu.disabled.bg = base01
c.colors.contextmenu.disabled.fg = base03

# Background color for the download bar.
c.colors.downloads.bar.bg = base00
c.colors.downloads.start.fg = base00
c.colors.downloads.start.bg = base0D
c.colors.downloads.stop.fg = base00
c.colors.downloads.stop.bg = base0C
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

# Background color for prompts.
c.colors.prompts.bg = base00
c.colors.prompts.fg = base04
c.colors.prompts.border = '0.5px solid #fe8019'
c.colors.prompts.selected.bg = base0A

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base0B
c.colors.statusbar.normal.bg = base00

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
c.colors.statusbar.command.bg = base01

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
c.colors.statusbar.progress.bg = base09

# Default color of the URL in the statusbar.
c.colors.statusbar.url.fg = base05
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.hover.fg = base05
c.colors.statusbar.url.warn.fg = base0E
c.colors.statusbar.url.success.http.fg = base0C
c.colors.statusbar.url.success.https.fg = base06

c.colors.keyhint.fg = base07
c.colors.keyhint.suffix.fg = base0A
c.colors.keyhint.bg = 'rgba(40, 40, 40, 97%)'

# Font color for hints.
# c.colors.hints.fg = base00
c.colors.hints.fg = 'black'
# c.colors.hints.bg = base09
c.colors.hints.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 rgba(250, 199, 0, 0.9), stop:1 rgba(255, 109, 0, 0.9))'
c.colors.hints.match.fg = base07
c.hints.border = "0px"

c.colors.statusbar.insert.fg = base00
c.colors.statusbar.insert.bg = base09

# c.colors.webpage.bg = base05
