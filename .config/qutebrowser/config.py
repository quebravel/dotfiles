# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

c.fonts.tabs = "10.5pt tamzenforpowerline"
c.fonts.statusbar = "10.5pt tamzenforpowerline"
c.fonts.messages.info = "10.5pt tamzenforpowerline"
c.fonts.downloads = c.fonts.statusbar
c.fonts.prompts = "10.5pt tamzenforpowerline"
c.fonts.keyhint = c.fonts.messages.info
c.fonts.messages.warning = c.fonts.messages.info
c.fonts.messages.error = c.fonts.messages.info
c.fonts.completion.entry = "10.5pt tamzenforpowerline"
c.fonts.completion.category = c.fonts.statusbar
#c.fonts.hints = "13px tamzenforpowerline"

# colors
c.colors.contextmenu.disabled.fg = '#9c9c9c'
c.colors.contextmenu.menu.bg = '#3c3c3c'
c.colors.contextmenu.menu.fg = 'white'
c.colors.contextmenu.selected.bg = 'black'
c.colors.contextmenu.selected.fg = 'white'

# searches
c.url.searchengines['DEFAULT'] = 'https://www.duckduckgo.com/?q={}'
c.url.searchengines['g'] = 'https://www.google.com/search?q={}'
c.url.searchengines['m'] = 'https://www.google.com/maps?q={}'
c.url.searchengines['k'] = 'https://keep.google.com/#search/text%253D{}'
c.url.searchengines['w'] = 'http://pt.wikipedia.org/w/index.php?search={}&title=Special:Search'
c.url.searchengines['y'] = 'https://www.youtube.com/results?search_query={}'
c.url.searchengines['ar'] = 'https://wiki.archlinux.org/?search={}'
c.url.searchengines['v'] = 'https://wiki.voidlinux.org/?search={}'
c.url.searchengines['ge'] = 'https://wiki.gentoo.org/wiki/?search={}'
c.url.searchengines['t'] = 'https://translate.google.com/#view=home&op=translate&sl=en&tl=pt&text={}'
c.url.searchengines['r'] = 'https://reddit.com/r/{}'
c.url.searchengines['c'] = 'https://www.comandotorrents.com/?s={}'
c.url.searchengines['l'] = 'https://www.deepl.com/pt-BR/translator#en/pt/{}'
c.url.searchengines['b'] = 'https://bastos.bibipecas.com.br/search/{}'
c.url.searchengines['n'] = 'https://www.netflix.com/search?q={}'

# aliases
c.aliases['gh'] = 'open -t https://github.com/quebravel'
c.aliases['yt'] = 'open -r https://youtube.com'
c.aliases['rd'] = 'open -r https://reddit.com'
c.aliases['kp'] = 'open -t https://keep.google.com'
c.aliases['gm'] = 'open -t https://mail.google.com'
c.aliases['fd'] = 'open -t https://feedly.com'

# geral
c.new_instance_open_target = "tab"
c.tabs.background = True
c.downloads.location.directory = '$HOME/Downloads'
#  c.downloads.location.directory = "C:\\Users\\Jonatas\\Downloads"
c.spellcheck.languages = ["pt-BR"]
c.content.headers.accept_language = 'pt-BR,pt'
c.tabs.show = 'always' #multiple,never,always,switching
c.url.default_page = "https://start.duckduckgo.com/"
c.url.start_pages = "https://start.duckduckgo.com/"
c.tabs.select_on_remove = "prev"
c.content.notifications = False
c.content.autoplay = True
c.content.geolocation = True
c.tabs.mode_on_change = "persist"
c.tabs.title.format = "{index}: {current_title} {audio}"
c.colors.webpage.prefers_color_scheme_dark = True

# colors
c.colors.contextmenu.disabled.fg = '#9c9c9c'
c.colors.contextmenu.menu.bg = '#3c3c3c'
c.colors.contextmenu.menu.fg = 'white'
c.colors.contextmenu.selected.bg = 'black'
c.colors.contextmenu.selected.fg = 'white'

# keys
c.bindings.commands = {
        'normal': {
            #  '<tab>': 'nop',
            'gR': 'spawn urxvt -e ranger /home/jonatas/Downloads',
            ',n': 'config-cycle content.user_stylesheets  ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""',
            ',d': 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/apprentice/apprentice-all-sites.css ""',
            'xx': 'config-cycle statusbar.hide ;; config-cycle tabs.show always switching',
            'xd': 'set downloads.location.directory ~/Imagens ;; hint images download'
            }
        }

# plugins
# https://gitlab.com/jgkamat/jblock
#  import sys, os
#  sys.path.append(os.path.join(sys.path[0], 'jblock'))
#  config.source("jblock/jblock/integrations/qutebrowser.py")

# set qutebrowser colors

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = base0C

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base01

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = base00

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base06

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base03

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base04

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base01

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = base0A

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = base0A

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = base0A

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = base08

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0B

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg =  base05

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = base0A

#Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = base01

# Background color for the download bar.
c.colors.downloads.bar.bg = base00

# Color gradient start for download text.
c.colors.downloads.start.fg = base00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = base00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

# Font color for hints.
c.colors.hints.fg = base00

# Font color for the matched part of hints.
c.colors.hints.match.fg = base0G

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

# Foreground color for prompts.
c.colors.prompts.fg = base05

# Border used around UI elements in prompts.
c.colors.prompts.border = base00

# Background color for prompts.
c.colors.prompts.bg = base00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base0A

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base0B

# Background color of the statusbar.
c.colors.statusbar.normal.bg = base00

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base00

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = base0C

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base03

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = base05

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
c.colors.statusbar.progress.bg = base0C

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = base05

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = base08

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = base05


# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = base0E


# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base0G


# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base0G


# Background color for webpages if unset (or empty to use the theme's
# color).
# c.colors.webpage.bg = base00
